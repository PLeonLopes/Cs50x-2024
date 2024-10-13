from string import ascii_letters
from itertools import product

for passcode in product(ascii_letters, repeat = 4):     # fast, but starting to get slow...
    print(passcode)

