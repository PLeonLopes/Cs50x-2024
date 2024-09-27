# include <stdio.h>
# include <cs50.h>
# include <string.h>        // strcmp

int main (void) {

    char *s = get_string("S: ");
    char *t = get_string("T: ");

    /* COMPARING USING STRCMP AND POINTERS
    if (strcmp(s, t) == 0) {                // pay attention to the POINTER (to get the data in the address) (if {*s == *t})
        printf("Same\n");
    } else {
        printf("Different\n");
    }
    */

   printf("%p\n", s);       // we can print with or without the & (ex: printf("%p\n", s); OR printf("%p\n", &s);
   printf("%p\n", t);       // we can print with or without the & (ex: printf("%p\n", t); OR printf("%p\n", &t);
}
