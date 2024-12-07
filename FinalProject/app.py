import os
import warnings
# Machine Learning Imports
import joblib
import numpy as np
import pandas as pd
# Flask imports (Flask and DB)
from flask import Flask, render_template, request, redirect, render_template, session, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_session import Session
from werkzeug.security import check_password_hash, generate_password_hash
import sqlite3
# Utils and Helpers import
from utils import login_required            # login_required() decorator
from helpers import get_scaler              # MixMax scaler

# Flask Configs
app = Flask(__name__)

# SQLITE3 ROUTES CONFIGS (trying without cs50 library)
basedir = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'app.db')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# SQLALCHEMY "INIT"
db = SQLAlchemy(app)

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configs to get the absolute path to the ML_model
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Suppress "FutureWarnings"
warnings.simplefilter(action='ignore', category=FutureWarning)

# Loading the ML Model
model_path = os.path.join(BASE_DIR, "ML_model", "loan_model.pkl")
loan_model = joblib.load(model_path)

# normalizer -> "helpers.py"
scalers = get_scaler()

# Categorical Values
categorical_features = {
    "person_gender": ["Masculino", "Feminino"],
    "person_education": ["High School", "Associate", "Bachelors", "Master", "Doctorate"],
    "person_home_ownership": ["RENT", "MORTGAGE", "OWN", "OTHER"],
    "loan_intent": ["EDUCATION", "MEDICAL", "VENTURE", "PERSONAL", "DEBTCONSOLIDATION"],
    "previous_loan_defaults_on_file": ["0", "1"],
}

# Mapping Categories to Number
mapping_dicts = {}
for feature, categories in categorical_features.items():
    indices, unique_categories = pd.factorize(categories)           # pd.factorize -> assigns a unique index to each category

    # Creating a mapping dictionary to the current featura
    feature_mapping = {category: idx for idx, category in enumerate(unique_categories)}
    mapping_dicts[feature] = feature_mapping

# 1 -> REGISTER
@app.route("/register", methods=["GET", "POST"])
def register():

    session.clear()     # clear any previous user_id

    if (request.method == "POST"):                      # user used post

        username = request.form.get("username")
        password = request.form.get("password")
        confirmation = request.form.get("confirmation")

        if not request.form.get("username"):            # USERNAME VALIDATION (server-side)
            return render_template("register.html", error='Must provide a username!')

        elif not request.form.get("password"):          # PASSWORD VALIDATION (server-side)
            return render_template("register.html", error='Must provide a password!')

        elif not request.form.get("confirmation"):    # PASSWORD VALIDATION (server-side)
            return render_template("register.html", error='Must provide a password confirmation!')

        elif request.form.get("password") != request.form.get("confirmation"):        # cheking the passwords match
            return render_template("register.html", error='Passwords do not match. TRY AGAIN!')

        # connecting to sqlite3 db
        conn = sqlite3.connect('project.db')
        cursor = conn.cursor()

        # Checking if username already exists
        cursor.execute("SELECT * FROM users WHERE username = ?", (username,))
        check_db = cursor.fetchall()
        if len(check_db) != 0:
            conn.close()
            return render_template("register.html", error='USERNAME ALREADY TAKEN!')

        # hashing the password and inserting new user into the database
        hash = generate_password_hash(password)

        try:
            cursor.execute("INSERT INTO users (username, password_hash) VALUES (?, ?)", (username, hash))
            conn.commit()  # confirms transaction (sqlite3)

            # queries the db and obtains user's id to create new session
            cursor.execute("SELECT * FROM users WHERE username = ?", (username,))
            rows = cursor.fetchall()
            session["user_id"] = rows[0][0]  # stores in a new session
        except sqlite3.Error as e:
            conn.rollback()  # error prevention
            return render_template("register.html", error=f"An error occurred: {e}")
        finally:
            conn.close()  # closes connection

        return redirect("/")

    else:                           # if the user used GET
        return render_template("register.html")

