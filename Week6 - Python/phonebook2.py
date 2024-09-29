'''
people = [
    {"name": "Carter", "number" : "+1-111-111-1111"},
    {"name": "David", "number" : "+2-222-222-2222"},
    {"name" : "John", "number" : "+3-333-333-3333"},
]

name = str(input("Name: "))

for person in people:
    if person["name"] == name:
        print(f"FOUND {person['number']}")
        break
else:
    print("NOT FOUND!")

'''

people = {
    "Carter" : "+1-111-111-1111",
    "David" : "+2-222-222-2222",
    "John" : "+3-333-333-3333",
}

if name in people:
    number = people[name]
    print(f"FOUND {number}")
else:
    print("NOT FOUND!")

