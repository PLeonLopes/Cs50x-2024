-- In 12.sql, write a SQL query to list the titles of all movies in which both Bradley Cooper and Jennifer Lawrence starred.
SELECT title FROM movies JOIN stars ON movies.id = stars.movie_id JOIN people ON people.id = stars.person_id WHERE name = 'Helena Bonham Carter' AND title
IN (SELECT title FROM movies JOIN stars ON movies.id = stars.movie_id JOIN people ON people.id = stars.person_id WHERE name = 'Johnny Depp');

/*
OUTPUT:
+------------------------------------------------+
|                     title                      |
+------------------------------------------------+
| Corpse Bride                                   |
| Charlie and the Chocolate Factory              |
| Sweeney Todd: The Demon Barber of Fleet Street |
| Alice in Wonderland                            |
| Dark Shadows                                   |
| Alice Through the Looking Glass                |
+------------------------------------------------+
Run Time: real 4.382 user 3.069698 sys 1.280230
*/
