# include <stdio.h>
# include <cs50.h>
# include <string.h>

int main () {

    string s = get_string("Input: ");
    printf("Output: ");
    for (int i = 0, length = strlen(s); i < length; i++) {
        printf("%c", s[i]);
    }
    printf("\n");
}
