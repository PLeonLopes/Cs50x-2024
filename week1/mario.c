# include <stdio.h>
# include <cs50.h>

int main (void) {

    int height, row, col, spaces;
    do {
        height = get_int("Height (up to 8): ");
    } while (height < 1 || height > 8);

    for (row = 0; row < height; row++) {
        for(spaces = 0; spaces < (height - row - 1); spaces++) {
            printf(" ");
        }

        for (col = 0; col <= row; col++) {
            printf("#");
        }

        printf("  ");

        for (col = 0; col <= row; col++) {
            printf("#");
        }
        printf("\n");
    }
}
