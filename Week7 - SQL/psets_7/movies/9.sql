-- In 9.sql, write a SQL query to list the names of all people who starred in a movie released in 2004, ordered by birth year.
SELECT DISTINCT name FROM people JOIN stars ON stars.person_id = people.id JOIN movies ON movies.id = stars.movie_id WHERE year = 2004 ORDER BY birth ASC;

/*
OUTPUT:
+--------------------------+
|           name           |
+--------------------------+
| Amelia Barrett           |
| Sean Miller              |
| Jonny Spanish            |
| Julienne Hanzelka Kim    |
| G. Zachariah White       |
| Sam Dean                 |
| Sophia Dean              |
|[...]                     |
| Sandro Iannotta          |
| Vasiliy Brykov           |
| Ahsaas Channa            |
| Tiffany McManus          |
+--------------------------+
Run Time: real 5.634 user 1.980546 sys 1.455927
*/
