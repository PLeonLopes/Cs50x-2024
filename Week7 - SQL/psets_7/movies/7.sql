-- In 7.sql, write a SQL query to list all movies released in 2010 and their ratings, in descending order by rating. For movies with the same rating, order them alphabetically by title.
SELECT movies.title, ratings.rating FROM movies JOIN ratings ON movies.id = ratings.movie_id WHERE year = 2010 ORDER BY rating DESC, title;

/*
OUTPUT:
+--------------------------------------+--------------+
|                title                      | rating  |
+--------------------------------------+--------------+
| The Game                                  |  9.8    |
| El último piso                            |  9.6    |
| María y los niños pobres                  |  9.4    |
| Moy otets Evgeniy                         |  9.4    |
| Townbiz                                   |  9.4    |
| Bots High                                 |  9.3    |
| From the Midst of Pain                    |  9.3    |
| Invisible Circus: No Dress Rehearsal      |  9.3    |
| My Sexuality: A Sensory Experience        |  9.3    |
| Poor No More                              |  9.3    |
|[...]                                      |         |
| Clownfish                                 |  1.2    |
| Hito no sabaku                            |  1.2    |
| Mastera poroka                            |  1.2    |
| Vixen Highway 2006: It Came from Uranus!  |  1.1    |
+-----------------------------------------------------+
Run Time: real 2.521 user 0.195175 sys 0.047898
*/
