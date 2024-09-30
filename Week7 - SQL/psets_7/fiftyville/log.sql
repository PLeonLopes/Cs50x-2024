-- Keep a log of any SQL queries you execute as you solve the mystery. (it will be giant >:P)

.schema -- all tables
SELECT *  FROM people;

/*
| EARLY INFORMATIONS|

WHAT I KNOW:
- THEFT TOOK PLACE ON JULY(7) 28
- THEFT TOOK PLACE ON HUMPHREY STREET

GOALS:
. WHO THE THIEF IS
. WHERE THE THIEF ESCAPED TO
. WHO HELPED

TABLES:
airports                flights
atm_transactions        interviews
bakery_security_logs    passengers
bank_accounts           people
crime_scene_reports     phone_calls
*/

-- STEP 1) Find crime scene description
SELECT description FROM crime_scene_reports WHERE month = 7 AND day = 28 AND street = 'Humphrey Street';
/*
| Theft at 10:15am, 3 interviews and mentions of the bakery |

"Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
 Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.
 Littering took place at 16:36. No known witnesses."
*/

-- STEP 2) Looking through the crime scene interviews transcriptions
SELECT transcript FROM interviews WHERE day = 28 AND month = 7 AND transcript LIKE '%bakery%';
/*
| Ruth -    Thief drove away in a car (check security footage) |
| Eugene -  Thief used the ATM on Leggett Street |
| Raymond - Thief talked to someone about taking the earliest flight tomorrow (other person purchased the tickets) |

1) RUTH - Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away.
          If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.

2) Eugene - I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery,
            I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.

3) Raymond - As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call,
             I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
             The thief then asked the person on the other end of the phone to purchase the flight ticket.
*/

-- STEP 3) (CHECKING WITNESS 1 - RUTH) Looking through security footage and searching for cars that left parking lot that specific timestamp (10:15 - 10:25)
SELECT * FROM bakery_security_logs WHERE day = 28 AND month = 7 AND hour = 10 AND minute >= 15 AND minute <= 25;
/*
Executing this query, we get 8 license plates:
1 - 5P2BI95
2 - 94KL13X
3 - 6P58WS2
4 - 4328GD8
5 - G412CB7
6 - L93JTIZ
7 - 322W7JE
8 - 0NTHK55
*/

-- STEP 4) CHECK LICENSE PLATES (NAMES)
SELECT p.name, bakery_security_logs.license_plate from people AS p JOIN bakery_security_logs ON p.license_plate = bakery_security_logs.license_plate
WHERE bakery_security_logs.day = 28 AND bakery_security_logs.month = 7 AND bakery_security_logs.hour = 10
AND bakery_security_logs.minute >= 15 AND bakery_security_logs.minute <= 25;

/*
Executing the query above, we got the license plates and their corresponding owners:
(someone here is sus 0_0)
+---------+---------------+
|  name   | license_plate |
+---------+---------------+
| Vanessa | 5P2BI95       |
| Bruce   | 94KL13X       |
| Barry   | 6P58WS2       |
| Luca    | 4328GD8       |
| Sofia   | G412CB7       |
| Iman    | L93JTIZ       |
| Diana   | 322W7JE       |
| Kelsey  | 0NTHK55       |
+---------+---------------+
*/

-- STEP 5) (CHECKING WITNESS 2 - EUGENE) Looking through the ATM transactions
SELECT * FROM atm_transactions WHERE atm_location = 'Leggett Street' AND month = 7 AND day = 28;

/*
While checking for WITHDRAWS, we got 8 withdraws in total (and 1 deposit that doesnt matter in this case):
+-----+----------------+------+-------+-----+----------------+------------------+--------+
| id  | account_number | year | month | day |  atm_location  | transaction_type | amount |
+-----+----------------+------+-------+-----+----------------+------------------+--------+
| 246 | 28500762       | 2023 | 7     | 28  | Leggett Street | withdraw         | 48     |
| 264 | 28296815       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     |
| 266 | 76054385       | 2023 | 7     | 28  | Leggett Street | withdraw         | 60     |
| 267 | 49610011       | 2023 | 7     | 28  | Leggett Street | withdraw         | 50     |
| 269 | 16153065       | 2023 | 7     | 28  | Leggett Street | withdraw         | 80     |
| 275 | 86363979       | 2023 | 7     | 28  | Leggett Street | deposit          | 10     | -> IT DOES NOT MATTER, we looking for withdraws
| 288 | 25506511       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     |
| 313 | 81061156       | 2023 | 7     | 28  | Leggett Street | withdraw         | 30     |
| 336 | 26013199       | 2023 | 7     | 28  | Leggett Street | withdraw         | 35     |
+-----+----------------+------+-------+-----+----------------+------------------+--------+
 */

 -- STEP 6) TRYING TO GET PEOPLE ATM ID's with their NAMES
