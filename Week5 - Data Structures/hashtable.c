// HASH TABLES -> "array of linked lists" (BIG O(n))
# include <stdio.h>
# include <stdlib.h>
# include <ctype.h>

typedef struct node {       // hash table structure
    char *name;
    char *number;
    struct node *next;
} node;

unsigned int hash(const char *word) {
    return toupper(word[0] - 'A');      // gives a number between 0 and 25 (errors if non ascii)
}

int main (void) {
    node *table[26];        // hash table (size 26)
}
