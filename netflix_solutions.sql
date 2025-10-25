-- netflix project
CREATE DATABASE netflixdb;
USE netflixdb;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

Select * from netflix;
-- 15 Business Problems

-- 1. Count the number of Movies vs TV Shows
SELECT 
   TYPE,COUNT(*) AS total_content
   FROM netflix
   GROUP BY type;

-- 2. Find the most common rating for movies and TV shows.
SELECT 
   type,
   rating
FROM 
(
  SELECT 
     type,
     rating,
     COUNT(*),
     RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
     FROM netflix GROUP BY 1,2
) AS t1
WHERE 
   ranking =1;
   
-- 3. List all movies released in a specific year (e.g., 2020).
SELECT * FROM netflix WHERE release_year = 2020;

-- 4 Find the top 5 countries with most content on Netflix.
SELECT country_name, COUNT(*) AS total_content
FROM netflix
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(country, ',', '","'), '"]'),
    '$[*]' COLUMNS(country_name VARCHAR(255) PATH '$')
) AS jt
WHERE country_name <> ''
GROUP BY country_name
ORDER BY total_content DESC
LIMIT 5;

-- 5. Identify the Longest Movie
SELECT *
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 10;

-- 6. Find Content Added in the Last 5 Years
SELECT *
 FROM netflix
 WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'
SELECT *
FROM netflix
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(REPLACE(director, '"', ''), ',', '","'), '"]'),
    '$[*]' COLUMNS (director_name VARCHAR(255) PATH '$')
) AS jt
WHERE director_name = 'Rajiv Chilaka'
  AND director IS NOT NULL
  AND director <> '';
  
-- 2ND APPROACH
SELECT *
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';

-- 8. List All TV Shows with More Than 5 Seasons
SELECT * FROM netflix 
WHERE type = 'TV Show'
 AND CAST(SUBSTRING_INDEX(duration, ' ',1)AS UNSIGNED) > 5;

-- 9. Count the Number of Content Items in Each Genre
SELECT genre_name AS genre, COUNT(*) AS total_content
FROM netflix
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(listed_in, ',', '","'), '"]'),
    '$[*]' COLUMNS (genre_name VARCHAR(255) PATH '$')
) AS jt
WHERE genre_name IS NOT NULL AND genre_name <> ''
GROUP BY genre_name
ORDER BY total_content DESC;

-- 10.Find each year and the average numbers of content release in India on netflix.
SELECT 
    country,
    release_year,
    COUNT(show_id) AS total_release,
    ROUND(
        COUNT(show_id) / CAST((SELECT COUNT(show_id) FROM netflix WHERE country = 'India') AS DECIMAL(10,2)) * 100,
        2
    ) AS avg_release
FROM netflix
WHERE country = 'India'
GROUP BY country, release_year
ORDER BY avg_release DESC;

-- 11. List All Movies that are Documentaries
SELECT * FROM netflix 
WHERE listed_in LIKE '%Documentaries%';

-- 12. Find All Content Without a Director
SELECT *
FROM netflix
WHERE director IS NULL OR director = '';

-- 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years
SELECT * 
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year > YEAR(CURDATE()) - 10;

-- 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India
SELECT actor_name AS actor, COUNT(*) AS total_titles
FROM netflix
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(casts, ',', '","'), '"]'),
    '$[*]' COLUMNS (actor_name VARCHAR(255) PATH '$')
) AS jt
WHERE country = 'India'
  AND actor_name IS NOT NULL AND actor_name <> ''
GROUP BY actor_name
ORDER BY total_titles DESC
LIMIT 10;

-- 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords
SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE 
            WHEN LOWER(description) LIKE '%kill%' 
              OR LOWER(description) LIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY category;
