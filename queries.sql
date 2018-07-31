SELECT * FROM review r LIMIT 3;


SELECT c.id FROM category c LIMIT 3;


SELECT r.id, r.stars, b.name, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
LIMIT 3;

SELECT r.id, r.stars, b.name, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Chinese", "Mexican")
LIMIT 3;

SELECT r.id, r.stars, r.date, r.text, r.useful, r.funny, r.cool, b.name, b.city, b.state, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
WHERE c.category in ("Mexican", "Chinese", "Indian", "Vegetarian", "Vegan") AND b.state in ("OH")
LIMIT 30;

