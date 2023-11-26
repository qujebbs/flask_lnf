from flask import Flask, render_template, request, redirect, url_for, request, session, Blueprint
import bcrypt
import os
import secrets
import smtplib
from email.mime.text import MIMEText
from utils import get_connection, get_cursor, close_connection, is_user_logged_in

landing = Blueprint('landing', __name__)

@landing.route("/" , methods=["GET", "POST"])
def index():
    return render_template("landing.html")