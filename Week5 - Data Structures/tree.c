// BINARY TREE (BIG O(logN))
# include <stdio.h>
# include <stdlib.h>
# include <stdbool.h>

typedef struct node {
    int number;
    struct node *left;
    struct node *right;
} node;

// FUNCTIONS

// SEARCH in a binary tree
bool search(node *tree, int number) {
    if (tree == NULL) {                     // TREE IS NULL
        return false;
    } else if (number < tree->number) {     // SEARCH LEFT
        return search(tree->left, number);
    } else if (number > tree->number) {     // SEARCH RIGHT
        return search(tree->right, number);
    } else if (number == tree->number) {    // (or else) -> found!
        return true;
    }
    return 0;
}

// IT'S GREAT TO BALANCE TREES TO KEEP COOL ^^

int main (void) {

}
