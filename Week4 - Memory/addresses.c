# include <stdio.h>
# include <cs50.h>      // Training wheels

int main (void) {
    /*
    int n = 50;
    int *p = &n;        // pointer p to x's memory address - (pointers tend to be 8 bytes (64 bit))
    printf("%p\n", &n);
    printf("%i\n", *p);
    */

    /* String indexes with pointers
    string s = "HI!";
    printf("%s\n", s);
    printf("%p\n", s);
    printf("%p\n", &s[0]);
    printf("%p\n", &s[1]);
    printf("%p\n", &s[2]);
    printf("%p\n", &s[3]);
    */

    char *s = "HI!";        // actual C-STRING (printf("%s\n", s);)

    // POINTER ARITHMETICS
    printf("%c", *s);           // same of s[0]
    printf("%c", *(s+1));       // same of s[1]
    printf("%c\n", *(s+2));     // same of s[2]
}
