-- In 10.sql, write a SQL query to list the names of all people who have directed a movie that received a rating of at least 9.0.
SELECT DISTINCT name FROM people, directors, ratings WHERE directors.person_id = people.id AND directors.movie_id = ratings.movie_id AND rating >= 9.0;

/*
OUTPUT:
+---------------------------+
|           name            |
+---------------------------+
| Francis Ford Coppola      |
| Meng-Hua Ho               |
| Richard Gilbert Abramson  |
| Michael Varhol            |
| Gilberto Martínez Solares |
| Richard Myers             |
| Allen Rosen               |
| Ludmil Staikov            |
| Christian Baudissin       |
| Frédéric Brenner          |
|[...]                      |
| Barbara Bentree           |
| Najib Ghallale            |
| S. Sudarmadji             |
| Santosh Kashyap           |
| Dhiraj Verma              |
+---------------------------+
Run Time: real 1.693 user 0.546133 sys 0.408588
*/
