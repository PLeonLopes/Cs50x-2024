# include <stdint.h>
# include <stdio.h>
# include <stdlib.h>
# include <stdbool.h>       // bool

int main(int argc, char *argv[]) {
    // Accept a single command-line argument
    if (argc != 2) {
        printf("Usage: ./recover FILE\n");
        return 1;
    }

    // Open the memory card
    FILE *card = fopen(argv[1], "r");

    // found the jpeg? (bool)
    bool found_jpeg = false;
    int counter = 0;

    char filename[8];       // defining the array for the file name
    FILE *img = NULL;       // Initializing the new jpeg as null

    // Create a buffer for a block of data
    uint8_t buffer[512];

    // While there's still data left to read from the memory card
    while (fread(buffer, 1, 512, card) == 512) {        // buffer -> pointer where storing, 1 -> size of each element, 512 -> total size, card -> reading from file *card
        // Create JPEGs from the data
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0) {        // if it fits, we found the jpeg!
            found_jpeg = true;
        }
        if (found_jpeg == true) {
            if (counter != 0) {     // if NOT NEW JPEG (counter !=0)
                fclose(img);
            }
            // if new jpeg (counter == 0), CREATE A NEW JPEG
            sprintf(filename, "%03i.jpg", counter);
            img = fopen(filename, "w");
            fwrite(buffer, 1, 512, img);
            found_jpeg = false;                     // set back to FALSE
            counter++;                              // increment the counter
        } else if (counter != 0) {
            fwrite(buffer, 1, 512, img);        // writing new block...
        }
    }
    fclose(img);
    fclose(card);
}
