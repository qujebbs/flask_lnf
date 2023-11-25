from flask import Flask, render_template, request, redirect, url_for, request, session
import bcrypt
import mysql.connector
import os
import secrets
import smtplib
from email.mime.text import MIMEText

app = Flask(__name__, static_url_path="", static_folder="static")

connection = mysql.connector.connect(
    host="localhost", port="3306", database="lostandfound", user="root", password="105671080088"
)

PICS_FOLDER = os.path.join(app.root_path, "static/pics")
app.config["UPLOAD_FOLDER"] = PICS_FOLDER

cursor = connection.cursor()
app.secret_key = "baltao_da_goat"
token = secrets.token_urlsafe(32)

@app.route("/")
def landing():
    return render_template("landing.html")


@app.route("/register", methods=["POST", "GET"])
def register():
    if request.method == "POST":
        studnum = request.form["stud_id"]
        username = request.form["username"]
        password = request.form["password"].encode("utf-8")
        confirm_password = request.form["confirm_password"].encode("utf-8")
        email = request.form["email"]

        error_checks = [
            (len(password) < 8, "Password should be at least 8 characters long."),
            (password != confirm_password, "Passwords do not match."),
        ]

        for check, message in error_checks:
            if check:
                return render_with_alert(
                    "register.html",
                    text=message,
                    text_status="error",
                    studnum=studnum,
                    username=username,
                    email=email,
                )

        query = "SELECT col_username, col_studNum, col_email FROM tbl_user WHERE col_username = %s OR col_studNum = %s OR col_email = %s"
        cursor.execute(query, (username, studnum, email))
        existing_records = cursor.fetchall()

        errors = {
            "username": "Username already exists.",
            "studnum": "Student Id already exists.",
            "email": "Email address already exists.",
        }

        for record in existing_records:
            for i, error_key in enumerate(errors.keys()):
                if record[i] == locals()[error_key]:
                    return render_with_alert(
                        "register.html",
                        text=errors[error_key],
                        text_status="error",
                    )

        hashed_password = bcrypt.hashpw(password, bcrypt.gensalt())
        query = "CALL createUser(%s,%s,%s,%s)"
        cursor.execute(query, (studnum, hashed_password, email, username))
        connection.commit()

        return render_with_alert(
            "register.html",
            text="Account created successfully.",
            text_status="success",
        )

    return render_template("register.html")


@app.route("/login", methods=["POST", "GET"])
def login():
    if request.method == "POST":
        username = request.form.get("username", "")
        password = request.form.get("password", "").encode("utf-8")
        query = "SELECT * FROM tbl_user WHERE col_username = %s "
        cursor.execute(query, (username,))
        user = cursor.fetchone()

        if user and bcrypt.checkpw(password, user[3].encode("utf-8")):
            session.update({"user": user, "user_id": user[0], "user_role": user[5]})
            return redirect(url_for("dashboard"))

        return render_with_alert(
            "login.html", text="Incorrect Username or Password!", text_status="error"
        )

    return render_template("login.html")



@app.route("/all_items")
def All_items():
    if "user" in session:
        return render_template("all_items.html")
    else:
        return redirect(url_for("login"))
    
@app.route("/mypost", methods=["GET", "POST"])
def mypost():
    if "user" in session:
        return render_template("mypost.html")
    else:
        return redirect(url_for("login"))

@app.route("/dashboard", methods=["GET", "POST"])
def dashboard():
    if "user" in session:
        return render_template("dashboard.html")
    else:
        return redirect(url_for("login"))


@app.route("/found")
def found():
    if "user" in session:
        return render_template("Found.html")
    else:
        return redirect(url_for("login"))

@app.route("/users", methods=["GET", "POST"])
def users():
    if "user" in session:
        return render_template("users.html")
    else:
        return redirect(url_for("login"))

@app.route("/claimed" , methods=["GET", "POST"])
def claimed():
    if "user" in session:
        return render_template("Claimed.html")
    else:
        return redirect(url_for("login"))


@app.route("/lost", methods=["POST", "GET"])
def lost():
    if "user" in session:
        return render_template("Lost.html")
    else:
        return redirect(url_for("login"))


@app.route("/requests")
def requests():
    if "user" in session:
        return render_template("Requests.html")
    else:
        return redirect(url_for("login"))


@app.route("/unclaimed")
def unclaimed():
    if "user" in session:
        return render_template("Unclaimed.html")
    else:
        return redirect(url_for("login"))


@app.route("/logs")
def logs():
    if "user" in session:
        return render_template("logs.html")
    else:
        return redirect(url_for("login"))


@app.route("/logout")
def logout():
    session.pop("user", None)
    return render_template("login.html")


@app.route("/upload", methods=["POST"])
def upload():
    if session["user_role"] == 2:
        user_role = "user"
        statusID = 2
    elif session["user_role"] == 1:
        user_role = "admin"
        statusID = 1
    if request.method == "POST":
        item_name = request.form["item_name"]
        description = request.form["description"]
        pictures = request.files.getlist("pics")
        user_id = 3

        if item_name and description and pictures:
            query = "call createpost(%s,%s,%s,%s,%s)"
            cursor.execute(
                query, (item_name, description, statusID, user_id, user_role)
            )
            cursor.execute(
                "SELECT last_insert_id() AS 'postID' FROM tbl_foundpost LIMIT 1"
            )
            postid = cursor.fetchone()[0]

            for pic in pictures:
                file_name = pic.filename
                file_path = os.path.join(app.config["UPLOAD_FOLDER"], file_name)

                query = "call insertpic(%s,%s,%s)"
                cursor.execute(query, (postid, file_path, user_role))

                pic.save(file_path)

            connection.commit()
            return render_with_alert(
                "dashboard.html",
                text="Upload Successful.",
                text_status="success",
            )

    return render_with_alert(
        "dashboard.html",
        text="Incorrect Username or Password!",
        text_status="error",
    )


@app.route("/forgot_password", methods=["GET", "POST"])
def forgot_password():
    if request.method == "POST":
        email = request.form["email"]

        # Check if the email exists in the database
        query = "SELECT * FROM tbl_user WHERE col_email = %s"
        cursor.execute(query, (email,))
        user = cursor.fetchone()

        if user:
            token = secrets.token_hex(16)
            send_password_reset_email(user[4], user[3], token)

        else:
            print("Email not found")
        return render_template(
            "forgot-password.html", message="Password reset email sent."
        )

    # Render the forgot password form
    return render_template("forgot-password.html")


def send_password_reset_email(email, hashed_password, token):
    sender_email = "johnmiller.asz8@gmail.com"  # Replace with your email address
    password = "utkk gxyl whdq grgt"  # Replace with your email password

    # Compose the email message
    subject = "Password Reset"
    # body = f"Click the link below to reset your password:\n\nhttp://example.com/reset_password?token={token}"
    body = f"Your password is: {hashed_password}"
    message = MIMEText(body)
    message["Subject"] = subject
    message["From"] = sender_email
    message["To"] = email

    # Send the email
    with smtplib.SMTP("smtp.gmail.com", 587) as server:
        server.starttls()
        server.login(sender_email, password)
        server.send_message(message)


def render_with_alert(template, **kwargs):
    return render_template(template, show_sweetalert=True, **kwargs)


if __name__ == "__main__":
    app.run(debug=True)
