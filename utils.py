import mysql.connector
from flask import session

def get_connection():
    connection = mysql.connector.connect(host="localhost", port="3306", database="lostandfound", user="root", password="105671080088"
)
    return connection

def close_connection(connection):
    connection.close()

def get_cursor():
    connection = get_connection()
    cursor = connection.cursor()
    return cursor, connection

def is_user_logged_in():
    return 'user_id' in session

def log_in_user(user, user_id, user_role):
    session['user'] = user
    session['user_id'] = user_id
    session['user_role'] = user_role

def log_out_user():
    session.pop("user", None)

def get_current_user_data():
    return session.get("user", "user_id", "user_id", "user_role")