from cs50 import get_float

while True:
    total_change = get_float("Enter total change: ")
    if (total_change > 0):
        break

total_cents = int(total_change * 100)

# QUARTERS (25)
quarters = int(total_cents / 25)
total_cents = total_cents - quarters * 25

# DIMES (10)
dimes = int(total_cents / 10)
total_cents = total_cents - dimes * 10

# NICKELS (5)
nickels = int(total_cents / 5)
total_cents = total_cents - nickels * 5

# PENNIES (1)
pennies = total_cents

print(quarters + dimes + nickels + pennies)     # final ammount of coins