SELECT atm_transactions.*, people.name FROM people JOIN bank_accounts ON people.id = bank_accounts.person_id
JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number
WHERE month = 7 AND day = 28 AND atm_location = 'Leggett Street';

/*
USING THIS QUERY AND WITH THE POWER OF JOINS, WE COULD MATCH ATM ID's with NAMES:
+-----+----------------+------+-------+-----+----------------+------------------+--------+---------+
| id  | account_number | year | month | day |  atm_location  | transaction_type | amount |  name   |
+-----+----------------+------+-------+-----+----------------+------------------+--------+---------+
| 267 | 49610011       | 2023 | 7     | 28  | Leggett Street | withdraw         | 50     | Bruce   |
| 275 | 86363979       | 2023 | 7     | 28  | Leggett Street | deposit          | 10     | Kaelyn  | -> IT DOESN'T MATTER FOR US (deposit)
| 336 | 26013199       | 2023 | 7     | 28  | Leggett Street | withdraw         | 35     | Diana   |
| 269 | 16153065       | 2023 | 7     | 28  | Leggett Street | withdraw         | 80     | Brooke  |
| 264 | 28296815       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     | Kenny   |
| 288 | 25506511       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     | Iman    |
| 246 | 28500762       | 2023 | 7     | 28  | Leggett Street | withdraw         | 48     | Luca    |
| 266 | 76054385       | 2023 | 7     | 28  | Leggett Street | withdraw         | 60     | Taylor  |
| 313 | 81061156       | 2023 | 7     | 28  | Leggett Street | withdraw         | 30     | Benista |
+-----+----------------+------+-------+-----+----------------+------------------+--------+---------+
*/

-- STEP 7) (CHECKING WITNESS 3 - Raymond) - INVESTIGATING PHONE CALLS (60 seconds)
SELECT * FROM phone_calls WHERE month = 7 AND day = 28 AND duration < 60;

/*
USING THIS QUERY, WE GOT 9 PHONE CALLS ON THAT DAY AND < 60 SECONDS:
+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 221 | (130) 555-0289 | (996) 555-8899 | 2023 | 7     | 28  | 51       |
| 224 | (499) 555-9472 | (892) 555-8872 | 2023 | 7     | 28  | 36       |
| 233 | (367) 555-5533 | (375) 555-8161 | 2023 | 7     | 28  | 45       |
| 251 | (499) 555-9472 | (717) 555-1342 | 2023 | 7     | 28  | 50       |
| 254 | (286) 555-6063 | (676) 555-6554 | 2023 | 7     | 28  | 43       |
| 255 | (770) 555-1861 | (725) 555-3243 | 2023 | 7     | 28  | 49       |
| 261 | (031) 555-6622 | (910) 555-3251 | 2023 | 7     | 28  | 38       |
| 279 | (826) 555-1652 | (066) 555-9701 | 2023 | 7     | 28  | 55       |
| 281 | (338) 555-6650 | (704) 555-2131 | 2023 | 7     | 28  | 54       |
+-----+----------------+----------------+------+-------+-----+----------+
*/

-- STEP 8) NOW, WE GOTTA MATCH THE CALLERS PHONE AND NAMES
SELECT people.name, phone_calls.caller, phone_calls.receiver, phone_calls.duration FROM people JOIN phone_calls
ON people.phone_number = phone_calls.caller WHERE phone_calls.month = 7 AND phone_calls.day = 28 AND phone_calls.duration <= 60;
/*
WHEN EXECUTING THIS QUERY, WE GOT THE NAMES!
+---------+----------------+----------------+----------+
|  name   |     caller     |    receiver    | duration |
+---------+----------------+----------------+----------+
| Sofia   | (130) 555-0289 | (996) 555-8899 | 51       |
| Kelsey  | (499) 555-9472 | (892) 555-8872 | 36       |
| Bruce   | (367) 555-5533 | (375) 555-8161 | 45       |
| Kathryn | (609) 555-5876 | (389) 555-5198 | 60       |
| Kelsey  | (499) 555-9472 | (717) 555-1342 | 50       |
| Taylor  | (286) 555-6063 | (676) 555-6554 | 43       |
| Diana   | (770) 555-1861 | (725) 555-3243 | 49       |
| Carina  | (031) 555-6622 | (910) 555-3251 | 38       |
| Kenny   | (826) 555-1652 | (066) 555-9701 | 55       |
| Benista | (338) 555-6650 | (704) 555-2131 | 54       |
+---------+----------------+----------------+----------+
*/

