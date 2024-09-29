def get_int(prompt):
    while True:
        try:
            return int(input(prompt))
        except ValueError:
            pass                # print("NOT AN INTEGER")


def main():
    x = get_int("X: ")
    y = get_int("Y: ")

    print(x + y)


main()
