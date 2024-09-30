-- In 4.sql, write a SQL query that lists the names of any songs that have danceability, energy, and valence greater than 0.75.
SELECT name FROM songs WHERE danceability > 0.75 AND energy > 0.75 AND valence > 0.75;
/*
output:
+---------------------------------------------+
|                    name                     |
+---------------------------------------------+
| Nice For What                               |
| Shape of You                                |
| Dura                                        |
| Me Niego                                    |
| Finesse (Remix) [feat. Cardi B]             |
| Freaky Friday (feat. Chris Brown)           |
| Sin Pijama                                  |
| Dejala que vuelva (feat. Manuel Turizo)     |
| Feel It Still                               |
| 1, 2, 3 (feat. Jason Derulo & De La Ghetto) |
| Criminal                                    |
| Bella                                       |
+---------------------------------------------+
*/
