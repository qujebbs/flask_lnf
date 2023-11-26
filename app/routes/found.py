from flask import Flask, render_template, request, redirect, url_for, request, session, Blueprint
import bcrypt
import os
import secrets
import smtplib
from email.mime.text import MIMEText
from utils import get_connection, get_cursor, close_connection, is_user_logged_in, get_current_user_data

found = Blueprint('found', __name__)

@found.route("/found", methods=["GET", "POST"])
def foun():
        if not is_user_logged_in():
            return redirect(url_for("authentication.login"))
    
        user, user_id, user_role = get_current_user_data()
        cursor, connection = get_cursor()
        query = "SELECT u.colUsername, lp.colItemName, lp.colItemDesc, u.colEmail, lp.colDatePosted, pic.colPicURI, lp.colItemID FROM tbl_items AS lp JOIN tbl_user AS u ON lp.colPosterID = u.colUserID JOIN tbl_item_pic AS pic ON lp.colItemID = pic.colItemID and lp.colStatusID = 2;"
        cursor.execute(query)
        value = cursor.fetchall()
        img_paths = [row[5] for row in value]
        img_path = [path.replace('\\', '/') for path in img_paths]
        return render_template("Found.html",user_role=user_role, items=value, paths=img_path)