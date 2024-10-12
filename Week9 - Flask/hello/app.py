from flask import Flask, render_template, request

app = Flask(__name__)       # identifies as a web app

@app.route("/", methods=["GET", "POST"])        # ACCEPTING BOTH GET AND POST
def index():
    if (request.method == "POST"):
        name = request.form.get("name")
        return render_template("greet.html", name=name)
    return render_template("index.html")

