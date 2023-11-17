from flask import Flask, render_template, request, redirect, url_for, request

import mysql.connector

app = Flask(
    __name__, static_url_path="", static_folder="static/Lost And Found font-end/public"
)

connection = mysql.connector.connect(
    host="localhost", port="3306", database="lostnfounddb", user="root", password="105671080088"
)

cursor = connection.cursor()


@app.route("/")
def landing():
    return render_template("landing.html")


@app.route("/register", methods=["POST", "GET"])
def register():
    if request.method == "POST":
        # Get user input from the form and store it in variables
        studnum = request.form["stud_id"]
        username = request.form["username"]
        passwd = request.form["password"]
        confirm_passwd = request.form["confirm_password"]
        email = request.form["email"]

        # Check if both passwords match
        if passwd != confirm_passwd:
            return render_template(
                "register.html",
                text="Passwords do not match.",
                text_status="error",
                show_sweetalert=True,
            )

        # Check if the username, student number, or email already exist in the database
        cursor.execute(
            "SELECT col_username, col_studNum, col_email FROM tbl_user WHERE col_username = %s OR col_studNum = %s OR col_email = %s",
            (username, studnum, email),
        )
        existing_records = cursor.fetchall()
        errors = {
            "username": "Username already exists.",
            "studnum": "Student Id already exists.",
            "email": "Email address already exists.",
        }

        # Check for errors in the existing records
        for record in existing_records:
            if record[0] == username:
                error_key = "username"
            elif record[1] == studnum:
                error_key = "studnum"
            elif record[2] == email:
                error_key = "email"
            else:
                continue
            return render_template(
                "register.html",
                text=errors[error_key],
                text_status="error",
                show_sweetalert=True,
            )

        # Insert the user into the database
        query = "CALL createUser(%s,%s,%s,%s)"
        cursor.execute(query, (studnum, username, email, passwd))
        connection.commit()
        text = "Account created successfully."
        text_status = "success"
        return render_template(
            "register.html", text=text, text_status=text_status, show_sweetalert=True
        )
    return render_template("register.html")


@app.route("/login", methods=["POST", "GET"])
def login():
    if request.method == "POST":
        username = request.form.get("username", "")
        password = request.form.get("password", "")
        cursor.execute(
            "SELECT * FROM tbl_user WHERE col_username = %s AND col_password = %s",
            (username, password),
        )
        user = cursor.fetchone()
        if user:
            return redirect(url_for("home"))
        else:
            text = "Incorrect Username or Password!"
            text_status = "error"
            return render_template(
                "login.html", text=text, text_status=text_status, show_sweetalert=True
            )
    return render_template("login.html")


@app.route("/home")
def home():
    return render_template("home.html")


@app.route("/dashboard")
def dashboard():
    return render_template("dashboard.html")


@app.route("/claimed.html")
def claimed():
    return render_template("Claimed.html")


if __name__ == "__main__":
    app.run(debug=True)
