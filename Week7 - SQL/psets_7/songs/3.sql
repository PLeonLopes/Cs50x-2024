-- In 3.sql, write a SQL query to list the names of the top 5 longest songs, in descending order of length.
SELECT name FROM songs ORDER BY duration_ms DESC LIMIT 5;

/*
output:
+-----------------------+
|         name          |
+-----------------------+
| Te Bote - Remix       |
| SICKO MODE            |
| Walk It Talk It       |
| Him & I (with Halsey) |
| Perfect               |
+-----------------------+
*/
