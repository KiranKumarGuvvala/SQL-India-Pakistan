CREATE TABLE INDIA_PAK_BATTING (
PLAYER TEXT,
RUNS INT,
BALLS_PLAYED INT,
FOURS INT,
SIXES INT,
STRIKE_RATE FLOAT,
TEAM TEXT
);

INSERT INTO INDIA_PAK_BATTING VALUES
('ARSHDEEP SINGH', 9, 13, 1, 0, 69.23, 'IND'),
('AXAR PATEL', 20, 18, 2, 1, 111.11, 'IND'),
('BABAR AZAM', 13, 10, 2, 0, 130.0, 'PAK'),
('FAKHAR ZAMAN', 13, 8, 1, 1, 162.5, 'PAK'),
('HARDIK PANDYA', 7, 12, 1, 0, 58.33, 'IND'),
('HARIS RAUF', 0, 0, 0, 0, 0.0, 'PAK'),
('IFTIKHAR AHMED', 5, 9, 0, 0, 55.55, 'PAK'),
('IMAD WASIM', 15, 23, 1, 0, 65.21, 'PAK'),
('JASPRIT BUMRAH', 0, 1, 0, 0, 0.0, 'IND'),
('MOHAMMAD AMIR', 0, 0, 0, 0, 0.0, 'PAK'),
('MOHAMMAD RIZWAN', 31, 44, 1, 1, 70.45, 'PAK'),
('MOHAMMED SIRAJ', 7, 7, 0, 0, 100.0, 'IND'),
('NASEEM SHAH', 10, 4, 2, 0, 250.0, 'PAK'),
('RAVINDRA JADEJA', 0, 1, 0, 0, 0.0, 'IND'),
('RISHABH PANT', 42, 31, 6, 0, 135.48, 'IND'),
('ROHIT SHARMA', 13, 12, 1, 1, 108.33, 'IND'),
('SHADAB KHAN', 4, 7, 0, 0, 57.14, 'PAK'),
('SHAHEEN AFRIDI', 0, 1, 0, 0, 0.0, 'PAK'),
('SHIVAM DUBE', 3, 9, 0, 0, 33.33, 'IND'),
('SURYAKUMAR YADAV', 7, 8, 1, 0, 87.5, 'IND'),
('USMAN KHAN', 13, 15, 1, 0, 86.66, 'PAK'),
('VIRAT KOHLI', 4, 3, 1, 0, 133.33, 'IND');


SELECT*
FROM india_pak_batting;


create table INDIA_PAK_BOWLING(
PLAYER TEXT,
OVERS FLOAT,
RUNS INT,
MAIDEN_OVERS INT,
WICKETS INT,
ECONOMY FLOAT,
TEAM TEXT
);

INSERT INTO INDIA_PAK_BOWLING VALUES
('ARSHDEEP SINGH', 4.0, 31, 0, 1, 7.75, 'IND'),
('AXAR PATEL', 2.0, 11, 0, 1, 5.5, 'IND'),
('HARDIK PANDYA', 4.0, 24, 0, 2, 6.0, 'IND'),
('HARIS RAUF', 3.0, 21, 0, 3, 7.0, 'PAK'),
('IFTIKHAR AHMED', 1.0, 7, 0, 0, 7.0, 'PAK'),
('IMAD WASIM', 3.0, 17, 0, 0, 5.66, 'PAK'),
('JASPRIT BUMRAH', 4.0, 14, 0, 3, 3.5, 'IND'),
('MOHAMMAD AMIR', 4.0, 23, 0, 2, 5.75, 'PAK'),
('MOHAMMED SIRAJ', 4.0, 19, 0, 0, 4.75, 'IND'),
('NASEEM SHAH', 4.0, 21, 0, 3, 5.25, 'PAK'),
('RAVINDRA JADEJA', 2.0, 10, 0, 0, 5.0, 'IND'),
('SHAHEEN AFRIDI', 4.0, 29, 0, 1, 7.25, 'PAK');

select*
FROM india_pak_bowling;



-- Q1.Which players scored <15 runs for india?
SELECT Player,Runs
FROM india_pak_batting
WHERE Team = "Ind" AND Runs<15;

-- Q2.Who from india scored >10 runs, list in alphabetical order?
SELECT Player, Runs
FROM india_pak_batting
WHERE Team = "IND" and Runs >10 
ORDER BY  Player ASC;

