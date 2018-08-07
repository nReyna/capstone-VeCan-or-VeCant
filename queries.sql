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


## -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -


SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, 
    b.name, b.city, b.state, c.category FROM review r 
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id WHERE c.category in ("American%") LIMIT 3;