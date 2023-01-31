--1.	How many rows are in the data_analyst_jobs table?
Select COUNT(*)
From data_analyst_jobs;
--Answer: 1793

--2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
Select *
From data_analyst_jobs
Limit 10;
--Answer: ExxonMobil

--3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
Select Count(*)
From data_analyst_jobs
Where location = 'TN';
--Answer: 21

--How many are there in either Tennessee or Kentucky?
Select Count(*)
From data_analyst_jobs
Where location IN ('TN', 'KY');
--Answer: 27

--4.	How many postings in Tennessee have a star rating above 4?
Select Count(*)
From data_analyst_jobs
Where location = 'TN'
	AND star_rating > 4.0;
--Answer: 3

--5.	How many postings in the dataset have a review count between 500 and 1000?
Select Count(*)
From data_analyst_jobs
Where review_count Between 500 AND 1000;
--Answer: 151

--6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?
Select location AS state, AVG(star_rating) AS avg_rating
From data_analyst_jobs
Group BY location
Order BY avg_rating DESC;
--Answer: NE

--7.	Select unique job titles from the data_analyst_jobs table. How many are there?
Select Count(Distinct title)
From data_analyst_jobs;
--Answer: 881

--8.	How many unique job titles are there for California companies?
Select Count(Distinct title)
From data_analyst_jobs
Where location = 'CA';
--Answer: 230

--9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
Select company, AVG(star_rating) AS avg_rating
From data_analyst_jobs
Where review_count > 5000
Group By company;

--How many companies are there with more that 5000 reviews across all locations?
Select Count(company)
From data_analyst_jobs
Where review_count > 5000;
--Answer: 184

--10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
Select company, AVG(star_rating) AS avg_rating
From data_analyst_jobs
Where review_count > 5000
	AND company IS NOT NULL
Group By company
Order By avg_rating DESC;
--Answer: Unilever, GM, Nike, AE, Miicrosoft, KP = 4.1999

--11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 
Select Count(Distinct title)
From data_analyst_jobs
Where title iLike '%Analyst%';
--Answer: 774

--12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
Select title
From data_analyst_jobs
Where title NOT ILIKE '%Analyst%'
	And title NOT ILIKE '%Analytics%';
--Answer: 4 Jobs / Tableau and Visualization

--*BONUS*
--1. You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
Select domain, skill
From data_analyst_jobs
Where skill iLIKE '%SQL%'
	And days_since_posting >= 21;

--2. Disregard any postings where the domain is NULL. 
Select Count(domain)
From data_analyst_jobs
Where skill iLIKE '%SQL%'
	And days_since_posting >= 21
	And domain IS NOT NULL;
--Answer: 420

--3. Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top.
Select Distinct domain, COUNT(Distinct title) AS hard_to_fill
From data_analyst_jobs
Where skill iLIKE '%SQL%'
	And days_since_posting >= 21
	And domain IS NOT NULL
Group BY domain
Order By hard_to_fill DESC;

--4. Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?
Select Distinct domain, COUNT(Distinct title) AS hard_to_fill_jobs
From data_analyst_jobs
Where skill iLIKE '%SQL%'
	And days_since_posting >= 21
	And domain IS NOT NULL
Group BY domain
Order By hard_to_fill_jobs DESC
Limit 4;
--Internet/Software(43), HealthCare(41), Services[Banks/Financial(39), Consulting/Business(33)]