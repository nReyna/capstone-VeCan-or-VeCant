SELECT * FROM review r LIMIT 3;


SELECT c.id FROM category c LIMIT 3;


SELECT r.id, r.stars, b.name, c.category FROM review r
INNER JOIN business b ON r.business_id = b.id 
INNER JOIN category c ON c.business_id = b.id
LIMIT 3;