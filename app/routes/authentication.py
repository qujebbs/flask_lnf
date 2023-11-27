from flask import (
    Flask,
    render_template,
    request,
    redirect,
    url_for,
    request,
    session,
    Blueprint,
)
import bcrypt
import os
import secrets
import smtplib
import requests
import datetime
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from utils import (
    get_cursor,
    close_connection,
    get_connection,
    log_in_user,
    log_out_user,
)

authentication = Blueprint("authentication", __name__)
token = secrets.token_hex(16)


@authentication.route("/login", methods=["POST", "GET"])
def login():
    if request.method == "POST":
        username = request.form.get("username", "")
        password = request.form.get("password", "").encode("utf-8")
        query = "SELECT * FROM tbl_user WHERE colUsername = %s "
        cursor, connection = get_cursor()
        cursor.execute(query, (username,))
        user = cursor.fetchone()

        if user and bcrypt.checkpw(password, user[3].encode("utf-8")):
            session.update({"user": user, "user_id": user[0], "user_role": user[4]})
            log_in_user(user, user[0], user[4])
            return redirect(url_for("routes.dashboard.dashboar"))

        return render_with_alert(
            "login.html", text="Incorrect Username or Password!", text_status="error"
        )

    return render_template("login.html")


@authentication.route("/register", methods=["POST", "GET"])
def register():
    if request.method == "POST":
        recaptcha_response = request.form.get("g-recaptcha-response")
        if not validate_recaptcha(recaptcha_response):
            return render_with_alert(
                "register.html",
                text="Invalid reCAPTCHA.",
                text_status="error",
            )

        username = request.form["username"]
        password = request.form["password"]
        confirm_password = request.form["confirm_password"]
        email = request.form["email"]

        def check_password(password, confirm_password):
            if len(password) < 8:
                return False, "Password should be at least 8 characters long."
            if password != confirm_password:
                return False, "Passwords do not match."
            if not (
                any(char.islower() for char in password)
                and any(char.isupper() for char in password)
                and any(char.isdigit() for char in password)
            ):
                return (
                    False,
                    "Password should contain at least one Lowercase letter, one Uppercase letter and one digit.",
                )
            return True, ""

        password_check, message = check_password(password, confirm_password)
        if not password_check:
            return render_with_alert("register.html", text=message, text_status="error")

        with get_connection() as connection:
            cursor = connection.cursor()
            password = password.encode("utf-8")  # Re-encode the password as bytes
            query = "SELECT colUsername, colEmail FROM tbl_user WHERE colUsername = %s OR colEmail = %s"
            cursor.execute(query, (username, email))
            existing_records = cursor.fetchall()

            errors = {
                "username": "Username already exists.",
                "email": "Email address already exists.",
            }

            for record in existing_records:
                for error_key, error_message in errors.items():
                    if record[0] == username and error_key == "username":
                        return render_with_alert(
                            "register.html", text=error_message, text_status="error"
                        )
                    if record[1] == email and error_key == "email":
                        return render_with_alert(
                            "register.html", text=error_message, text_status="error"
                        )

            hashed_password = bcrypt.hashpw(password, bcrypt.gensalt())
            query = "CALL createUser(%s,%s,%s)"
            cursor.execute(query, (email, hashed_password, username))
            connection.commit()

            return render_with_alert(
                "login.html",
                text="Account created successfully.",
                text_status="success",
            )

    return render_template("register.html")


@authentication.route("/logout")
def logout():
    log_out_user()
    return render_template("login.html")


@authentication.route("/forgot_username", methods=["GET", "POST"])
def forgot_username():
    if request.method == "POST":
        email = request.form["email"]
        cursor = get_cursor()
        connection = get_connection()

        with connection.cursor() as cursor:
            query = "SELECT * FROM tbl_user WHERE colEmail = %s"
            cursor.execute(query, (email,))
            user = cursor.fetchone()

        if user:
            send_username_reset_email(user[2], user[1])
        else:
            return render_with_alert(
                "forgot_username.html",
                text="No email found.",
                text_status="info",
            )

        return render_with_alert(
            "login.html",
            text="Username sent in your email.",
            text_status="success",
        )

    return render_template("forgot_username.html")


def send_username_reset_email(email, username):
    sender_email = "johnmiller.asz8@gmail.com"
    password = "utkk gxyl whdq grgt"

    # Compose the email message
    subject = "Your Username"
    body = """
    <html>
    <body style="font-family: Arial, sans-serif; text-align: center;">
        <div style="border: 2px solid #006699; padding: 20px; margin: 10px;">
            <h2 style="color: #006699;">LostNFound Account Recovery</h2>
            <p>Dear User,</p>
            <p>It appears that you've requested assistance in recovering your account username. No worries, we're here to help!</p>
            <p>Your Username is: <b style="color: #ff0000;">{username}</b></p>
            <p>If you did not initiate this request or have any concerns, please contact our support team at <a href='mailto:johnmiller.asz8@gmail.com' style="color: #006699;">support@lostNfound</a> for further assistance.</p>
            <p>Best Regards,<br>Your Support Team</p>
        </div>
    </body>
    </html>
    """.format(
        username=username
    )
    message = MIMEMultipart("alternative")
    message["Subject"] = subject
    message["From"] = sender_email
    message["To"] = email
    part = MIMEText(body, "html")
    message.attach(part)

    with smtplib.SMTP("smtp.gmail.com", 587) as server:
        server.starttls()
        server.login(sender_email, password)
        server.send_message(message)


