// Implements a dictionary's functionality

# include <ctype.h>
# include <stdbool.h>
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <strings.h>

# include "dictionary.h"

// Represents a node in a hash table
typedef struct node {
    char word[LENGTH + 1];
    struct node *next;
} node;

int num_words = 0;      // will be used in the functions bellow

// TODO: Choose number of buckets in hash table
const unsigned int N = 26;

// Hash table
node *table[N];

// Returns true if word is in dictionary, else false
bool check(const char *word) {
    // TODO
    int hash_value = hash(word);
    node *cursor = table[hash_value];               // cursor to check each one of the values
    while (cursor != NULL) {
        if (strcasecmp(cursor->word, word) == 0) {
            return true;                            // found the word!
        } else {
            cursor = cursor->next;                  // not found YET! goes to the next
        }
    }
    return false;                                   // not found!
}

// Hashes word to a number
unsigned int hash(const char *word) {
    // TODO: Improve this hash function (nope, it works like this :P)
    return toupper(word[0]) - 'A';
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary) {
    // TODO
    for (int i = 0; i < N; i++) {
        table[i] = NULL;        // keep it new and fresh
    }
    FILE *dict_file = fopen(dictionary, "r");
    if (dict_file == NULL) {
        printf("NOT ABLE TO OPEN DICTIONARY!\n");
        return false;
    }
    char buffer[45];

    while(fscanf(dict_file, "%s", buffer) != EOF) {     // CHECKS IF RETURNS "EOF" (if not, it outputs "terminated") -> (eof -> end of file);
        node *new_word = malloc(sizeof(node));      // allocating memory to the node
        int hash_value = hash(buffer);
        strcpy(new_word->word, buffer);
        new_word->next = table[hash_value];         // following cs50 walkthrough
        table[hash_value] = new_word;
        num_words++;
    }
    fclose(dict_file);
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void) {
    // TODO (using "int num_words = 0";)
    return num_words;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void) {
    // TODO
    for (int i = 0; i < N; i++) {
        node *tmp = table[i];
        node *cursor = table[i];
        while (cursor != NULL) {
            cursor = cursor->next;
            free(tmp);
            tmp = cursor;
        }
    }
    return true;        // unloaded COMPLETED
}
