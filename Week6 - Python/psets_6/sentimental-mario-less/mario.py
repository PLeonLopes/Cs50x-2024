from cs50 import get_int

while True:
    height = get_int("Height: ")
    if (height > 0 and height < 9):
        break

for c in range(height):
    print((height - c - 1) * " ", end='')
    print("#" * (c + 1))
