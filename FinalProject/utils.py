# CREATING A AUXILIARY "LOGIN REQUIRED DECORATOR"

from functools import wraps
from flask import session, redirect, url_for

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            return redirect(url_for('login'))           # Redirects to the login URL rout
        return f(*args, **kwargs)
    return decorated_function
