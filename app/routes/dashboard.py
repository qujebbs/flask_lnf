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

@dashboard.route("/search", methods=["GET", "POST"])
def search():
    if not is_user_logged_in():
        return redirect(url_for("authentication.login"))
    
    searchname = request.form["searchbar"]
    if not searchname == '':
        searched = True
    else:
         searched = False

    lostcount, foundcount, unclaimedcount, claimedcount = getItemcount()
    itemcount = [lostcount, foundcount, unclaimedcount, claimedcount]
    user, user_id, user_role = get_current_user_data()
    cursor, connection = get_cursor()
    query = "SELECT u.colUsername, lp.colItemName, lp.colItemDesc, u.colEmail, lp.colDatePosted, pic.colPicURI, lp.colItemID, lp.colStatusID FROM tbl_items AS lp JOIN tbl_user AS u ON lp.colPosterID = u.colUserID left JOIN tbl_item_pic AS pic ON lp.colItemID = pic.colItemID and lp.colItemName = %s where lp.colItemName = %s;"
    cursor.execute(query, (searchname,searchname,))
    value = cursor.fetchall()
    img_paths = [row[5] if row[5] is not None else "No Image" for row in value]
    img_path = [path.replace('\\', '/') for path in img_paths]
    return render_template("dashboard.html",user_role=user_role, items=value, paths=img_path, itemcount=itemcount, searched=searched)