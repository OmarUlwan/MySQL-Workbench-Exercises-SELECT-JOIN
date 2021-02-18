# SQL Join exercise
#
USE world;
#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first

SELECT * FROM city WHERE Name LIKE 'ping%' ORDER BY Population ASC;

# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first

SELECT * FROM city WHERE Name LIKE 'ran%' ORDER BY Population DESC;

# 3: Count all cities

SELECT COUNT(*) FROM city;

# 4: Get the average population of all cities

SELECT AVG(Population) FROM city;

# 5: Get the biggest population found in any of the cities

SELECT Name, MAX(Population) FROM city; 

# 6: Get the smallest population found in any of the cities

SELECT Name, MIN(Population) FROM city; 

# 7: Sum the population of all cities with a population below 10000

SELECT SUM(Population) FROM city WHERE Population < 10000;

# 8: Count the cities with the countrycodes MOZ and VNM

SELECT COUNT(*) FROM city WHERE Countrycode in ('MOZ','VNM');

# 9: Get individual count of cities for the countrycodes MOZ and VNM

SELECT COUNT(*) FROM city GROUP BY  Countrycode in ('MOZ','VNM');

# 10: Get average population of cities in MOZ and VNM

SELECT AVG(Population) FROM city GROUP BY  Countrycode in ('MOZ','VNM');

# 11: Get the countrycodes with more than 200 cities

SELECT Countrycode, COUNT(*) FROM city GROUP BY Countrycode HAVING COUNT(*) >= 200; 

# 12: Get the countrycodes with more than 200 cities ordered by city count

SELECT Countrycode, COUNT(*) FROM city GROUP BY Countrycode HAVING COUNT(*) >= 200 ORDER BY COUNT(*) ASC;

# 13: What language(s) is spoken in the city with a population between 400 and 500 ?

SELECT city.Name,city.Population,countryLanguage.Language FROM city JOIN countryLanguage ON city.CountryCode = countryLanguage.CountryCode WHERE Population BETWEEN '400' AND '500';

# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them

SELECT city.Name,city.Population,countryLanguage.Language FROM city JOIN countryLanguage ON city.CountryCode = countryLanguage.CountryCode WHERE Population BETWEEN '500' AND '600';

# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)

SELECT city.Name,city.Population,country.Name FROM city JOIN country ON
 city.CountryCode = country.Code 
 WHERE country.Code = ANY (SELECT CountryCode FROM city WHERE Population LIKE '122199');

# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)

SELECT city.Name,city.Population,country.Name FROM city JOIN country ON
 city.CountryCode = country.Code 
 WHERE city.Population !='122199' and country.Code = ANY 
 (SELECT CountryCode FROM city WHERE Population LIKE '122199');

# 17: What are the city names in the country where Luanda is capital?

SELECT city.Name,country.Name,country.Capital FROM city JOIN country ON
 city.CountryCode = country.Code 
 WHERE country.Code = ANY (SELECT city.CountryCode FROM city JOIN country ON
 city.CountryCode = country.Code 
 WHERE country.Capital = ANY (SELECT ID FROM city WHERE Name='Luanda'));
 
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren

SELECT city.Name,country.Name,country.Capital,country.Region FROM city JOIN country ON
 city.CountryCode = country.Code 
 WHERE country.Region = ANY (SELECT country.Region FROM country JOIN city ON
 country.Code = city.CountryCode
 WHERE country.Capital = ANY (SELECT ID FROM city WHERE Name='Yaren'));
 
# 19: What unique languages are spoken in the countries in the same region as the city named Riga

SELECT countrylanguage.Language,countrylanguage.IsOfficial,country.Name,country.Capital,country.Region 
FROM countrylanguage JOIN country ON countrylanguage.CountryCode = country.Code 
 WHERE countrylanguage.IsOfficial='F' AND 
 country.Region = ANY (SELECT country.Region FROM country JOIN city ON
 country.Code = city.CountryCode
 WHERE country.Capital = ANY (SELECT ID FROM city WHERE Name='Riga'));
 
# 20: Get the name of the most populous city

SELECT city.Name,MAX(country.Population) FROM city JOIN country ON 
city.CountryCode = country.Code;
