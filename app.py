from flask import Flask, render_template,request,session,redirect,url_for,request
import os
import mysql.connector

app = Flask(__name__ , static_url_path='', static_folder='static/Lost And Found font-end/public')

connection = mysql.connector.connect(host='localhost',port='3306',
                                        database='lostnfounddb',
                                        user='root',
                                        password='105671080088')

cursor = connection.cursor()

@app.route('/')
def landing():
    return render_template('landing.html')


@app.route('/register', methods=["POST", "GET"])
def register():

    if request.method =="POST" :
        studnum = request.form["stud_id"]
        username = request.form["username"]
        passwd = request.form["password"]
        email = request.form["email"]
        role = 1

        cursor.execute("Insert into tblusers values (NULL,%s,%s,%s,%s,%s)",(username,passwd,email,role,studnum))
        connection.commit()
    return render_template('register.html')



@app.route('/login', methods=["POST", "GET"])
def login():
    if request.method =="POST" and 'username' in request.form and 'password' in request.form:
        username = request.form["username"]
        passwd = request.form["password"]

        cursor.execute("SELECT * FROM tblusers WHERE username = %s AND password = %s",(username, passwd))
        
        user = cursor.fetchone()

        if user:
            return redirect(url_for('home'))
        else:
            return redirect(url_for('register'))

    return render_template('login.html')

@app.route('/home')
def home():
    return render_template('home.html')

@app.route('/dashboard')
def dashboard():
    return render_template('dashboard.html')

@app.route('/claimed.html')
def claimed():
    return render_template('Claimed.html')


if __name__ == '__main__':
    app.run(debug=True)

    