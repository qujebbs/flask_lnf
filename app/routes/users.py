from flask import Flask, render_template, request, redirect, url_for, request, session, Blueprint
import bcrypt
import os
import secrets
import smtplib
from email.mime.text import MIMEText
from utils import get_connection, get_cursor, close_connection, is_user_logged_in

users = Blueprint('users', __name__)

@users.route("/users", methods=["GET", "POST"])
def user():
        if not is_user_logged_in():
            return redirect(url_for("authentication.login"))
    
        return render_template("users.html")