-- STEP 9) FOLLOWING RAYMOND's HINT OF THE EARLIST FLIGHT, LETS TRY TO FIND THE FIFTYVILLE AIRPORT ID
SELECT * FROM AIRPORTS;
/*
+----+--------------+-----------------------------------------+---------------+
| id | abbreviation |                full_name                |     city      |
+----+--------------+-----------------------------------------+---------------+
| 1  | ORD          | O'Hare International Airport            | Chicago       |
| 2  | PEK          | Beijing Capital International Airport   | Beijing       |
| 3  | LAX          | Los Angeles International Airport       | Los Angeles   |
| 4  | LGA          | LaGuardia Airport                       | New York City |
| 5  | DFS          | Dallas/Fort Worth International Airport | Dallas        |
| 6  | BOS          | Logan International Airport             | Boston        |
| 7  | DXB          | Dubai International Airport             | Dubai         |
| 8  | CSF          | Fiftyville Regional Airport             | Fiftyville    | -> DEPARTURE
| 9  | HND          | Tokyo International Airport             | Tokyo         |
| 10 | CDG          | Charles de Gaulle Airport               | Paris         |
| 11 | SFO          | San Francisco International Airport     | San Francisco |
| 12 | DEL          | Indira Gandhi International Airport     | Delhi         |
+----+--------------+-----------------------------------------+---------------+
*/

-- STEP 10) USING THE INFORMATION OF ID-8 (foreign key), WE CAN LOOK THROUGH THE DEPARTURES
SELECT * FROM flights WHERE origin_airport_id = 8 AND flights.month = 7 AND flights.day = 29;
/*
USING THIS QUERY, WE COULD SEE INFORMATION OF DEPARTURES FROM THE FIFTYVILLE AIRPORT (id 8):
AND THE EARLIEST FLIGHT IS | FLIGHT ID 36 -> TO AIRPORT 4 |.
AS WE KNOW (because of the above query), ID 4 -> NEW YORK AIRPORT, SO WE CAN CONCLUDE THAT THE THIEF | ESCAPED TO NEW YORK |!
+----+-------------------+------------------------+------+-------+-----+------+--------+
| id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
+----+-------------------+------------------------+------+-------+-----+------+--------+
| 18 | 8                 | 6                      | 2023 | 7     | 29  | 16   | 0      |
| 23 | 8                 | 11                     | 2023 | 7     | 29  | 12   | 15     |
| 36 | 8                 | 4                      | 2023 | 7     | 29  | 8    | 20     |
| 43 | 8                 | 1                      | 2023 | 7     | 29  | 9    | 30     |
| 53 | 8                 | 9                      | 2023 | 7     | 29  | 15   | 20     |
+----+-------------------+------------------------+------+-------+-----+------+--------+
*/

-- STEP 11) AFTER ALL THE INVESTIGATION, WE CAN FINALLY COMBINE ALL THE INFORMATION, USING THE HITS FROM THE WITNESSES:
SELECT p.name FROM bakery_security_logs AS bsl
JOIN people AS p ON p.license_plate = bsl.license_plate
JOIN bank_accounts AS ba ON ba.person_id = p.id
JOIN atm_transactions AS atm ON atm.account_number = ba.account_number
JOIN phone_calls AS pc ON pc.caller = p.phone_number WHERE bsl.month = 7 AND bsl.day = 28 AND bsl.hour = 10 AND bsl.minute BETWEEN 15 AND 25
AND atm.atm_location = 'Leggett Street' AND atm.month = 7 AND atm.day = 28 AND atm.transaction_type = 'withdraw' AND pc.month = 7 AND pc.day = 28 AND pc.duration < 60;
/*
AFTER THIS LONG AND CONFUSING QUERY, WE HAVE ONLY TWO SUSPECTS:
+-------+
| name  |
+-------+
| Bruce |
| Diana |
+-------+
*/

-- STEP 12) CHECK IF BRUCE OR DIANA IS ON FLIGHT:
SELECT p.name FROM people AS p
JOIN passengers AS ps ON p.passport_number = ps.passport_number
WHERE ps.flight_id = 36
AND p.name IN ('Bruce', 'Diana');

/*
USING THIS QUERY, WE F I N A L L Y GOT THE CULPRIT
+-------+
| name  |
+-------+
| Bruce |
+-------+
*/

-- STEP 13) NOW, WE GOTTA DISCOVER WHO TF BRUCE CALLED:
SELECT p2.name AS receiver
FROM phone_calls as pc
JOIN people as p1 ON pc.caller = p1.phone_number
JOIN people as p2 ON pc.receiver = p2.phone_number
WHERE p1.name = 'Bruce' AND pc.month = 7 AND pc.day = 28 AND pc.duration < 60;
/*
EXECUTING THIS QUERY, WE shockingly DISCOVER THAT ROBIN WAS THE CALL RECEIVER
+----------+
| receiver |
+----------+
| Robin    |
+----------+
*/

-- THANKS CS50x FOR GIVING US THIS AMAZING CHALLENGE, INCREDIBLE FUN TO COMPLETE AND VERY EDUCATIONAL! >:D
