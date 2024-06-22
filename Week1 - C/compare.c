# include <stdio.h>
# include <cs50.h>

int main (void) {
    int x = get_int("Value of X: ");
    int y = get_int("Value of Y: ");

    if (x < y) {
        printf("%d(x) is less than %d(y)\n", x, y);
    } else if (x > y) {
        printf("%d(x) is greater than %d(y)!\n", x, y);
    } else {
        printf("%d(x) is equal to %d(y)!\n", x, y);
    }
}
