#include "helpers.h"
#include <math.h>

// Convert image to grayscale (use ./filter -g ./images/infile.bmp ./images/outfile.bmp)
void grayscale(int height, int width, RGBTRIPLE image[height][width]) {
    // Loop over all pixels
    for (int i = 0; i < height; i++) {          // iterate through all the pixels for the height
        for (int j = 0; j < width; j++) {       // iterate through all the pixels for the width
            // Take average of red, green, and blue
            int averageRGB = round((image[i][j].rgbtRed + image[i][j].rgbtGreen + image[i][j].rgbtBlue) / 3.0);
            // Update pixel values
            image[i][j].rgbtRed = image[i][j].rgbtGreen = image[i][j].rgbtBlue = averageRGB;
        }
    }
    return;
}

// Convert image to sepia (use ./filter -s ./images/infile.bmp ./images/outfile.bmp)
void sepia(int height, int width, RGBTRIPLE image[height][width]) {
    // Loop over all pixels
    for (int i = 0; i < height; i++) {          // iterate through all the pixels for the height
        for (int j = 0; j < width; j++) {       // iterate through all the pixels for the width
            // Compute sepia values (SEPIA FORMULA (https://stackoverflow.com/questions/1061093/how-is-a-sepia-tone-created))
            float sepiaRed = round(0.393 * image[i][j].rgbtRed + 0.769 * image[i][j].rgbtGreen + 0.189 * image[i][j].rgbtBlue);
            float sepiaGreen = round(0.349 * image[i][j].rgbtRed + 0.686 * image[i][j].rgbtGreen + 0.168 * image[i][j].rgbtBlue);
            float sepiaBlue = round(0.272 * image[i][j].rgbtRed + 0.534 * image[i][j].rgbtGreen + 0.131 * image[i][j].rgbtBlue);

            // Check IF the values are over 255 (dont use "else if" ffs '-')
            if (sepiaRed > 255) {
                sepiaRed = 255;
            }
            if (sepiaGreen > 255) {
                sepiaGreen = 255;
            }
            if (sepiaBlue > 255) {
                sepiaBlue = 255;
            }

            // Update pixel with sepia values
            image[i][j].rgbtRed = round(sepiaRed);
            image[i][j].rgbtGreen = round(sepiaGreen);
            image[i][j].rgbtBlue = round(sepiaBlue);
        }
    }
    return;
}

// Reflect image horizontally (use ./filter -r ./images/infile.bmp ./images/outfile.bmp)
void reflect(int height, int width, RGBTRIPLE image[height][width]) {
    RGBTRIPLE buffer;
    // Loop over all pixels
    for (int i = 0; i < height; i++) {              // iterate through all the pixels for the height
        for (int j = 0; j < width / 2; j++) {       // iterate through all the pixels for the width
            // Swap pixels
            buffer = image[i][j];
            image[i][j] = image[i][width-j - 1];
            image[i][width - j - 1] = buffer;
        }
    }
    return;
}

// Blur image  (use ./filter -b ./images/infile.bmp ./images/outfile.bmp)
void blur(int height, int width, RGBTRIPLE image[height][width]) {

    RGBTRIPLE image_replica[height][width];
    for (int i = 0; i < height; i++) {          // iterate through all the pixels for the height
        for (int j = 0; j < width; j++) {       // iterate through all the pixels for the width
            float sum_red = 0, sum_green = 0, sum_blue = 0, total_pixels = 0;
            // Updating local values
            for (int up_height = i -1; up_height < i + 2; up_height++) {
                for (int up_width = j - 1; up_width < j + 2; up_width++) {

                    if (up_height >= 0 && up_width >= 0 && up_height < height && up_width < width) {      // validation check
                        sum_red += image[up_height][up_width].rgbtRed;
                        sum_green += image[up_height][up_width].rgbtGreen;
                        sum_blue += image[up_height][up_width].rgbtBlue;
                        total_pixels ++;
                    }

                }
            }
            // UPDATING NEW IMAGE
            image_replica[i][j].rgbtRed = round(sum_red / total_pixels);
            image_replica[i][j].rgbtGreen = round(sum_green / total_pixels);
            image_replica[i][j].rgbtBlue = round(sum_blue / total_pixels);
        }
    }
    // COPYING THE IMAGE REPLICA INTO THE IMAGE
    for (int i = 0; i < height; i++) {          // iterate through all the pixels for the height
        for (int j = 0; j < width; j++) {       // iterate through all the pixels for the width
            image[i][j] = image_replica[i][j];
        }
    }
    return;
}
