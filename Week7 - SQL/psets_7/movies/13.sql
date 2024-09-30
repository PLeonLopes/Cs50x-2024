-- In 13.sql, write a SQL query to list the names of all people who starred in a movie in which Kevin Bacon also starred.
SELECT DISTINCT(name) FROM people JOIN stars ON stars.person_id=people.id WHERE id IN (SELECT stars.person_id FROM stars WHERE stars.movie_id
IN (SELECT stars.movie_id FROM stars WHERE stars.person_id = (SELECT id FROM people WHERE name = 'Kevin Bacon' AND birth = 1958))) AND name != 'Kevin Bacon';

/*
OUTPUT:
+------------------------+
|          name          |
+------------------------+
| Tippi Hedren           |
| Orson Bean             |
| Clint Eastwood         |
| Frank Langella         |
| Maximilian Schell      |
| Jack Nicholson         |
| Jeff Bridges           |
| Robert De Niro         |
| James Caan             |
| Bob Balaban            |
| John Lithgow           |
| Kevin Costner          |
| Bob Hoskins            |
| Lindsay Crouse         |
| Steve Guttenberg       |
| Barbara Barrie         |
| Daniel Stern           |
| Meryl Streep           |
| Diane Lane             |
| Matt Dillon            |
| Morgan Freeman         |
| Rudy Ramos             |
| Peter Gallagher        |
| Fred Ward              |
| Tommy Citera           |
| Jennifer Jason Leigh   |
| Elizabeth McGovern     |
| Sean Penn              |
| Mickey Rourke          |
| Mark Keyloun           |
| Dianne Wiest           |
| Demi Moore             |
| Pete Seeger            |
| Tom Cruise             |
| Tess Harper            |
| Karen Young            |
| Maria Tucci            |
| David Strathairn       |
| Didi Velez             |
| Tom Atkins             |
| Kelly Preston          |
| David Alan Grier       |
| Nicolas Cage           |
| Jami Gertz             |
| Colin Firth            |
| Tom Hanks              |
| Kiefer Sutherland      |
| Lori Singer            |
| Elisabeth Shue         |
| John Malkovich         |
| Bill Paxton            |
| Emily Longstreth       |
| Bruce Payne            |
| Richard Blade          |
| Sean Astin             |
| Josh Brolin            |
| David Hayman           |
| Linda Fiorentino       |
| Mary Stuart Masterson  |
| Christian Slater       |
| Olympia Dukakis        |
| Kyra Sedgwick          |
| Elizabeth Perkins      |
| Robert Patrick         |
| Tim Robbins            |
| Paul Rodriguez         |
| Joe Mantegna           |
| Gary Oldman            |
| Jason Patric           |
| John Goodman           |
| Michael Beach          |
| Alec Baldwin           |
| Courtney Love          |
| Jonathan Ward          |
| K.C. Martel            |
| Andy Garcia            |
| Sam Rockwell           |
| Julia Roberts          |
| James Ray              |
| J.T. Walsh             |
| Brad Pitt              |
| Sarah Michelle Gellar  |
| Finn Carter            |
| Bridget Fonda          |
| Campbell Scott         |
| William Baldwin        |
| Kristin Dattilo        |
| Marcia Gay Harden      |
| Anthony LaPaglia       |
| Winston Ntshona        |
| Michael Gross          |
| Nathan Lane            |
| Mary-Louise Parker     |
| Embeth Davidtz         |
| Anna Chlumsky          |
| Elijah Wood            |
| Brendan Fraser         |
| Gary Sinise            |
| Kathryn Erbe           |
| Illeana Douglas        |
| Jennifer Aniston       |
| Ryan Reynolds          |
| Charles Gitonga Maina  |
| Yolanda Vazquez        |
| Brad Renfro            |
| Renée Zellweger        |
| Joseph Mazzello        |
| Andreas Michera        |
| Denise Richards        |
| Jim Cummings           |
| Minnie Driver          |
| Liv Tyler              |
| Charlize Theron        |
| Luke Wilson            |
| Neve Campbell          |
| Ben Affleck            |
| Stuart Townsend        |
| Yasiin Bey             |
| Djimon Hounsou         |
| Evan Rachel Wood       |
| Marian Seldes          |
| Carrie Preston         |
| Jay Mohr               |
| Calista Flockhart      |
| Kim Dickens            |
| Radha Mitchell         |
| Frankie Muniz          |
| Marin Hinkle           |
| Zachary David Cope     |
| Zooey Deschanel        |
| Emmy Rossum            |
| Peter Dinklage         |
| Mark Rendall           |
| Alison Lohman          |
| Michael Sheen          |
| Shea Whigham           |
| John Calley            |
| James McAvoy           |
| Garrett Hedlund        |
| Rob Corddry            |
| Logan Lerman           |
| Elliot Page            |
| Dominic Scott Kay      |
| Jeffrey Baxter         |
| Michael Cera           |
| Ray Stevenson          |
| Michael Fassbender     |
| Rainn Wilson           |
| Amanda Seyfried        |
| Colson Baker           |
| Miles Heizer           |
| Christophe Beck        |
| Jennifer Lawrence      |
| Sahajak Boonthanakit   |
| Vithaya Pansringarm    |
| Lucy Fry               |
| Judd Apatow            |
| Johnny A.              |
| Russell Ali            |
| Danny Bohnen           |
| Jacob Tremblay         |
| Casie Baker            |
| Joanna Angel           |
| Bill Gerber            |
| Theo Germaine          |
| Karen Anderson         |
| Carmine Appice         |
| Brittany Flickinger    |
| Danny Abelson          |
| Henry Beard            |
| David Mazouz           |
| Jill Anenberg          |
| Joel Cox               |
| Michael Bacon          |
| N. Paul Stookey        |
| Hays Wellford          |
| James Freedson-Jackson |
| Air Supply             |
| Avery Tiiu Essex       |
| Colin Blumenau         |
| Margie Adam            |
| Melanie DeMore         |
+------------------------+
Run Time: real 1.025 user 0.995203 sys 0.020031
*/
