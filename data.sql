SELECT
	DISTINCT (UPPER(a.name)),
	a.price, a.content_rating, a.primary_genre,
	p.name, p.price, p.content_rating, p.genres
From app_store_apps AS a
Inner Join play_store_apps as p
ON UPPER(a.name) = UPPER(p.name)
Order by a.price;




/*SELECT DISTINCT(UPPER(a.name)),a.price,a.review_count,a.rating,a.content_rating,a.primary_genre, p.category, p.rating, p.review_count, p.size, p.install_count, p.type, p.price, p.content_rating, p.genres
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON UPPER(a.name) = UPPER(p.name)*/
