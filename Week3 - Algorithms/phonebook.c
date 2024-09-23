# include <stdio.h>
# include <cs50.h>
# include <string.h>

int main (void) {

   /* OLD
   string names[] = {"Carter", "David", "John"};
   string numbers[] = {"+1-617-495-1000", "+1-617-496-1000", "+1-949-468-2750"};
   */

    typedef struct {
        string name;
        string number;
    } t_person;

    t_person people[3];

    people[0].name = "Carter";
    people[0].number = "+1-617-495-1000";

    people[1].name = "David";
    people[1].number = "+1-617-496-1000";

    people[2].name = "John";
    people[2].number = "+1-949-468-2750";


    string name = get_string("Name: ");

    for (int i = 0; i < 3; i++) {
        if (strcmp(people[i].name, name) == 0) {
            printf("Found %s\n", people[i].number);
            return 0;
        }
    }
    printf("Not Found!\n");
    return 1;
}
