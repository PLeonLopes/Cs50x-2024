-- In 5.sql, write a SQL query to list the titles and release years of all Harry Potter movies, in chronological order.
SELECT title, year FROM movies WHERE title LIKE 'Harry Potter%' ORDER BY year ASC;

/*
OUTPUT:
+-------------------------------------------------+------+
|                      title                      | year |
+-------------------------------------------------+------+
| Harry Potter and the Sorcerer's Stone           | 2001 |
| Harry Potter and the Chamber of Secrets         | 2002 |
| Harry Potter and the Prisoner of Azkaban        | 2004 |
| Harry Potter and the Goblet of Fire             | 2005 |
| Harry Potter und ein Stein                      | 2006 |
| Harry Potter and the Order of the Phoenix       | 2007 |
| Harry Potter and the Half-Blood Prince          | 2009 |
| Harry Potter and the Deathly Hallows: Part 1    | 2010 |
| Harry Potter and the Deathly Hallows: Part 2    | 2011 |
| Harry Potter and the Untold Stories of Hogwarts | 2012 |
| Harry Potter: A History of Magic                | 2017 |
+-------------------------------------------------+------+
Run Time: real 0.074 user 0.071095 sys 0.003139
*/
