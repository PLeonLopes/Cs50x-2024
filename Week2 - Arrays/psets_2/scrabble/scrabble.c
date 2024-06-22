#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

int pontos[] = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10}; // Valores do placar
int compute_score(string palavra);                                                               // protótipo da função

int main(void)
{
    // Players INPUT
    string pal1 = get_string("Jogador 1: ");
    int placar1 = compute_score(pal1);

    string pal2 = get_string("Jogador 2: ");
    int placar2 = compute_score(pal2);

    // print the winner
    if (placar1 > placar2)
    {
        printf("Player 1 wins!\n");
    }
    else if (placar2 > placar1)
    {
        printf("Player 2 wins!\n");
    }
    else
    {
        printf("Tie!\n");
    }
}

// EXTRA FUNCTION TO HELP
int compute_score(string palavra)
{

    int placar = 0;

    for (int i = 0; i < strlen(palavra); i++)
    {
        if (isupper(palavra[i]))
        {
            placar = placar + pontos[palavra[i] - 65];
        }
        if (islower(palavra[i]))
        {
            placar = placar + pontos[palavra[i] - 97];
        }
    }
    return placar;
}
