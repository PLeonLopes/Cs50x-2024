-- In 4.sql, write a SQL query to determine the number of movies with an IMDb rating of 10.0.
SELECT COUNT(title) FROM movies JOIN ratings ON movies.id = ratings.movie_id WHERE rating == 10;

/*
OUTPUT:
+--------------+
| COUNT(title) |
+--------------+
| 101          |
+--------------+
Run Time: real 0.038 user 0.033194 sys 0.002396
*/
