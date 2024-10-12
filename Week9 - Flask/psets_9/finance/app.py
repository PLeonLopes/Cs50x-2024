import os

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, login_required, lookup, usd

# Configure application
app = Flask(__name__)

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response

# 4 -> INDEX
@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""
    # Selecting users number of shares and stocks (using SUM() ad GROUP BY as intended)
    stocks = db.execute("SELECT symbol, SUM(shares) as total_shares FROM transactions WHERE user_id = :user_id GROUP BY symbol HAVING total_shares > 0", user_id=session["user_id"])

    cash = db.execute("SELECT cash FROM users WHERE id = :user_id", user_id=session["user_id"])[0]["cash"]      # Selecting users account balance
    total_value = cash
    grand_total = cash

    # iterating through the stocs and calculating the total value
    for stock in stocks:
        quote = lookup(stock["symbol"])
        stock["symbol"] = quote["symbol"]
        stock["price"] = quote["price"]
        stock["value"] = quote["price"] * stock["total_shares"]
        total_value = total_value + stock["value"]
        grand_total = grand_total + stock["value"]

    return render_template("index.html", stocks=stocks, cash=cash, total_value=total_value, grand_total=grand_total)
    # return apology("TODO") -> cs50 default comment

# 3 -> BUY
@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""
    if request.method == "POST":
        symbol = request.form.get("symbol").upper()     # stock symbol
        shares = request.form.get("shares")             # quantity of shares

        if not symbol:
            return apology("Must provide a valid symbol! Try again.")
        elif not shares or not shares.isdigit() or int(shares) <= 0:
            return apology("Must provide a integer number of shares! (not float :P)")

        quote = lookup(symbol)          # api call (cs50)
        if quote is None:
            return apology("Symbol not found. Try again")

        price = quote["price"]                          # getting the price of the stock
        total_cost = int(shares) * price                # calculating the total cost
        cash = db.execute("SELECT cash FROM users WHERE id = :user_id", user_id=session["user_id"])[0]["cash"]

        if (cash < total_cost):
            return apology("Not enough money :<. Try again")

        # users table update
        db.execute("UPDATE users SET cash = cash - :total_cost WHERE id = :user_id", total_cost = total_cost, user_id = session["user_id"])
        # adding the purchase to the user's history
        db.execute("INSERT INTO transactions (user_id, symbol, shares, price) VALUES (:user_id, :symbol, :shares, :price)", user_id=session["user_id"], symbol=symbol, shares=shares, price=price)

        flash(f"Bought {shares} shares of {symbol} for ${total_cost}!")      # cs50 function
        return redirect("/")
    else:                                   # if tries to get here by get
        return render_template("buy.html")
    # return apology("TODO") -> cs50 default comment

# 6 -> HISTORY
@app.route("/history")
@login_required
def history():
    """Show history of transactions"""

    # Selecting from the transactions table, searching for all the users transactions, ordering by the time
    transactions = db.execute("SELECT * FROM transactions WHERE user_id = :user_id ORDER BY timestamp DESC", user_id=session["user_id"])

    return render_template("history.html", transactions=transactions)       # sending it to the html
    # return apology("TODO") -> Cs50 default comment


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""
    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute(
            "SELECT * FROM users WHERE username = ?", request.form.get("username")
        )

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(
            rows[0]["hash"], request.form.get("password")
        ):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""
    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")

# 2 -> QUOTE
@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""
    if request.method == "GET":                     # if user tries to get here by GET
        return render_template("quote.html")
    else:
        symbol = request.form.get("symbol")       # find by the name

        if not symbol:
            return apology("Must provide a valid Symbol!")

        stock = lookup(symbol.upper())      # api call (cs50)

        if (stock == None):
            return apology("Symbol does not exist. Try again!\n:P")
        return render_template("quoted.html", price = stock["price"], symbol = stock["symbol"])
    # return apology("TODO") -> cs50 default comment

# 1 -> REGISTER
@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""

    session.clear()     # clear any previous user_id

    if (request.method == "POST"):                      # user used post
        username = request.form.get("username")
        password = request.form.get("password")
        confirmation = request.form.get("confirmation")

        if not request.form.get("username"):            # USERNAME VALIDATION (server-side)
            return apology("Must provide a username!")

        elif not request.form.get("password"):          # PASSWORD VALIDATION (server-side)
            return apology("Must provide a password!")

        elif not request.form.get("confirmation"):    # PASSWORD VALIDATION (server-side)
            return apology("Must provide a password confirmation!")

        elif request.form.get("password") != request.form.get("confirmation"):        # cheking the passwords match
            return apology("Password do not match. TRY AGAIN!\n:P")

        # Checking if username already exists
        check_db = db.execute("SELECT * FROM users WHERE username = ?", username)
        if len(check_db) != 0:
            return apology("USERNAME ALREADY TAKEN!")

        # hashing the password and inserting new user into the database
        hash = generate_password_hash(password)
        db.execute("INSERT INTO users (username, hash) VALUES (?, ?)", username, hash)

        rows = db.execute("SELECT * FROM users WHERE username = ?", username)       # query for new user and assign to a variable
        session["user_id"] = rows[0]["id"]                                          # creatign a session for the user (username)

        return redirect("/")
    else:                           # if the user used GET
        return render_template("register.html")
    # return apology("TODO") -> cs50 comment

# 5 -> SELL
@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock"""

    # Getting user's stocks
    stocks = db.execute("SELECT symbol, SUM(shares) as total_shares FROM transactions WHERE user_id = :user_id GROUP BY symbol HAVING total_shares > 0", user_id=session["user_id"])

    if (request.method == "POST"):                  # if the user gets here by post
        symbol = request.form.get("symbol").upper()
        shares = request.form.get("shares")

        # server-side input validation
        if not symbol:
            return apology("Must provide a valid symbol. Try again!")
        elif not shares or not shares.isdigit() or int(shares) <= 0:
            return apology("Must provide a integer number of shares! (not float :P)")
        else:
            shares = int(shares)

        for stock in stocks:
            if stock["symbol"] == symbol:
                if stock["total_shares"] < shares:
                    return apology("Not enough shares!")
                else:
                    quote = lookup(symbol)      # cs50 api call
                    if quote is None:
                        return apology("Symbol not found! Try again")
                    price = quote["price"]
                    total_sale = (shares * price)

                    # UPDATING USERS TABLE
                    db.execute("UPDATE users SET cash = cash + :total_sale WHERE id = :user_id", total_sale=total_sale, user_id=session["user_id"])

                    # adding the sale to the history
                    db.execute("INSERT INTO transactions (user_id, symbol, shares, price) VALUES (:user_id, :symbol, :shares, :price)", user_id=session["user_id"], symbol=symbol, shares=-shares, price=price)

                    flash(f"Sold {shares} shares of {symbol} for {usd(total_sale)}!")       # -> from helpers.py!
                    return redirect("/")

        return apology("Symbol not found! Try again.")
    else:
        return render_template("sell.html", stocks=stocks)
    # return apology("TODO") -> cs50 default comment
