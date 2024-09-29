from sys import argv

if (len(argv) == 2):
    print(f"Hello, {argv[1]}")      # command "python" is ignored (ex: "python greet.py")
else:
    print("Hello, world")