def render_with_alert(template, **kwargs):
    return render_template(template, show_sweetalert=True, **kwargs)


def validate_recaptcha(response):
    secret_key = "YOUR_SECRET_KEY"
    payload = {"response": response, "secret": secret_key}
    response = requests.post(
        "https://www.google.com/recaptcha/api/siteverify", data=payload
    )

    if response.json()["success"]:
        return True
    else:
        return False


@authentication.route("/forgot_password", methods=["GET", "POST"])
def forgot_password():
    if request.method == "POST":
        email = request.form["email"]
        cursor = get_cursor()
        connection = get_connection()

        with connection.cursor() as cursor:
            query = "SELECT * FROM tbl_user WHERE colEmail = %s"
            cursor.execute(query, (email,))
            user = cursor.fetchone()

        if user:
            token = secrets.token_hex(16)
            with connection.cursor() as cursor:
                query = "INSERT INTO `tbl_reset_token` (`colUserID`, `colToken`, `colExpiration`) VALUES (%s, %s, NOW() + INTERVAL 1 HOUR)"
                cursor.execute(query, (user[0], token))
                connection.commit()
                send_password_reset_email(user[2], token)
        else:
            return render_with_alert(
                "forgot_password.html",
                text="No email found.",
                text_status="info",
            )

        return render_with_alert(
            "login.html",
            text="Reset link sent in your email.",
            text_status="success",
        )

    return render_template("forgot_password.html")


def send_password_reset_email(email, token):
    sender_email = "johnmiller.asz8@gmail.com"
    password = "utkk gxyl whdq grgt"

    # Compose the email message
    subject = "Your Password"
    body = """
<html>
    <body style="font-family: Arial, sans-serif; text-align: center;">
        <div style="border: 2px solid #006699; padding: 20px; margin: 10px;">
            <h2 style="color: #006699;">LostNFound Account Recovery</h2>
            <p>Dear User,</p>
            <p>It appears that you've requested assistance in recovering your account password. No worries, we're here to help!</p>
            <p>Your password reset link is: <a href="http://127.0.0.1:5000/reset_password/{token}" style="color: #ff0000;">Reset Password</a></p>
            <p>This link will expire in 1 hour.</p>
            <p>If you did not initiate this request or have any concerns, please contact our support team at <a href='mailto:johnmiller.asz8@gmail.com' style="color: #006699;">support@lostNfound</a> for further assistance.</p>
            <p>Best Regards,<br>Your Support Team</p>
        </div>
    </body>
</html>
""".format(
        token=token
    )
    message = MIMEMultipart("alternative")
    message["Subject"] = subject
    message["From"] = sender_email
    message["To"] = email
    part = MIMEText(body, "html")
    message.attach(part)

    with smtplib.SMTP("smtp.gmail.com", 587) as server:
        server.starttls()
        server.login(sender_email, password)
        server.send_message(message)


@authentication.route("/reset_password/<token>", methods=["GET", "POST"])
def reset_password(token):
    if request.method == "POST":
        new_password = request.form.get("new_password")
        confirm_password = request.form.get("confirm_password")
        cursor, connection = get_cursor()

        def check_password(new_password, confirm_password):
            if len(new_password) < 8:
                return False, "Password should be at least 8 characters long."
            if new_password != confirm_password:
                return False, "Passwords do not match."
            if not (
                any(char.islower() for char in new_password)
                and any(char.isupper() for char in new_password)
                and any(char.isdigit() for char in new_password)
            ):
                return (
                    False,
                    "Password should contain at least one Lowercase letter, one Uppercase letter and one digit.",
                )
            return True, ""

        password_check, message = check_password(new_password, confirm_password)
        if not password_check:
            return render_with_alert(
                "reset_password.html", text=message, text_status="error", token=token
            )
        query = "SELECT colExpiration FROM tbl_reset_token WHERE colToken = %s"
        cursor.execute(query, (token,))
        result = cursor.fetchone()

        if result and result[0] > datetime.datetime.now():
            query = "UPDATE tbl_user SET colUserPass = %s  WHERE colUserID IN (SELECT colUserID FROM tbl_reset_token WHERE colToken = %s AND colExpiration > NOW())"
            hashed_password = bcrypt.hashpw(
                new_password.encode("utf-8"), bcrypt.gensalt()
            )
            cursor.execute(query, (hashed_password, token))
            connection.commit()

            delete_query = "DELETE FROM tbl_reset_token WHERE colToken = %s"
            cursor.execute(delete_query, (token,))
            connection.commit()
            return render_with_alert(
                "login.html",
                text="Successfully updated your password.",
                text_status="success",
            )
        else:
            delete_query = "DELETE FROM tbl_reset_token WHERE colToken = %s"
            cursor.execute(delete_query, (token,))
            connection.commit()
            return render_with_alert(
                "login.html",
                text="Password reset link has expired.",
                text_status="error",
                token=token,
            )

    return render_template("reset_password.html", token=token)
