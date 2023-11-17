from flask import Flask, render_template, request, redirect, url_for, request, session
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
import mysql.connector

app = Flask(
    __name__, static_url_path="", static_folder="static/Lost And Found font-end/public"
)

connection = mysql.connector.connect(
    host="localhost", port="3306", database="lostnfounddb", user="root", password=""
)

cursor = connection.cursor()
<<<<<<< Updated upstream
app.secret_key = "your secret key"
=======
app.secret_key = "baltao_da_goat"
>>>>>>> Stashed changes


@app.route("/")
def landing():
    return render_template("landing.html")


@app.route("/register", methods=["POST", "GET"])
def register():
    if request.method == "POST":
<<<<<<< Updated upstream
        stud_num = request.form["stud_id"]
=======
        studnum = request.form["stud_id"]
>>>>>>> Stashed changes
        username = request.form["username"]
        password = request.form["password"]
        confirm_password = request.form["confirm_password"]
        email = request.form["email"]

<<<<<<< Updated upstream
        if password != confirm_password:
=======
        if passwd != confirm_passwd:
            error_message = "Passwords do not match."
            error_status = "error"
            show_sweetalert = True
>>>>>>> Stashed changes
            return render_template(
                "register.html",
                text=error_message,
                text_status=error_status,
                show_sweetalert=show_sweetalert,
            )

<<<<<<< Updated upstream
        cursor.execute(
            """
            SELECT col_username, col_studNum, col_email
            FROM tbl_user
            WHERE col_username = %s OR col_studNum = %s OR col_email = %s
            """,
            (username, stud_num, email),
        )
=======
        query = "SELECT col_username, col_studNum, col_email FROM tbl_user WHERE col_username = %s OR col_studNum = %s OR col_email = %s"
        cursor.execute(query, (username, studnum, email))
>>>>>>> Stashed changes
        existing_records = cursor.fetchall()
        errors = {
            "username": "Username already exists.",
            "stud_num": "Student Id already exists.",
            "email": "Email address already exists.",
        }

        for record in existing_records:
            if record[0] == username:
                error_key = "username"
            elif record[1] == stud_num:
                error_key = "stud_num"
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
        cursor.execute(query, (stud_num, username, email, password))
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
<<<<<<< Updated upstream
            session["username"] = username
=======
            session["user"] = user
>>>>>>> Stashed changes
            return redirect(url_for("home"))

        text = "Incorrect Username or Password!"
        text_status = "error"
<<<<<<< Updated upstream
        show_sweetalert = True

    else:
        text = ""
        text_status = ""
        show_sweetalert = False

    return render_template(
        "login.html",
        text=text,
        text_status=text_status,
        show_sweetalert=show_sweetalert,
    )
=======
        return render_template(
            "login.html", text=text, text_status=text_status, show_sweetalert=True
        )

    return render_template("login.html")
>>>>>>> Stashed changes


@app.route("/home")
def home():
    if "user" in session:
        return render_template("home.html")
    else:
        return redirect(url_for("login"))


<<<<<<< Updated upstream
@app.route("/dashboard")
def dashboard():
    if "username" in session:
        return "Welcome %s" % session["username"]
    return redirect(url_for("login"))


@app.route("/claimed.html")
=======
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
>>>>>>> Stashed changes
def claimed():
    if "user" in session:
        return render_template("Claimed.html")
    else:
        return redirect(url_for("login"))


<<<<<<< Updated upstream
=======
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


>>>>>>> Stashed changes
if __name__ == "__main__":
    app.run(debug=True)
