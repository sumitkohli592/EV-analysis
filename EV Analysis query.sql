--"EV Charging Network Analysis: Data-Driven Insights for Sustainable Mobility"
--create a database EV_Charging
--import data from csv file 

----Basic Analysis
--Problem 1 Total Number of Customers

SELECT COUNT(*) AS "Total Customers"
FROM customers 

--Probelm 2 Total Number of Charging Stations

SELECT COUNT(*) AS "Total Stations"
FROM Stations

--Problems 3 Total Numbers of EV's

SELECT COUNT(*) AS "Total EV's"
FROM Vehicles

--Problems 4 Total Charging Sessions Recorded

SELECT COUNT(*) AS "Total Charging Sessions Recorded"
FROM sessions

-- Intermediate Analysis
--Problem 5 Top 5 Most Popular EV's Brand

SELECT TOP 5 brand, COUNT(*) AS "Vehicles sale"
FROM Vehicles
GROUP BY brand
ORDER BY "Vehicles sale" DESC

--Problem 6 Total Energy Consumption Across All Sessions

SELECT SUM(energy_consumed_kWh) AS "Total Energy Consumed"
FROM sessions

--Problem 7 Average Charging Cost Per Sessions

SELECT AVG(cost) AS "Average cost"
FROM sessions

-- Problem 8 Number of Customers by Subcription Type 

SELECT subscription, COUNT(*) AS "Total Customer as Subscription"
FROM Customers
GROUP BY subscription
ORDER BY subscription DESC

-- Problem 9 Charging Sessions Per Stations (Top 5 Busiest)

SELECT TOP 5 
s.station_id,
s.location,
COUNT(ss.session_id) AS "Total Sessions"
FROM Stations AS s
join sessions AS ss ON s.station_id = ss.station_id
GROUP BY s.station_id,s.location
ORDER BY "Total Sessions" DESC

-- --  Advance Analysis 
-- Problem 10 Extract Peak Charging Hours

SELECT 
    DATEPART(HOUR, start_time) AS hour, 
    COUNT(*) AS session_count
FROM sessions
GROUP BY DATEPART(HOUR, start_time)
ORDER BY session_count DESC

-- Problem 11 Monthly Revenue From Charging Sessions

SELECT FORMAT(start_time, 'yyyy-MM') AS month, 
SUM(cost) AS total_revenue
FROM sessions
GROUP BY FORMAT(start_time, 'yyyy-MM')
ORDER BY month ASC

-- Problem 12 Customers With Highest Charging Cost 

SELECT  top 10 C.customer_id, C.first_name, C.last_name,
SUM(s.cost) AS "Total Spent" 
FROM Customers AS C
JOIN Vehicles AS V ON V.customer_id = C.customer_id
JOIN sessions AS s ON V.vehicle_id = s.vehicle_id
GROUP BY C.customer_id, C.first_name, C.last_name
ORDER BY "Total Spent" DESC

-- Problem 13 EV with the Most Energy Consumption Over Time

SELECT V.vehicle_id,
V.brand,
V.model,
SUM(S.cost) AS Total_cost,
SUM(S.energy_consumed_kWh) AS Total_Energry_Consumed
FROM vehicles AS V
JOIN sessions AS S ON S.vehicle_id = V.vehicle_id
GROUP BY V.vehicle_id, V.brand, V.model
ORDER BY Total_cost DESC,Total_Energry_Consumed DESC

-- Problem 14 Station Utilization Rate (Top 5)

SELECT Top 5 S.station_id, S.location,
SUM(SS.session_id) AS "Total Usage"
FROM Stations AS S
JOIN sessions AS SS ON SS.station_id = S.station_id
GROUP BY S.station_id, S.location
ORDER BY "Total Usage" DESC

-- Problem 15 Battery Efficiency Analysis (Energy Used per Vehicle)

SELECT TOP 10
    V.vehicle_id, 
    V.brand, 
    V.model, 
    V.battery_capacity_kWh, 
    SUM(S.energy_consumed_kWh) / MAX(V.battery_capacity_kWh) AS Efficiency_Rate
FROM Vehicles AS V
JOIN sessions AS S 
    ON S.vehicle_id = V.vehicle_id
GROUP BY V.vehicle_id, V.brand, V.model, V.battery_capacity_kWh
ORDER BY Efficiency_Rate DESC

-- Problem 16 Location with the Most Charging Activity

SELECT ST.location,
SUM(S.session_id) AS "Total Sessions"
FROM Stations AS ST
JOIN sessions AS S ON S.station_id = ST.station_id
GROUP BY ST.location
ORDER BY "Total Sessions" DESC

EXEC sp_help 'vehicles';  -- Replace 'vehicles' with any table name











