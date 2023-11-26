from flask import Flask, render_template, request, redirect, url_for, request, session, Blueprint
import bcrypt
import os
import secrets
import smtplib
from email.mime.text import MIMEText
from utils import get_connection, get_cursor, close_connection, is_user_logged_in, get_current_user_data
from app.routes.authentication import render_with_alert

posts = Blueprint('posts', __name__)

app = Flask(__name__)

PICS_FOLDER = "pics"
app.config["UPLOAD_FOLDER"] = PICS_FOLDER

@posts.route("/upload", methods=["POST"])
def upload():
    if not is_user_logged_in():
        return redirect(url_for("routes.authentication.login"))
    user, user_id, user_role = get_current_user_data()
    if user_role == 2:
        user_rolee = "admin"
    elif user_role == 1:
        user_rolee = "user"
    if request.method == "POST":
        item_name = request.form["item_name"]
        description = request.form["description"]
        pictures = request.files.getlist("pics")
        user_id = user_id
        cursor, connection = get_cursor()
        if item_name and description and pictures:
            query = "call createNewItem(%s,%s,%s,%s)"
            cursor.execute(
                query, (item_name, description, user_id, user_rolee)
            )
            cursor.execute(
                "SELECT last_insert_id() AS 'postID' FROM tbl_items  LIMIT 1;"
            )
            postid = cursor.fetchone()[0]

            for pic in pictures:
                file_name = pic.filename
                file_path = os.path.join(app.config["UPLOAD_FOLDER"], file_name)

                newfile_path = os.path.join(r"C:\Users\fajar\OneDrive\Desktop\flask_lnf\static", file_path)
                query = "call insertNewPic(%s,%s)"
                cursor.execute(query, (postid, file_path))

                pic.save(newfile_path)

            connection.commit()
            return render_with_alert(
                "dashboard.html", user_role=user_role,
                text="Upload Successful.",
                text_status="success",
            )
        
    # return render_with_alert(
    #     "dashboard.html",
    #     text="Incorrect Username or Password!",
    #     text_status="error",
    # )

@posts.route('/delpost/<int:post_id>', methods=['POST'])
def delpost(post_id):
    cursor, connection = get_cursor()
    delete_query = "DELETE FROM tbl_items WHERE colItemID = %s;"
    cursor.execute(delete_query, (post_id,))
    connection.commit()
    cursor.close()
    return redirect(url_for('routes.dashboard.dashboar'))

@posts.route('/mark_as_found/<int:post_id>', methods=['POST', 'GET'])
def mark_as_found(post_id):
    cursor, connection = get_cursor()
    update_query = "update tbl_items set colStatusID = 2 where colItemID = %s"
    cursor.execute(update_query, (post_id,))
    connection.commit()
    cursor.close()
    return redirect(url_for('routes.dashboard.dashboar'))

@posts.route('/mark_as_claimed/<int:post_id>', methods=['POST', 'GET'])
def mark_as_claimed(post_id):
    cursor, connection = get_cursor()
    update_query = "update tbl_items set colStatusID = 4 where colItemID = %s"
    cursor.execute(update_query, (post_id,))
    connection.commit()
    cursor.close()
    return redirect(url_for('routes.dashboard.dashboar'))

@posts.route('/mark_as_unclaimed/<int:post_id>', methods=['POST', 'GET'])
def mark_as_unclaimed(post_id):
    cursor, connection = get_cursor()
    update_query = "update tbl_items set colStatusID = 3 where colItemID = %s"
    cursor.execute(update_query, (post_id,))
    connection.commit()
    cursor.close()
    return redirect(url_for('routes.dashboard.dashboar'))
