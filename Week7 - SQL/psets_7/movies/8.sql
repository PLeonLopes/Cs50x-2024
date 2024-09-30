-- In 8.sql, write a SQL query to list the names of all people who starred in Toy Story.
SELECT name FROM people JOIN stars ON people.id = person_id JOIN movies ON movie_id = movies.id WHERE movies.title = 'Toy Story';

/*
OUTPUT:
+-------------+
|    name     |
+-------------+
| Tom Hanks   |
| Tim Allen   |
| Don Rickles |
| Jim Varney  |
+-------------+
Run Time: real 3.325 user 2.185198 sys 1.110752
*/
