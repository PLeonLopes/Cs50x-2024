-- In 1.sql, write a SQL query to list the titles of all movies released in 2008.
SELECT title FROM movies WHERE year = 2008;

/*
OUTPUT:
+--------------------------------------------------------------------------------------------------------------------------------------------+
| Sneg Tayot Ne Na Vsegda                                                                                                                    |
| Puteros                                                                                                                                    |
| [...]                                                                                                                                      |
| Baldurs Draumar                                                                                                                            |
| Peninkulma                                                                                                                                 |
+--------------------------------------------------------------------------------------------------------------------------------------------+
Run Time: real 17.867 user 0.071529 sys 0.064060
*/
