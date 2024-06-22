#include <stdio.h>
#include <cs50.h>

int main(void)
{
    int cents, coins = 0;
    float change;

    do
    {
        change = get_float("Change Owed: "); // user input
    }
    while (change < 0);

    // Final value of change is equal to the value of coins
    cents = change;

    // Using while to discover the minimum ammount of coins
    while (cents >= 25)
    {
        cents = cents - 25; // subtracting quarters ($25)
        coins++;            // counting the number of coins
    }

    while (cents >= 10)
    {
        cents = cents - 10; // subtracting dimes ($10)
        coins++;            // counting the number of coins
    }

    while (cents >= 5)
    {
        cents -= 5; // subtracting nickels ($5)
        coins++;    // counting the number of coins
    }

    while (cents >= 1)
    {
        cents -= 1; // subtracting pennies ($1)
        coins++;    // counting the number of coins
    }

    printf("%i\n", coins); // final result
}
