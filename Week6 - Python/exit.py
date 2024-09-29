import sys

if (len(sys.argv) != 2):
    print("MISSING COMMAND-LINE ARGUMENT")
    sys.exit(1)

print(f"Hello, {sys.argv[1]}")
sys.exit(0)
