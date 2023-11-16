from flask import (
    Flask,
    render_template,
    request,
    redirect,
    url_for,
    request,
)
import mysql.connector

app = Flask(
    __name__, static_url_path="", static_folder="static/Lost And Found font-end/public"
)

connection = mysql.connector.connect(
    host="localhost", port="3306", database="lostnfounddb", user="root", password=""
)

cursor = connection.cursor()

# def installdb():
#     try:
#         create_table = """
#         CREATE TABLE IF NOT EXISTS  (

#         )
#     """
#         cursor.execute(create_table)
#         print("table created")
#     except mysql.connector.Error as e:
#         print("error in mysql")
#     finally:
#         cursor.close()


@app.route("/")
def landing():
    return render_template("landing.html")


@app.route("/register", methods=["POST", "GET"])
def register():
    if request.method == "POST":
        # Get user input from the form
        studnum = request.form["stud_id"]
        username = request.form["username"]
        passwd = request.form["password"]
        email = request.form["email"]

        # Check if the username, student number, or email already exist in the database (maya ko nalang ayusin return ang pangit pa)
        cursor.execute(
            "SELECT col_username, col_studNum, col_email FROM tbl_user WHERE col_username = %s OR col_studNum = %s OR col_email = %s",
            (username, studnum, email),
        )
        existing_records = cursor.fetchall()

        if any(record[0] == username for record in existing_records):
            return "Username already exists. Please choose a different username."
        elif any(record[1] == studnum for record in existing_records):
            return "Student number already exists. Please enter a different student number."
        elif any(record[2] == email for record in existing_records):
            return "Email already exists. Please enter a different email address."

        # Insert the user into the database
        cursor.execute(
            "INSERT INTO tbl_user (col_userID, col_studNum, col_username, col_password, col_email) VALUES (NULL, %s, %s, %s, %s)",
            (studnum, username, passwd, email),
        )
        connection.commit()

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
        users = cursor.fetchall()

        if users:
            return redirect(url_for("home"))
        else:
            return "Invalid Username and Password combination. Please enter different values.."

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
