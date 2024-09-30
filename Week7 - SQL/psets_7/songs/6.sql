-- In 6.sql, write a SQL query that lists the names of songs that are by Post Malone.
SELECT name FROM songs WHERE artist_id = (SELECT id FROM artists WHERE name = 'Post Malone');

/*
output:
+------------------------------+
|             name             |
+------------------------------+
| rockstar (feat. 21 Savage)   |
| Psycho (feat. Ty Dolla $ign) |
| Better Now                   |
| I Fall Apart                 |
| Candy Paint                  |
| Congratulations              |
+------------------------------+
*/
