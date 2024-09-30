-- In 6.sql, write a SQL query to determine the average rating of all movies released in 2012.
SELECT AVG(rating) FROM ratings JOIN movies ON ratings.movie_id = movies.id WHERE year = 2012;

/*
OUTPUT:
+------------------+
|   AVG(rating)    |
+------------------+
| 6.28703681056622 |
+------------------+
Run Time: real 0.172 user 0.163545 sys 0.008231
*/
