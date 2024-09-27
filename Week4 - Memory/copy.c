# include <stdio.h>
# include <cs50.h>
# include <string.h>
# include <ctype.h>     // toupper() / tolower()
# include <stdlib.h>     // malloc()

int main (void) {
    char *s = get_string("S: ");
    if (s == NULL) {
        return 1;
    }

    char *t = malloc(strlen(s+1));      // (s+1) due to "\0"
    if (t == NULL) {
        return 1;
    }

    strcpy(t, s);

    if (strlen(t) > 0) {
        t[0] = toupper(t[0]);
    }

    printf("%s\n", s);
    printf("%s\n", t);

    free(t);
    return 0;
}
