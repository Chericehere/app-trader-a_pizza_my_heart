/*SELECT name, price
FROM
	(SELECT UPPER(name), name, price, CAST(review_count AS int), rating, primary_genre, content_rating
	FROM app_store_apps
	UNION
	SELECT UPPER(name), name, CAST(price AS money), review_count, rating, genres, content_rating
	FROM play_store_apps) as inter
ORDER BY price DESC
*/


SELECT name, rating1,
	ROUND((-10000 * price1) + (5000 * (rating1/.5+1)) + (-1000*(rating1/.5+1)),2) AS Net_income_by_rating
FROM
	(SELECT DISTINCT(UPPER(a.name)) AS name, CAST(a.price AS NUMERIC(10,2))AS price1, a.rating AS rating1, a.content_rating AS c_rating1, a.primary_genre AS genre1, 
									p.price AS price2, p.rating AS rating2, p.content_rating AS c_rating2, p.genres AS genre2
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name)) AS combo
ORDER BY net_income_by_rating DESC

