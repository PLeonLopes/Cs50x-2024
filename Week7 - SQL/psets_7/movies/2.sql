-- In 2.sql, write a SQL query to determine the birth year of Emma Stone.
SELECT birth FROM people WHERE name == "Emma Stone";

/*
OUTPUT:
+-------+
| birth |
+-------+
| 1988  |
+-------+
Run Time: real 0.192 user 0.177290 sys 0.013945
*/
