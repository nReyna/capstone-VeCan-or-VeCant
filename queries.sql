SELECT * FROM review r LIMIT 3;


SELECT c.id FROM category c LIMIT 3;

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

SELECT r.id, r.stars, b.name, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
LIMIT 3;

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

SELECT r.id, r.stars, b.name, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Chinese", "Mexican")
LIMIT 3;

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Vegetarian", "Vegan");

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -


CREATE TABLE 
IF NOT EXISTS fiveTab AS (
SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Vegetarian", "Vegan")
);

SELECT 
    *
FROM
    fiveTab
INTO OUTFILE '/var/lib/mysql-files/fiveTab.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

TABLE DUMP:
Query OK, 739148 rows affected (4.40 sec)


sudo mv /var/lib/mysql-files/fiveTab.csv .


SELECT 
    *
FROM
    fiveTab
INTO OUTFILE '/var/lib/mysql-files/fiveTab.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

# Completed 8.1.18
df.to_pickle("fiveCats.pkl")

# Completed 8.8.18 5:04pm
df.to_pickle("fiveCats_US.pkl")

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

SELECT 
    *
FROM
    vegTab
INTO OUTFILE '/var/lib/mysql-files/veg.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

https://stackoverflow.com/questions/32737478/how-should-i-tackle-secure-file-priv-in-mysql
https://stackoverflow.com/questions/37596163/disable-secure-priv-for-data-loading-on-mysql
sudo mv /var/lib/mysql-files/veg.csv .

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
CREATE TABLE 
IF NOT EXISTS vegTab AS (
    SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state, c.category FROM review r
    INNER JOIN business b ON r.business_id = b.id 
    INNER JOIN category c ON c.business_id = b.id
    WHERE c.category in ("Vegan") 
    LIMIT 500
);

category: Vegan
73453 rows in set (7 min 54.13 sec)

category: Mexican
301877 rows in set (46 min 14.57 sec)

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

