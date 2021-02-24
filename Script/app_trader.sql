/*SELECT name, price
FROM
	(SELECT UPPER(name), name, price, CAST(review_count AS int), rating, primary_genre, content_rating
	FROM app_store_apps
	UNION
	SELECT UPPER(name), name, CAST(price AS money), review_count, rating, genres, content_rating
	FROM play_store_apps) as inter
ORDER BY price DESC*/

SELECT rating1, rating2
FROM
	(SELECT DISTINCT(UPPER(a.name)), a.price AS price1, a.rating AS rating1, a.content_rating AS c_rating1, a.primary_genre AS genre1, 
									p.price AS price2, p.rating AS rating2, p.content_rating AS c_rating2, p.genres AS genre2
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name))combo
WHERE AVG(rating1,rating2) < 2
	