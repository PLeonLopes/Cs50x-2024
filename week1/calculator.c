# include <stdio.h>
# include <cs50.h>

int main (void) {
    int x = get_int("X: ");
    int y = get_int("Y: ");

    double z = ((double) x / (double) y);

    printf("Div: %.20f\n", z);
}
