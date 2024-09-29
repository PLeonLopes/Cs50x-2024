# basically porting .c to .py
from cs50 import get_string

text = get_string("Text: ")

cont_letters = 0
cont_spaces = 0
cont_sentences = 0

for characters in text:
    if (characters.isalpha()):      # IF ALPHA NUMERIC -> is a letter!
        cont_letters = cont_letters + 1
    elif (characters == " "):       # counting the spaces
        cont_spaces = cont_spaces + 1
    elif (characters == "." or characters == "?" or characters == "!"):     # CHECKS FOR "." | "!" and "?" -> to count sentences
        cont_sentences = cont_sentences + 1

words = cont_spaces + 1

L = (cont_letters / words) * 100         # index = 0.0588 * L - 0.296 * S - 15.8 - CALCULATING L
S = (cont_sentences / words) * 100       # index = 0.0588 * L - 0.296 * S - 15.8 - CALCULATING S

grade = 0.0588 * L - 0.296 * S - 15.8       # index = 0.0588 * L - 0.296 * S - 15.8 - CALCULATING INDEX

if (grade > 16):
    print("Grade 16+")
elif (grade < 1):
    print("Before Grade 1")
else:
    print(f"Grade {round(grade)}")
