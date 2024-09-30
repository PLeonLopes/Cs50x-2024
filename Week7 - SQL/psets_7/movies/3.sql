-- In 3.sql, write a SQL query to list the titles of all movies with a release date on or after 2018, in alphabetical order.
SELECT title FROM movies WHERE year >= 2018 ORDER BY title;

/*
OUTPUT:
+------------------------------------------------------------------------------------+
| 3: An Abstract Film About Identity                                                 |
| 3:15 am                                                                            |
| 3:30PM                                                                             |
| 3:33                                                                               |
| 3AM                                                                                |
| 3AM on Frenchmen                                                                   |
| [...]                                                                              |
| Üç Harfliler: Adak                                                                 |
| Üç Harflilerin Musallat Oldugu Büyülü Konakta Ruh Çagiran Gençlerin Hazin Hikayesi |
| Üçlü Pürüz                                                                         |
| Þegiðu og syntu                                                                    |
| Τhe Last Prayer                                                                    |
+------------------------------------------------------------------------------------+
Run Time: real 84.506 user 0.203529 sys 0.849615
*/
