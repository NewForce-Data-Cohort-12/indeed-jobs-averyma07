-- 1. How many rows are in the data_analyst_jobs table?
SELECT COUNT(*)
FROM data_analyst_jobs;
--1793

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10;
-- ExxonMobil

-- 3. How many postings are in Tennessee?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN';
-- 21
-- How many are there in either Tennessee or Kentucky?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';
--27

-- 4. How many postings in Tennessee have a star rating above 4?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating > 4;
-- 3

-- 5. How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
-- 151

-- 6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
SELECT DISTINCT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY state
ORDER BY avg_rating DESC NULLS LAST;
-- Nebraska

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT DISTINCT title
FROM data_analyst_jobs;
-- 881

-- 8. How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';
-- 230

-- 9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT company, AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company;
-- 41

-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT company, ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_rating DESC NULLS LAST;
-- General Motors (tied with 5 other companies), 4.2

-- 11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE UPPER(title) LIKE '%ANALYST%';
-- 774 distinct, 1669 total

-- 12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE UPPER(title) NOT LIKE '%ANALYST%' AND UPPER(title) NOT LIKE '%ANALYTICS%';
-- 4
-- What word do these positions have in common?
SELECT DISTINCT title
FROM data_analyst_jobs
WHERE UPPER(title) NOT LIKE '%ANALYST%' AND UPPER(title) NOT LIKE '%ANALYTICS%';
-- Tableau

-- BONUS. You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
--- Disregard any postings where the domain is NULL.
--- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
--- Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?
SELECT domain, COUNT(*)
FROM data_analyst_jobs
WHERE UPPER(skill) LIKE '%SQL%'
	AND days_since_posting > 21
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY COUNT(*) DESC;
-- 1) Internet and Software; 62
-- 2) Banks and Financial Services; 61
-- 3) Consulting and Business Services; 57
-- 4) Healthcare; 52