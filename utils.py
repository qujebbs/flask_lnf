import mysql.connector
from flask import session


def get_connection():

    return connection


def close_connection(connection):
    connection.close()


def get_cursor():
    connection = get_connection()
    cursor = connection.cursor()
    return cursor, connection


def is_user_logged_in():
    return "user_id" in session


def log_in_user(user, user_id, user_role):
    session["user"] = user
    session["user_id"] = user_id
    session["user_role"] = user_role


def log_out_user():
    session.clear()


def get_current_user_data():
    user = session.get("user")
    user_id = session.get("user_id")
    user_role = session.get("user_role")

    return user, user_id, user_role

def getItemcount():
    cursor, connection = get_cursor()

    cursor.execute("SELECT COUNT(colItemID) AS postcount FROM tbl_items where colStatusID = 1;")
    lostcount = cursor.fetchone()

    cursor.execute("SELECT COUNT(colItemID) AS postcount FROM tbl_items where colStatusID = 2;")
    foundcount = cursor.fetchone()

    cursor.execute("SELECT COUNT(colItemID) AS postcount FROM tbl_items where colStatusID = 3;")
    unclaimedcount = cursor.fetchone()


    cursor.execute("SELECT COUNT(colItemID) AS postcount FROM tbl_items where colStatusID = 4;")
    claimedcount = cursor.fetchone()

    return lostcount, foundcount, unclaimedcount, claimedcount