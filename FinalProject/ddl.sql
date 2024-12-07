-- DDL

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE loan_attempts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    client_name TEXT NOT NULL,
    person_age REAL NOT NULL,
    person_income REAL NOT NULL,
    loan_amnt REAL NOT NULL,
    loan_int_rate REAL NOT NULL,
    credit_score REAL NOT NULL,
    person_gender TEXT NOT NULL,
    person_education TEXT NOT NULL,
    person_home_ownership TEXT NOT NULL,
    loan_intent TEXT NOT NULL,
    person_emp_exp REAL NOT NULL,
    loan_percent_income REAL NOT NULL,
    cb_person_cred_hist_length REAL NOT NULL,
    previous_loan_defaults_on_file TEXT NOT NULL,
    result TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
);
