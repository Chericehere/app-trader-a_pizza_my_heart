SELECT * FROM app_store_apps
limit 10

SELECT * FROM play_store_apps
limit 10

SELECT COUNT(name)
FROM app_store_apps
WHERE name IN (SELECT name 
	  FROM play_store_apps )
	  
select * from play_Store_apps 
limit 100

--Count overlap between the 2 datasets
select sum((case when name in (select name from play_store_apps) then 1 else 0 end)) as overlap_ct, count(*) as apple_ct
from app_store_apps


--App name and price comparison between stores
select a.name, a.price as apple_price, c.price  as google_price
FROM app_store_apps a,
	play_store_apps c
where a.name = c.name 

--incomplete
SELECT name AS app_name, price AS app_price, review_count, rating, content_rating, primary_genre AS genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name
ORDER BY price DESC
