1)/*Finding the countryId, country, capital, currency of the country with the lowest
population not including zero */
SELECT countryId, country, capital, currency
FROM country
WHERE population in (SELECT MIN(population) FROM country WHERE population <> 0);

/*determines how many cities per country*/
2)
SELECT country, COUNT(cityId) as "Num of Cities"
FROM country LEFT OUTER JOIN city 
USING (countryId)
GROUP BY countryID
ORDER BY COUNT(cityId) DESC, country;

3)--this needs to be fixed
SELECT countryid, country, COUNT(cityId) as "Num of Cities"
FROM city INNER JOIN country USING (countryId)
GROUP BY countryId
UNION 
SELECT countryid, country, 0
FROM country
WHERE countryid not in (select countryid from city)
ORDER BY 3 DESC, 2;

4)

5)
SELECT country, population, "Category"
FROM country
WHERE  population < 1000000 then "Category" = "remotely populated";
ORDER BY population 
ASC limit 200;

6)
SELECT country, population, CASE 
  WHEN population < 1000000 THEN "remotely populated"
  WHEN population > 1000000000 THEN "densely populated"
  ELSE "scarcely populated"
  END  "category"
FROM country
ORDER BY population 
ASC limit 200;