CREATE TEMPORARY TABLE 
IF NOT EXISTS table2 AS (
SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Vegetarian", "Vegan") LIMIT 3);

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

SELECT * FROM INFORMATION_SCHEMA.INNODB_TEMP_TABLE_INFO\G

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

SELECT count(1) FROM review;
+----------+
| count(1) |
+----------+
|  5261669 |
+----------+
1 row in set (3.36 sec)

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

mysql> SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state, c.category FROM review r
    -> INNER JOIN business b ON r.business_id = b.id
    -> INNER JOIN category c ON c.business_id = b.id
    -> WHERE c.category in ("Mexican", "Chinese", "Indian", "Vegetarian", "Vegan")
    -> AND b.state in ("CA");
Empty set (0.25 sec)

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

SELECT * FROM category WHERE category LIKE 'American%' LIMIT 3;

SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category LIKE ("American%") OR c.category in ("Italian", "Mexican", "Chinese", "Indian") LIMIT 30;

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -



CREATE TABLE 
IF NOT EXISTS fiveCat AS (
SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category LIKE ("American%") OR c.category in ("Italian", "Mexican", "Chinese", "Indian") );

Query OK, 1892465 rows affected (5 hours 22 min 46.88 sec)
Records: 1892465  Duplicates: 0  Warnings: 0

# only US
# Completed 8.7.18 5:01pm
df.to_pickle("fiveCuisine.pkl")

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -


SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, 
    b.name, b.city, b.state, c.category FROM review r 
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id WHERE c.category in ("American%") LIMIT 3;

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

mysql> select count(1) from vegTab;
+----------+
| count(1) |
+----------+
|      500 |
+----------+
1 row in set (0.00 sec)

mysql> select count(1) from fiveCat;
+----------+
| count(1) |
+----------+
|  1892465 |
+----------+
1 row in set (2.10 sec)

mysql> select count(1) from fiveTab;
+----------+
| count(1) |
+----------+
|   739148 |
+----------+
1 row in set (0.80 sec)

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

CREATE TABLE 
IF NOT EXISTS vegTab AS (
    SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state, c.category FROM review r
    INNER JOIN business b ON r.business_id = b.id 
    INNER JOIN category c ON c.business_id = b.id
    WHERE c.category in ("Vegan") 
    LIMIT 500
);

SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Vegan") 
LIMIT 500;

 f.id AS review_id, 
SELECT DISTINCT c.category,b.id AS business_id FROM fiveTab f
INNER JOIN review r   ON f.id = r.id 
INNER JOIN business b ON b.id = r.business_id
INNER JOIN category c ON b.id = c.business_id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Vegetarian", "Vegan")
LIMIT 50;



## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

CREATE TABLE 
IF NOT EXISTS largerTable AS (
SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Italian", "Thai", "Vegetarian", "Vegan")
);

SELECT DISTINCT c.category, b.id, r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Italian", "Thai", "Vegetarian", "Vegan")
LIMIT 10;

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -



SELECT DISTINCT c.category, b.id AS business_id FROM fiveTab f
INNER JOIN review r   ON f.id = r.id 
INNER JOIN business b ON b.id = r.business_id
INNER JOIN category c ON b.id = c.business_id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Vegetarian", "Vegan")
LIMIT 50;



## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

SELECT DISTINCT c.category, b.id AS business_id, if(c.category="Vegan" OR c.category="Vegetarian", 1, 0) as Veggie
FROM fiveTab f
INNER JOIN review r   ON f.id = r.id 
INNER JOIN business b ON b.id = r.business_id
INNER JOIN category c ON b.id = c.business_id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Vegetarian", "Vegan")
LIMIT 20;


## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

SELECT DISTINCT x.business_id, if(x.category="Vegan" OR x.category="Vegetarian", 1, 0) as Veggie
FROM (
SELECT DISTINCT c.category, b.id AS business_id
FROM fiveTab f
INNER JOIN review r   ON f.id = r.id 
INNER JOIN business b ON b.id = r.business_id
INNER JOIN category c ON b.id = c.business_id
WHERE c.category in ("Mexican", "Chinese", "Indian")
LIMIT 20) x
LIMIT 12;



SELECT business_id SUM(category) as whuh
FROM foo
GROUP BY business_id;

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

SELECT DISTINCT c.category, b.id AS business_id, if(c.category="Vegan" OR c.category="Vegetarian", 1, 0) as Veggie
FROM fiveTab f
INNER JOIN review r   ON f.id = r.id 
INNER JOIN business b ON b.id = r.business_id
INNER JOIN category c ON b.id = c.business_id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Vegetarian", "Vegan")
LIMIT 20;

mysql> SELECT business_id, SUM(category = "Vegan") as bigv, SUM(category= "Indian") as iindi FROM foo GROUP BY business_id;


SELECT DISTINCT c.category, b.id, r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Italian", "Thai", "Vegetarian", "Vegan")
LIMIT 20;


SELECT DISTINCT c.category, b.id AS business_id, r.id AS review_id, b.state FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Italian", "Thai", "Vegetarian", "Vegan")
LIMIT 20;

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -


CREATE TABLE 
IF NOT EXISTS catMap AS (
SELECT DISTINCT c.category, b.id AS business_id, r.id AS review_id, b.state FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Italian", "Thai", "Vegetarian", "Vegan")
AND b.state NOT IN ("EDH", "ON", "QC")
);

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -



CREATE TABLE 
IF NOT EXISTS largeRevTable AS (
SELECT DISTINCT r.id AS review_id, b.id AS business_id, c.category, r.stars, r.date, r.text, 
r.useful, r.funny, r.cool, b.name, b.city, b.state FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Italian", "Thai", "Vegetarian", "Vegan")
AND b.state NOT IN ("EDH", "ON", "QC")
);

ran 8.8.18 10pm

mysql> CREATE TABLE
    -> IF NOT EXISTS largeRevTable AS (
    -> SELECT DISTINCT r.id AS review_id, b.id AS business_id, c.category, r.stars, r.date, r.text,
    -> r.useful, r.funny, r.cool, b.name, b.city, b.state FROM review r
    -> INNER JOIN business b ON r.business_id = b.id
    -> INNER JOIN category c ON c.business_id = b.id
    -> WHERE c.category in ("Mexican", "Chinese", "Indian", "Italian", "Thai", "Vegetarian", "Vegan")
    -> AND b.state NOT IN ("EDH", "ON", "QC")
    -> );
Query OK, 932959 rows affected (2 hours 12 min 0.69 sec)
Records: 932959  Duplicates: 0  Warnings: 0

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

ran 8.9.18 7am

mysql> CREATE TABLE
    -> IF NOT EXISTS catMap AS (
    -> SELECT DISTINCT c.category, b.id AS business_id, r.id AS review_id, b.state FROM review r
    -> INNER JOIN business b ON r.business_id = b.id
    -> INNER JOIN category c ON c.business_id = b.id
    -> WHERE c.category in ("Mexican", "Chinese", "Indian", "Italian", "Thai", "Vegetarian", "Vegan")
    -> AND b.state NOT IN ("EDH", "ON", "QC")
    -> );

Query OK, 932959 rows affected (1 hour 51 min 1.21 sec)
Records: 932959  Duplicates: 0  Warnings: 0

## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

SELECT DISTINCT c.category, b.id AS business_id, if(c.category="Vegan" OR c.category="Vegetarian", 1, 0) as Veggie
FROM fiveTab f
INNER JOIN review r   ON f.id = r.id 
INNER JOIN business b ON b.id = r.business_id
INNER JOIN category c ON b.id = c.business_id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Vegetarian", "Vegan")
LIMIT 20;

SELECT 
    business_id, 
    SUM(category = "Vegan") as bigv, 
    SUM(category= "Indian") as iindi 
FROM foo 
GROUP BY business_id;

catMap
SELECT DISTINCT c.category, b.id AS business_id, r.id AS review_id, b.state FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Italian", "Thai", "Vegetarian", "Vegan")
AND b.state NOT IN ("EDH", "ON", "QC")
LIMIT 10;

SELECT business_id, category, SUM(category = "Vegan") as bigv
FROM catMap 
GROUP BY business_id
LIMIT 10;


SELECT * FROM catMap LIMIT 10;

SELECT
DISTINCT category,
business_id,
if(category="Vegan" OR category="Vegetarian", 1, 0) as Veggie
FROM catMap 
ORDER BY business_id
LIMIT 40;



SELECT 
    x.business_id, 
    SUM(x.category = "Vegan") as Vegan, 
    SUM(x.category= "Indian") as Indian,
    SUM(x.category= "Mexican") as Mexican
FROM (
SELECT
DISTINCT category,
business_id,
if(category="Vegan" OR category="Vegetarian", 1, 0) as Veggie
FROM catMap 
ORDER BY business_id
LIMIT 40 ) x
GROUP BY x.business_id;

SELECT 
    x.business_id,
    SUM( (x.category = "Vegetarian") OR (x.category = "Vegan")) as vegFriendly,
    SUM(x.category = "Vegan") as Vegan, 
    SUM(x.category = "Vegetarian") as Vegetarian,
    SUM(x.category = "Thai") as Thai,
    SUM(x.category = "Italian") as Italian,
    SUM(x.category = "Indian") as Indian,
    SUM(x.category = "Chinese") as Chinese,
    SUM(x.category = "Mexican") as Mexican
FROM (
SELECT
DISTINCT category,
business_id
FROM catMap 
ORDER BY business_id) x
GROUP BY x.business_id
LIMIT 35;

("Mexican", "Chinese", "Indian", "Italian", "Thai", "Vegetarian", "Vegan")

SELECT * FROM largeRevTable LIMIT 10;