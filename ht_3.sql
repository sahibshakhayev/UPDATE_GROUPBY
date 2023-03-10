/* Database Employees */
/* 1. Получить empid, firstname, lastname, country, region, city всех работников из USA.			  */
/* 2. Получить количество работников по каждой специальности.										  */
/* 3. Посчитать сколько людей на каждое имя.														  */
/* 4. Получить самое распространенное имя.															  */
/* 5. Получить наименее распространенное имя.														  */
/* 6. Получить топ 5 городов, где больше всего работников.											  */
/* 7. Получить топ 5 городоа, в которых больше всего уникальных специальностей.						  */
/* 8. Выдать почтовые адреса для email-рассылки всем работникам, которые начали работать с 1/01/2012. */
/* 9. Выдать статистику в каком году сколько работников было нанято.								  */
/* 10. Выдать статистику в каком году сколько работников по каким странам было нанято.				  */
/* 11. Обновить таблицу Employees добавив данные из таблицы History в колонку EndDate.				  */
/* 12. Выдать статистику сколько работников в какой год уволилось.									  */
/* 13. Выдать количество работников, которые проработали меньше года.								  */

Use Employees

-- 1
SELECT BusinessEntityID, FirstName, LastName, CountryRegionName, City
FROM Employees
WHERE CountryRegionName = N'United States'


-- 2
SELECT JobTitle, COUNT(JobTitle) AS CountByJob
FROM Employees
GROUP BY JobTitle




-- 3
SELECT FirstName, COUNT(FirstName) AS CountByName
FROM Employees
GROUP BY FirstName


--4
SELECT TOP(1) FirstName, COUNT(FirstName) AS CountByName
FROM Employees
GROUP BY FirstName
ORDER BY CountByName DESC

--5
SELECT TOP(1) FirstName, COUNT(FirstName) AS CountByName
FROM Employees
GROUP BY FirstName
ORDER BY CountByName


--6
SELECT TOP(5) City, COUNT(City) AS CountbyCity
FROM Employees
GROUP BY City
ORDER BY CountbyCity DESC

--7
SELECT DISTINCT TOP(5) City, JobTitle, COUNT(JobTitle) AS CountbyJob
FROM Employees
GROUP BY City, JobTitle
ORDER BY CountbyJob DESC

-- 8
SELECT EmailAddress
FROM Employees
WHERE StartDate >= N'01-01-2012'

-- 9
SELECT  YEAR(StartDate) AS [Year],  COUNT(*) AS CountbyYear
FROM Employees
GROUP BY YEAR(StartDate)

--10
SELECT  YEAR(StartDate) AS [Year],  COUNT(*) AS CountbyYear, CountryRegionName
FROM Employees
GROUP BY YEAR(StartDate), CountryRegionName
ORDER BY YEAR(StartDate)


--11
UPDATE Employees 
SET EndDate = History.EndDate
FROM History
WHERE Employees.BusinessEntityID = History.BusinessEntityID





--12
SELECT YEAR(EndDate), COUNT(*)
FROM History
GROUP BY YEAR(EndDate)
HAVING YEAR(EndDate) IS NOT NULL


-- 13
SELECT COUNT(*)
FROM History
WHERE YEAR(EndDate) - YEAR(StartDate) < 1