-- Q3. Which bowler had <4 economy from both teams?
SELECT Player, Economy
FROM india_pak_bowling
WHERE Economy <4 AND Team = "IND" OR "PAK";

-- Q4.What is the highest batting score from both teams ?
WITH CTE AS (SELECT Player, Runs,
DENSE_RANK()OVER(ORDER BY RUNS DESC) AS Highest_Score
FROM india_pak_batting)

SELECT Player, Runs
FROM CTE
WHERE Highest_Score=1;

SELECT Player, Runs
FROM india_pak_batting
ORDER BY Runs desc
LIMIT 1;


-- Q5.Which team has >40 runs as the highest batting score?
	WITH CTE as (SELECT Runs, Team,
DENSE_RANK() OVER ( ORDER BY Runs DESC)  as rn
FROM india_pak_batting
)
SELECT Runs, Team
FROM CTE
WHERE rn =1;

-- Q6. What are the runs scored and wickets taken by Arshdeep Singh?
WITH CTE as (
	SELECT Player, Runs
    FROM india_pak_batting
    WHERE Player = "Arshdeep Singh"
    ),
    
	CTE1 as (
    SELECT Wickets,Player
    FROM india_pak_bowling
WHERE Player = "Arshdeep Singh")
    
SELECT cte.*,Cte1.Wickets
from cte 
LEFT JOIN CTE1
ON cte.Player=cte1.Player;

-- Q7. List all the players who hit atleast hit two four?
SELECT Player
FROM india_pak_batting
WHERE fours>=2;


-- Q8. Find the player who scored the highest runs?
SELECT Player, Runs  
FROM india_pak_batting
ORDER BY Runs DESC 
LIMIT 1;


-- Q9. Find the total number of boundaries ( fours and sixes ) by India?
SELECT SUM(fours) + SUM(sixes) as Total_Boundaries 
FROM india_pak_batting
WHERE Team = "IND";

-- Q 10 . Find the top Three player with the  highest strike rate?
SELECT Player,
 ROUND((CAST(runs as FLOAT )* 100.0/ balls_Played),2) as Strike_rate
 FROM india_pak_batting
 ORDER BY Strike_rate DESC
 LIMIT 3;
 
-- Q11. Find the Top 3  player with the lowest strike rate who scored atleast 10 runs?
SELECT Player , 
ROUND((CAST(runs as FLOAT )*100.0/ balls_played),2) as Lowest_Strike_Rate
FROM india_pak_batting
WHERE Runs>=10 
ORDER BY Lowest_Strike_Rate ASC 
LIMIT 3;


-- Q12 . Find the Top 3 economy rate of bowler?
SELECT Player , 
ROUND((CAST(runs as FLOAT )/overs),2) as Economy
FROM india_pak_bowling
ORDER BY Economy ASC 
LIMIT 3;


-- Q13. List the bowlers who did not take any wickets?
SELECT Player 
FROM india_pak_bowling
WHERE Wickets = 0;

-- Q14. Who bowled  the most economical overs ( lowset runs per over)?
SELECT Player ,
(CAST(runs as FLOAT )/ CAST(overs as FLOAT )) as Economy_rate
FROM india_pak_bowling
ORDER BY Economy_rate ASC 
LIMIT 1;

-- Q15. List the Top 3 Players with the highest individual scores from each team ?
WITH Ranked_Scores as (
 SELECT Player , Team ,Runs ,
 ROW_NUMBER () OVER ( PARTITION BY Team ORDER BY Runs DESC ) as Top_Rank
 FROM india_pak_batting
)
SELECT Player, Team, Runs
FROM  Ranked_Scores
WHERE Top_Rank <=3;

-- Q16. Calculate total runs scored by each team and run_rate ignoring Extra runs ?
WITH Team_Runs as (
SELECT Team, 
SUM(Runs ) as Total_Runs 
FROM india_pak_batting 
GROUP BY Team
),

Overs as (
SELECT 
CASE WHEN Team = "IND" THEN "PAK"
WHEN Team = "PAK" THEN "IND" END as Batting_Team,
SUM(Overs) as Total_Overs 
 FROM india_pak_bowling
 GROUP BY Team
 )
 
 SELECT r.Team, r.Total_Runs, o.Total_Overs,
 ROUND(CAST(r.Total_Runs as FLOAT ) / o.Total_Overs, 2 ) as Run_Rate
 FROM Team_Runs  as r
 INNER JOIN Overs as o
 ON r.Team=o.Batting_Team;
 


