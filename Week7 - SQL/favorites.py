import csv

with open("favorites.csv", "r") as file:                # perk of using "with" -> the file closes automatically
    reader = csv.DictReader(file)                       # 1 -     reader = csv.reader(file)
    # next(reader)                                      # jumps metadata row
    for row in reader:
        # print(f"{row[0]}, {row[1]}, {[row[2]]}")      # exactly like .csv
        print(row["language"])                          # treat it like a dict (json)
