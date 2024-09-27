# include <stdio.h>

int main (void) {
    /* First use of scanf();
    int n;
    printf("N: ");
    scanf("%i", &n);
    printf("N: %i\n", n);
    */

    /* SEGMENTATION FAULT (CORE DUMPED) -> touched memory that shouldnt have been touched
    char *s;

    printf("S: ");
    scanf("%s", s);      // not using "&" because "char *s" is already a pointer
    printf("S: %s\n", s);
    */

    char s[4];

    printf("S: ");
    scanf("%s", s);
    printf("S: %s\n", s);
}
// DEMONSTRATION OF SCANF
// run with CLANG -> clang -o get -Wno-uninitialized get.c | being "get" the name of the program
