from flask import Flask, render_template, request, redirect, url_for, request, session, Blueprint
import bcrypt
import os
import secrets
import smtplib
from email.mime.text import MIMEText
from utils import get_connection, get_cursor, close_connection, is_user_logged_in, get_current_user_data, getItemcount

dashboard = Blueprint('dashboard', __name__)

@dashboard.route("/dashboard", methods=["GET", "POST"])
def dashboar():
        if not is_user_logged_in():
            return redirect(url_for("routes.authentication.login"))

        lostcount, foundcount, unclaimedcount, claimedcount = getItemcount()
        itemcount = [lostcount, foundcount, unclaimedcount, claimedcount]
        user, user_id, user_role = get_current_user_data()
        return render_template("dashboard.html", user_role= user_role, itemcount=itemcount)