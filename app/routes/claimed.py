from flask import Flask, render_template, request, redirect, url_for, request, session, Blueprint
import bcrypt
import os
import secrets
import smtplib
from email.mime.text import MIMEText
from utils import get_connection, get_cursor, close_connection, is_user_logged_in

claimed = Blueprint('claimed', __name__)

@claimed.route("/claimed" , methods=["GET", "POST"])
def claimed():
    if not is_user_logged_in():
        return redirect(url_for("login"))
    
    return render_template("Claimed.html")