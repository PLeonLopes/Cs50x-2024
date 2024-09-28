// TRIES (digital tree) -> "tree of arrays" (BIG O(1) -> CONSTANT TIME)
# include <stdio.h>
# include <stdlib.h>

typedef struct node {
    struct node *children[26];
    char *number;
} node;

int main (void) {
    return 0;
}
// DOWNSIDE -> TAKES A LOT OF SPACE (a lot of null pointers)
