use world;

#Riigipead s tähega
SELECT Name, HeadOfState
FROM country
WHERE HeadOfState LIKE 'S%';

#Riigipead q tähega
SELECT Name, HeadOfState
FROM country
WHERE HeadOfState LIKE '%q%';

#Kõige rohkemate riikidega riigipead
SELECT HeadOfState, COUNT(*) AS riikide_arv
FROM country
WHERE HeadOfState IS NOT NULL
GROUP BY HeadOfState
ORDER BY riikide_arv DESC
LIMIT 3;

#Riigid rahvaarvupoolest 10. - 30.
SELECT Name, Population
FROM country
ORDER BY Population DESC
LIMIT 30 OFFSET 9;

#Aafrika riikide keskmine eluiga
SELECT AVG(LifeExpectancy) AS keskmine_eluiga
FROM country
WHERE Continent = 'Africa'
AND LifeExpectancy IS NOT NULL;

#Aafrika keskmine eluiga
SELECT 
  SUM(LifeExpectancy * Population) / SUM(Population) 
    AS kaalutud_keskmine_eluiga
FROM country
WHERE Continent = 'Africa'
  AND LifeExpectancy IS NOT NULL;

#Kus kõige rohkem vabariike
SELECT Continent, COUNT(*) AS vabariikide_arv
FROM country
WHERE GovernmentForm LIKE '%Republic%'
GROUP BY Continent
ORDER BY vabariikide_arv DESC
LIMIT 1;
