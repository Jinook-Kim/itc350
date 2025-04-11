from flask import Flask, render_template, request, redirect, url_for, flash, session
import pymysql
from dotenv import load_dotenv
import os
import bcrypt
from datetime import date
import random

load_dotenv()

app = Flask(__name__)
app.secret_key = os.getenv("SECRET")

def get_db_connection():
    return pymysql.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_DATABASE"),
        cursorclass=pymysql.cursors.DictCursor
    )

@app.route('/')
def home():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user_type = request.form['user_type']
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        if user_type == 'student':
            cursor.execute("SELECT * FROM STUDENT_ACCOUNT WHERE Username = %s", (username,))
        elif user_type == 'staff':
            cursor.execute("SELECT * FROM COLLEGE_STAFF_ACCOUNT WHERE Username = %s", (username,))
        
        user = cursor.fetchone()
        conn.close()
        
        if user and bcrypt.checkpw(password.encode('utf-8'), user['PasswordHash'].encode('utf-8')):
            session['user_id'] = user['StudentID'] if user_type == 'student' else user['StaffID']
            session['username'] = username
            session['user_type'] = user_type
            flash('Login successful!', 'success')
            # Redirect to a student or staff dashboard based on user type
            return redirect(url_for('application_portal'))
        else:
            flash('Invalid username or password', 'danger')
    
    return render_template('login.html')

@app.route('/create_account', methods=['GET', 'POST'])
def create_account():
    if request.method == 'POST':
        phone = request.form['phone']
        # user_type = request.form['user_type']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        email = request.form['email']
        username = request.form['username']
        password = request.form['password']
        password_hash = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute(
            "INSERT INTO STUDENT_ACCOUNT (Phone, FirstName, LastName, EmailAddress, Username, PasswordHash) VALUES (%s, %s, %s, %s, %s, %s)",
            (phone, first_name, last_name, email, username, password_hash.decode('utf-8'))
        )

        conn.commit()
        conn.close()
        flash('Account created successfully!', 'success')
        return redirect(url_for('login'))

    return render_template('create_account.html')

@app.route('/student_housing_portal')
def student_housing_portal():
    if 'username' not in session or session['user_type'] != 'student':
        flash('You need to log in as a student first.', 'warning')
        return redirect(url_for('login'))
    
    student_id = session['user_id']
    
    conn = get_db_connection()
    cursor = conn.cursor()
    
    cursor.execute("SELECT status, room_name FROM HousingApplicationPortal WHERE student_id = %s", (student_id,))
    application_info = cursor.fetchone()
    conn.close()
    
    return render_template('student_housing_portal.html', application_info=application_info)

@app.route('/submit_application', methods=['POST'])
def submit_application():
    if 'username' not in session or session['user_type'] != 'student':
        flash('You need to log in as a student first.', 'warning')
        return redirect(url_for('login'))
    
    student_id = session['user_id']
    
    conn = get_db_connection()
    cursor = conn.cursor()

    # Check for existing application
    cursor.execute("SELECT * FROM HOUSING_APPLICATION WHERE StudentID = %s", (student_id,))
    if cursor.fetchone():
        flash('Application already submitted.', 'warning')
    else:
        # Get a random staff ID
        cursor.execute("SELECT StaffID FROM COLLEGE_STAFF_ACCOUNT ORDER BY RAND() LIMIT 1")
        staff_id = cursor.fetchone()['StaffID']
        
        # Insert a new application
        cursor.execute(
            "INSERT INTO HOUSING_APPLICATION (Status, SubmissionDate, StudentID, StaffID) VALUES (%s, %s, %s, %s)",
            ('Submitted', date.today(), student_id, staff_id)
        )
        conn.commit()
        flash('Application submitted successfully!', 'success')
    
    conn.close()
    return redirect(url_for('student_housing_portal'))

@app.route('/withdraw_application', methods=['POST'])
def withdraw_application():
    if 'username' not in session or session['user_type'] != 'student':
        flash('You need to log in as a student first.', 'warning')
        return redirect(url_for('login'))
    
    student_id = session['user_id']
    
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Delete the application
    cursor.execute("DELETE FROM HOUSING_APPLICATION WHERE StudentID = %s", (student_id,))
    conn.commit()
    conn.close()
    
    flash('Application withdrawn successfully!', 'success')
    return redirect(url_for('student_housing_portal'))

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8080, debug=True) 