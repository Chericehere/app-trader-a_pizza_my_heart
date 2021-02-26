--Both Tables, ratings, income
SELECT name, rating1, rating2,
	ROUND((-10000 * price1) + (5000 * (rating1/.125)) + (-1000*(rating1/.125)),2) AS Net_income_by_rating,
	ROUND((-10000 * price1) + (5000 * (rating2/.125)) + (-1000*(rating2/.125)),2) AS Net_income_by_rating2
FROM
	(SELECT DISTINCT(UPPER(a.name)) AS name, CAST(a.price AS NUMERIC(10,2))AS price1, a.rating AS rating1, a.content_rating AS c_rating1, a.primary_genre AS genre1, 
									p.price AS price2, p.rating AS rating2, p.content_rating AS c_rating2, p.genres AS genre2
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name)) AS combo
ORDER BY net_income_by_rating DESC


--Count overlap between the 2 datasets
select sum((case when name in (select name from play_store_apps) then 1 else 0 end)) as overlap_ct, count(*) as apple_ct
from app_store_apps


--App name and price comparison between stores
select a.name, a.price as apple_price, p.price AS google_price
FROM app_store_apps a,
	play_store_apps p
where a.name = p.name 

--Cost of purchasing app App$*10000
SELECT a.name, a.price AS apple_price, SUM(a.price*10000) AS app_purchase_cost, p.price AS google_price, SUM(CAST(p.price AS int)*10000) AS play_purchase_cost
FROM app_store_apps a,
	play_store_apps p
where a.name = p.name 

--Number of Genres
SELECT count(DISTINCT primary_genre) FROM app_store_apps

SELECT count(DISTINCT genres) FROM play_store_apps


SELECT a.name, a.rating, CAST(a.price AS numeric (10,2)), a.primary_genre, p.name, p.rating, CAST(p.price AS numeric(10,2)), p.genres
FROM app_store_apps AS a,
	play_store_apps AS p
WHERE a.name = p.name