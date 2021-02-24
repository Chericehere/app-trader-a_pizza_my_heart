SELECT a.name, CAST(a.price AS money), a.rating, a.primary_genre
FROM app_store_apps AS a
UNION
SELECT p.name, CAST(p.price AS money), p.rating, p.genres
FROM play_store_apps AS p
WHERE rating IS NOT NULL
ORDER BY rating DESC, price DESC


SELECT name, genres
from play_store_apps

SELECT name, primary_genre
from app_store_apps

SELECT name, CAST(price AS money), rating, a.primary_genre
FROM app_store_apps

SELECT p.name, CAST(p.price AS money), p.rating, p.genres
FROM play_store_apps
WHERE rating IS NOT NULL
ORDER BY rating DESC, App_Price DESC
