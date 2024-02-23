#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, string argv[]) // Using ARGC AND ARGV
{

    if (argc != 2)                       // More than 1 input necessary
    {
        printf("Usage: ./caeser key\n"); // if different from 2 return 1
        return 1;
    }

    for (int i = 0; i < strlen(argv[1]); i++) // Checks if the input is a negative integer
    {
        if (!isdigit(argv[1][i])) // if different negative return 1
        {
            printf("usage: ./caesar key");
            return 1;
        }
    }

    int k = atoi(argv[1]); // atoi (ASCII to integer) -> STRING to INT

    string plaintext = get_string("plaintext: "); // INPUT FROM USER

    printf("ciphertext: "); // encrypted text

    for (int j = 0; j < strlen(plaintext); j++)
    {
        if (isupper(plaintext[j])) // upper to lower skiping ascii
        {
            printf("%c", (plaintext[j] - 65 + k) % 26 + 65);
        }
        else if (islower(plaintext[j])) // lower to upper using ascii
        {
            printf("%c", (plaintext[j] - 97 + k) % 26 + 97);
        }
        else // in case it's not a letter
        {
            printf("%c", plaintext[j]);
        }
    }
    printf("\n");
}
