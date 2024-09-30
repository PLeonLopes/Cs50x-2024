from cs50 import SQL

db = SQL("sqlite:///favorites.db")      # open db using SQLITE

favorite = input("Favorite: ")

rows = db.execute("SELECT COUNT(*) AS n FROM favorites WHERE problem = ?", favorite)       # cs50 library
row = rows[0]

print(row["n"])