# 2 -> LOGIN
@app.route("/login", methods=["GET", "POST"])
def login():
    # Forget any previous user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        # Ensure username was submitted
        if not request.form.get("username"):
            return render_template("login.html", error='must provide username')

        # Ensure password was submitted
        elif not request.form.get("password"):
            return render_template("login.html", error='must provide password')

        # connecting to sqlite3 db
        conn = sqlite3.connect('project.db')
        cursor = conn.cursor()

        # Query database for username
        cursor.execute("SELECT * FROM users WHERE username = ?", (request.form.get("username"),))
        rows = cursor.fetchall()

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0][2], request.form.get("password")):
            return render_template("login.html", error='invalid username and/or password')

        # Remember which user has logged in
        session["user_id"] = rows[0][0]      # stores user id in the session [0] -> user's id
        session["username"] = rows[0][1]     # saving user's name into the session
        print(session["username"])           # Adicione esta linha para verificar o nome de usuário no terminal

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")

# 3 -> LOGOUT
@app.route("/logout")
def logout():
    # Forget any previous user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


# 4 -> Index
@app.route("/")
def forms():
    return render_template("index.html")

# 5 -> Result
@app.route("/result", methods=["POST"])
def guess():
    try:
        data = request.form
        client_name = data.get("client_name")


        # Transforms and Organizes the Data
        data_entry = {
            "person_age": float(data.get("person_age")),
            "person_income": float(data.get("person_income")),
            "loan_amnt": float(data.get("loan_amnt")),
            "loan_int_rate": float(data.get("loan_int_rate")),
            "credit_score": float(data.get("credit_score")),
        }

        # List to save the normalized data
        normalized_data = []
        # Iterates through the numerical columns to normalize the values
        for col in data_entry:
            original_value = data_entry[col]                                    # Form's value
            transformed_value = scalers[col].transform([[original_value]])      # Normalized form data
            normalized_value = transformed_value[0][0]                          # Extracts from the array
            normalized_data.append(normalized_value)                            # Entries in the list

        # Adding the categorial values
        model_entry = normalized_data + [
            mapping_dicts["person_gender"][data.get("person_gender")],
            mapping_dicts["person_education"][data.get("person_education")],
            mapping_dicts["person_home_ownership"][data.get("person_home_ownership")],
            mapping_dicts["loan_intent"][data.get("loan_intent")],
            float(data.get("person_emp_exp")),
            float(data.get("loan_percent_income")),
            float(data.get("cb_person_cred_hist_length")),
            mapping_dicts["previous_loan_defaults_on_file"][data.get("previous_loan_defaults_on_file")],
        ]

        # Uses the model (.pkl) to make the prediction
        prediction = loan_model.predict([model_entry])

        # Prediction results (int)
        result = int(prediction[0])

        # Save the result in the database
        result_message = "Loan Approved!" if result == 1 else "Loan Denied!"
        conn = sqlite3.connect('project.db')
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO loan_attempts (
                user_id, client_name, person_age, person_income, loan_amnt, loan_int_rate,
                credit_score, person_gender, person_education, person_home_ownership, loan_intent,
                person_emp_exp, loan_percent_income, cb_person_cred_hist_length,
                previous_loan_defaults_on_file, result
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            session["user_id"], client_name, data_entry["person_age"], data_entry["person_income"],
            data_entry["loan_amnt"], data_entry["loan_int_rate"], data_entry["credit_score"],
            data.get("person_gender"), data.get("person_education"), data.get("person_home_ownership"),
            data.get("loan_intent"), data.get("person_emp_exp"), data.get("loan_percent_income"),
            data.get("cb_person_cred_hist_length"), data.get("previous_loan_defaults_on_file"),
            result_message
        ))
        conn.commit()
        conn.close()

        # Result
        if (result == 1):
            message = "Loan Approved!"
            color = "success"                         # boostrap green color
        else:
            message = "Loan Denied!"
            color = "danger"                          # bootstrap red color
        return render_template("result.html", client_name=client_name, message=message, color=color)
    except Exception as e:
        return render_template("result.html", client_name="Error. Try again!", message=str(e), color="danger")

# 6 -> History
@app.route("/history")
@login_required
def history():
    conn = sqlite3.connect('project.db')
    cursor = conn.cursor()
    cursor.execute("""
        SELECT client_name, loan_amnt, loan_int_rate, credit_score, result, created_at
        FROM loan_attempts WHERE user_id = ? ORDER BY created_at DESC
    """, (session["user_id"],))
    history_data = cursor.fetchall()
    conn.close()

    return render_template("history.html", history=history_data)


if __name__ == "__main__":
    app.run(debug = True)

