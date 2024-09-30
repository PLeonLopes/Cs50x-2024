-- In 11.sql, write a SQL query to list the titles of the five highest rated movies (in order) that Chadwick Boseman starred in, starting with the highest rated.
SELECT title FROM movies, stars, people, ratings WHERE movies.id = stars.movie_id AND movies.id = ratings.movie_id AND people.id = stars.person_id AND name = 'Chadwick Boseman' ORDER BY rating DESC LIMIT 5;

/*
OUTPUT:
+--------------------------+
|          title           |
+--------------------------+
| 42                       |
| Black Panther            |
| Marshall                 |
| Ma Rainey's Black Bottom |
| Get on Up                |
+--------------------------+
Run Time: real 3.763 user 2.389027 sys 1.314695
*/
