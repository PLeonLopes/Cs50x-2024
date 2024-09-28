// IMPLEMENTS A LIST OF NUMBERS USING A LINKED LIST
# include <cs50.h>
# include <stdio.h>
# include <stdlib.h>

typedef struct node {
    int number;
    struct node *next;
} node;

int main (int argc, char *argv[]) {
    // memory for numbers
    node *list = NULL;

    // for each command-line argument
    for (int i = 1; i < argc; i++) {
        int number = atoi(argv[i]);

        // allocate node for number
        node *n = malloc(sizeof(node));
        if (n == NULL) {
            return 1;
        }
        n->number = number;
        n->next = NULL;

        // if list is empty
        if (list == NULL) {
            // this node is the whole list
            list = n;
        }

        // if number belongs at beginning of list
        else if (n->number < list->number) {
            n->next = list;
            list = n;
        }

        // if number belongs later in list
        else {
            // iterate over nodes in list
            for (node *ptr = list; ptr != NULL; ptr->next) {
                // if at end of list
                if (ptr->next == NULL) {
                    // append node
                    ptr->next = n;
                    break;
                }
                // if in middle of list
                if (n->number < ptr->next->number) {
                    n->next = ptr->next;
                    ptr->next = n;
                    break;
                }
            }
        }
    }
}
// INSERTION -> BIG O(n)
