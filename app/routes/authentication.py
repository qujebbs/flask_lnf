from flask import Flask, render_template, request, redirect, url_for, request, session, Blueprint
import bcrypt
import os
import secrets
import smtplib
from email.mime.text import MIMEText
from utils import get_cursor, close_connection, get_connection, log_in_user, log_out_user

authentication = Blueprint('authentication', __name__)

@authentication.route("/login", methods=["POST", "GET"])
def login():
    if request.method == "POST":
        username = request.form.get("username", "")
        password = request.form.get("password", "").encode("utf-8")
        query = "SELECT * FROM tbl_user WHERE col_username = %s "
        cursor, connection = get_cursor()
        cursor.execute(query, (username,))
        user = cursor.fetchone()

        if user and bcrypt.checkpw(password, user[3].encode("utf-8")):
            session.update({"user": user, "user_id": user[0], "user_role": user[5]})
            log_in_user(user, user[0], user[5])
            return redirect(url_for("routes.dashboard.dashboar"))

        return render_with_alert(
            "login.html", text="Incorrect Username or Password!", text_status="error"
        )

    return render_template("login.html")

@authentication.route("/register", methods=["POST", "GET"])
def register():
    if request.method == "POST":
        studnum = request.form["stud_id"]
        username = request.form["username"]
        password = request.form["password"].encode("utf-8")
        confirm_password = request.form["confirm_password"].encode("utf-8")
        email = request.form["email"]
        cursor, connection = get_cursor()
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

@authentication.route("/logout")
def logout():
    log_out_user()
    return render_template("login.html")

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

@authentication.route("/forgot_password", methods=["GET", "POST"])
def forgot_password():
    if request.method == "POST":
        email = request.form["email"]
        cursor = get_cursor
        connection = get_connection
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

def render_with_alert(template, **kwargs):
    return render_template(template, show_sweetalert=True, **kwargs)