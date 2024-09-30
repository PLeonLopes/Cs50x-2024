import csv
from collections import Counter

with open("favorites.csv", "r") as file:
    reader = csv.DictReader(file)
    counts = Counter()

    for row in reader:
        favorite = row["problem"]
        counts[favorite] = counts[favorite] + 1

favorite = str(input("Favorite: "))
print(f"{favorite}: {counts[favorite]}")
