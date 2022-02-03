/*
Project 1: Excelsior Mobile Report
Joshua Jayandran
*/

USE [21WQ_BUAN4210_Lloyd_ExcelsiorMobile];

--1
--A
SELECT TOP(2) City, COUNT(*) AS NumCustIn
FROM Subscriber
GROUP BY City
ORDER BY NumCustIn DESC;

--B
SELECT TOP(3) City, COUNT(*) AS NumCustIn
FROM Subscriber
GROUP BY City
ORDER BY NumCustIn ASC;

--C
SELECT PlanName, COUNT(PlanName) AS NumPeopleHave
FROM Subscriber
GROUP BY PlanName
ORDER BY NumPeopleHave DESC;

--2
--A
SELECT Type, COUNT(Type) AS NumUsers
FROM Device
GROUP BY Type;

--B
SELECT CONCAT(FirstName, ' ', LastName) AS Customers
FROM Subscriber
WHERE MDN IN
	(SELECT MDN
	 FROM DirNums
	 Where IMEI IN
		(SELECT IMEI
		 FROM Device
		 WHERE Type = 'Apple'));

--C
SELECT CONCAT(FirstName, ' ', LastName) AS Customers, YearReleased
FROM Subscriber AS SC, DirNums AS DN, Device AS D
WHERE SC.MDN = DN.MDN AND DN.IMEI = D.IMEI
AND YearReleased < 2018;

--3
SELECT TOP(3) City, SUM(DataInMB) AS DataUsed
FROM Subscriber AS S
	JOIN LastMonthUsage AS LMU
	ON S.MIN = LMU.MIN
WHERE PlanName NOT LIKE 'Unl%'
GROUP BY City
ORDER BY DataUsed DESC;

--Alternative 
SELECT TOP(3) City, SUM(DataInMB) AS DataUsed
FROM Subscriber AS S, LastMonthUsage AS LMU
WHERE S.MIN = LMU.MIN
AND PlanName NOT LIKE 'Unl%'
GROUP BY City
ORDER BY DataUsed DESC;


--4
--A
SELECT TOP(1) CONCAT(RTRIM(FirstName), ' ', RTRIM(LastName)) AS Customer, MAX(Total) AS TotalBill
FROM Subscriber AS S
	JOIN Bill AS B
	ON S.MIN = B.MIN
GROUP BY CONCAT(RTRIM(FirstName), ' ', RTRIM(LastName))
ORDER BY TotalBill DESC;

--B
SELECT Top(1) S.PlanName, SUM(B.Total) AS TotalCustBill
FROM Subscriber AS S
	JOIN MPlan AS MP
	ON S.PlanName =MP.PlanName
		JOIN Bill AS B
		ON S.MIN = B.MIN
GROUP BY S.PlanName
ORDER BY TotalCustBill DESC;

--5
--A
SELECT TOP(1)AreaCode, SUM(Minutes) AS TotalMinutes
FROM (SELECT *, SUBSTRING(MDN, 1, 3) AS AreaCode
	  FROM Subscriber) AS AreaCode
		JOIN LastMonthUsage AS LMU
		ON AreaCode.MIN = LMU.MIN
GROUP BY AreaCode
ORDER BY TotalMinutes DESC;



--B
SELECT City, Minutes
FROM Subscriber AS S
	JOIN LastMonthUsage AS LMU
	ON S.MIN = LMU.MIN
WHERE Minutes <200 OR Minutes >700
ORDER BY City, Minutes;

-- Report with Visualizations
--1
--A
SELECT CONCAT(RTRIM(FirstName),' ', RTRIM(LastName)) AS FullName, Minutes, DataInMB, Texts, Total
FROM Subscriber AS S
	JOIN LastMonthUsage AS LMU
	ON S.MIN = LMU.MIN
		JOIN Bill AS B
		ON S.MIN = B.MIN
ORDER BY FullName;

--B
SELECT City, AVG(Minutes) AS Minutes, AVG(DataInMB) AS DataInMB, AVG(Texts) AS Texts, AVG(Total) AS Total
FROM Subscriber AS S
	JOIN LastMonthUsage AS LMU
	ON S.MIN = LMU.MIN
		JOIN Bill AS B
		ON S.MIN = B.MIN
GROUP BY City;

--C
SELECT City, SUM(Minutes) AS TotalMinutes, SUM(DataInMB) AS TotalDataInMB, SUM(Texts) AS TotalTexts, SUM(Total) AS TotalCost
FROM Subscriber AS S
	JOIN LastMonthUsage AS LMU
	ON S.MIN = LMU.MIN
		JOIN Bill AS B
		ON S.MIN = B.MIN
GROUP BY City;

--D
SELECT S.PlanName, AVG(Minutes) AS Minutes, AVG(DataInMB) AS DataInMB, AVG(Texts) AS Texts, AVG(Total) AS Total
FROM Subscriber AS S
	JOIN LastMonthUsage AS LMU
	ON S.MIN = LMU.MIN
		JOIN Bill AS B
		ON S.MIN = B.MIN
GROUP BY S.PlanName;

--E
SELECT S.PlanName, SUM(Minutes) AS TotalMinutes, SUM(DataInMB) AS TotalDataInMB, SUM(Texts) AS TotalTexts, SUM(Total) AS TotalCost
FROM Subscriber AS S
	JOIN LastMonthUsage AS LMU
	ON S.MIN = LMU.MIN
		JOIN Bill AS B
		ON S.MIN = B.MIN
GROUP BY S.PlanName;
















	


