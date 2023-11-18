from flask import Flask, render_template, request, redirect, url_for, request, session
import mysql.connector
import os

app = Flask(__name__, static_url_path="", static_folder="static")

connection = mysql.connector.connect(
    host="localhost", port="3306", database="lostnfounddb", user="root", password="105671080088"
)

PICS_FOLDER = os.path.join(app.root_path, 'static/pics')
app.config['UPLOAD_FOLDER'] = PICS_FOLDER

cursor = connection.cursor()
app.secret_key = "baltao_da_goat"


@app.route("/")
def landing():
    return render_template("landing.html")


@app.route("/register", methods=["POST", "GET"])
def register():
    if request.method == "POST":
        studnum = request.form["stud_id"]
        username = request.form["username"]
        password = request.form["password"]
        confirm_password = request.form["confirm_password"]
        email = request.form["email"]

        if password != confirm_password:
            error_message = "Passwords do not match."
            error_status = "error"
            show_sweetalert = True
            return render_template(
                "register.html",
                text=error_message,
                text_status=error_status,
                show_sweetalert=show_sweetalert,
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
            if record[0] == username:
                error_key = "username"
            elif record[1] == studnum:
                error_key = "studnum"
            elif record[2] == email:
                error_key = "email"
            else:
                continue
            error_message = errors[error_key]
            error_status = "error"
            show_sweetalert = True
            return render_template(
                "register.html",
                text=error_message,
                text_status=error_status,
                show_sweetalert=show_sweetalert,
            )

        query = "CALL createUser(%s,%s,%s,%s)"
        cursor.execute(query, (studnum, username, email, password))
        connection.commit()
        text = "Account created successfully."
        text_status = "success"
        show_sweetalert = True
        return render_template(
            "register.html",
            text=text,
            text_status=text_status,
            show_sweetalert=show_sweetalert,
        )

    return render_template("register.html")


@app.route("/login", methods=["POST", "GET"])
def login():
    if request.method == "POST":
        username = request.form.get("username", "")
        password = request.form.get("password", "")
        query = "SELECT * FROM tbl_user WHERE col_username = %s AND col_password = %s"
        cursor.execute(query, (username, password))
        user = cursor.fetchone()

        if user:
            session["user"] = user
            session["user_id"] = user[0]
            session["user_role"] = user[5]
            return redirect(url_for("home"))

        text = "Incorrect Username or Password!"
        text_status = "error"
        return render_template(
            "login.html", text=text, text_status=text_status, show_sweetalert=True
        )

    return render_template("login.html")


@app.route("/home")
def home():
    if "user" in session:

        print(session["user_id"])
        print(session["user_role"])
        return render_template("home.html")
    else:
        return redirect(url_for("login"))



@app.route("/all_items")
def All_items():
    if "user" in session:
        return render_template("all_items.html")
    else:
        return redirect(url_for("login"))



@app.route("/dashboard")
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


@app.route("/claimed")
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
        user_role = 'user'
    elif session["user_role"] == 1:
        user_role = 'admin'
    if request.method == "POST":
        item_name = request.form["item_name"]
        description = request.form["description"]
        pictures = request.files.getlist("pics")
        user_id = 3

        if item_name and description and pictures:
                query = "call createpost(%s,%s,%s,%s)"
                cursor.execute(query, (item_name, description, user_id, user_role))
                cursor.execute("select last_insert_id() from tbl_lostpost limit 1")
                postid = cursor.fetchone()[0]

                for pic in pictures:
                    file_name = (pic.filename)
                    file_path = os.path.join(app.config['UPLOAD_FOLDER'], file_name)

                    query = "call insertpic(%s,%s,%s)"
                    cursor.execute(query, (postid, file_path, user_role))

                    pic.save(file_path)

                connection.commit()
                return "Upload successful"

    return "Missing Data"

if __name__ == "__main__":
    app.run(debug=True)
