#include <cs50.h>
#include <ctype.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    string text = get_string("Text: ");

    int ContLetters = 0;
    int ContWords = 1;                                              // Counter starts at 1 because it would have any space (' ') before the first word.
    int ContSentences = 0;

    for (int i = 0; i < strlen(text); i++)
    {
        if (isalpha(text[i]))
        {                                                       // IF ALPHA NUMERIC -> is a letter!
            ContLetters++;
        }
        else if (text[i] == ' ')
        {                                                       // counting the spaces
            ContWords++;
        }
        else if (text[i] == '.' || text[i] == '!' || text[i] == '?')
        {                                                       // i honestly dunno how to count sentences, thats a turn around - CHECKS FOR "." | "!" and "?"
            ContSentences++;
        }
    }

    float L = (float) ContLetters / (float) ContWords * 100;            // index = 0.0588 * L - 0.296 * S - 15.8 - CALCULATING L
    float S = (float) ContSentences / (float) ContWords * 100;          // index = 0.0588 * L - 0.296 * S - 15.8 - CALCULATING S

    int index = round(0.0588 * L - 0.296 * S - 15.8);           // index = 0.0588 * L - 0.296 * S - 15.8 - CALCULATING INDEX

    if (index < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (index > 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %i\n", index);
    }
}

/* index = 0.0588 * L - 0.296 * S - 15.8
em c ficaria: index = 0.0588 * average100 (sendo letters / words *100) - 0.296 * sentences100 (sendo sentences / words * 100 )
- 15.8 */
