import csv

with open("favorites.csv", "r") as file:
    reader = csv.DictReader(file)
    scratch, c, python = 0, 0, 0

    for row in reader:
        favorite = row["language"]
        if (favorite == "Scratch"):
            scratch = scratch + 1
        elif (favorite == "C"):
            c = c + 1
        elif (favorite == "Python"):
            python = python + 1

print(f"Scratch: {scratch}")
print(f"C: {c}")
print(f"Python: {python}")
