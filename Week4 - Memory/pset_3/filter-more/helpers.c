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

// Blur image (use ./filter -b ./images/infile.bmp ./images/outfile.bmp)
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

// Detect edges (use ./filter -e ./images/infile.bmp ./images/outfile.bmp)
void edges(int height, int width, RGBTRIPLE image[height][width]) {

    RGBTRIPLE image_copy[height][width];

    // Creating "Sobel Operator" values in an array
    int gx_array[] = {-1, 0, 1,
                      -2, 0, 2,
                      -1, 0, 1};

    int gy_array[] = {-1, -2, -1,
                       0,  0,  0,
                       1,  2,  1};

    for (int i = 0; i < height; i++) {          // iterate through all the pixels for the height
        for (int j = 0; j < width; j++) {       // iterate through all the pixels for the width

            int gx_red = 0, gx_green = 0, gx_blue = 0, gy_red = 0, gy_green = 0, gy_blue = 0;
            int counter = 0;                        // goes through all the indexes in the gx and gy arrays
            // Updating local values
            for (int up_height = i -1; up_height < i + 2; up_height++) {
                for (int up_width = j - 1; up_width < j + 2; up_width++) {

                    // NEGATION OF EDGE CONDITION (values == 0,0,0) -> if the pixel is in the edge condition, it's already 0 (already initialized).
                    if (!(up_height < 0 || up_width < 0 || up_height >= height || up_width >= width)) {
                        // GX values
                        gx_red = gx_red + gx_array[counter] * image[up_height][up_width].rgbtRed;
                        gx_green = gx_green + gx_array[counter] * image[up_height][up_width].rgbtGreen;
                        gx_blue = gx_blue + gx_array[counter] * image[up_height][up_width].rgbtBlue;
                        // GY values
                        gy_red = gy_red + gy_array[counter] * image[up_height][up_width].rgbtRed;
                        gy_green = gy_green + gy_array[counter] * image[up_height][up_width].rgbtGreen;
                        gy_blue = gy_blue + gy_array[counter] * image[up_height][up_width].rgbtBlue;
                    }
                    counter++;
                }
            }
            int final_red = round(sqrt(pow(gx_red, 2) + pow(gy_red, 2)));
            int final_green = round(sqrt(pow(gx_green, 2) + pow(gy_green, 2)));
            int final_blue = round(sqrt(pow(gx_blue, 2) + pow(gy_blue, 2)));

            // Checking if the values does not over-exceed 255!
            image_copy[i][j].rgbtRed = (final_red > 255) ? 255:final_red;
            image_copy[i][j].rgbtGreen = (final_green > 255) ? 255:final_green;
            image_copy[i][j].rgbtBlue = (final_blue > 255) ? 255:final_blue;
        }
    }
    // UPDATING IMAGE (finally)
    for (int i = 0; i < height; i++) {      // iterate through all the pixels for the height
        for (int j = 0; j < width; j++) {   // iterate through all the pixels for the width
            image[i][j] = image_copy[i][j];
        }
    }
    return;
}
