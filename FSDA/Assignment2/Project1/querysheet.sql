USE for_practice;

/* ---------------------------------------------------------------------------------------------------------------------------------------------------- */
/* Create Tables */
CREATE TABLE accident(
	accident_index VARCHAR(13),
    accident_severity INT
);

CREATE TABLE vehicles(
	accident_index VARCHAR(13),
    vehicle_type VARCHAR(50)
);

/* First: for vehicle types, create new csv by extracting data from Vehicle Type sheet from Road-Accident-Safety-Data-Guide.xls */
CREATE TABLE vehicle_types(
	vehicle_code INT,
    vehicle_type VARCHAR(10)
);
/* ---------------------------------------------------------------------------------------------------------------------------------------------------- */


/* ---------------------------------------------------------------------------------------------------------------------------------------------------- */
/* Load Data */
LOAD DATA INFILE "C:\\Notes\\Statistics\\Assignments\\FSDA_assignments\\Assignment2_SQL\\Dataset\\Accidents_2015.csv"
INTO TABLE accident
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @dummy, @dummy, @dummy, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, accident_severity=@col2;

LOAD DATA INFILE "C:\\Notes\\Statistics\\Assignments\\FSDA_assignments\\Assignment2_SQL\\Dataset\\Vehicles_2015.csv"
INTO TABLE vehicles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, vehicle_type=@col2;

LOAD DATA INFILE "C:\\Notes\\Statistics\\Assignments\\FSDA_assignments\\Assignment2_SQL\\Dataset\\vehicle_types.csv"
INTO TABLE vehicle_types
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
/* ---------------------------------------------------------------------------------------------------------------------------------------------------- */


/* ---------------------------------------------------------------------------------------------------------------------------------------------------- */
/* Create Tables */
CREATE TABLE accident(
	accident_index VARCHAR(13),
    accident_severity INT
);

CREATE TABLE vehicles(
	accident_index VARCHAR(13),
    vehicle_type VARCHAR(50)
);

/* First: for vehicle types, create new csv by extracting data from Vehicle Type sheet from Road-Accident-Safety-Data-Guide.xls */
CREATE TABLE vehicle_types(
	vehicle_code INT,
    vehicle_type VARCHAR(10)
);
/* ---------------------------------------------------------------------------------------------------------------------------------------------------- */


/* ---------------------------------------------------------------------------------------------------------------------------------------------------- */
/* Load Data */
LOAD DATA INFILE "C:\\Notes\\Statistics\\Assignments\\FSDA_assignments\\Assignment2_SQL\\Dataset\\Accidents_2015.csv"
INTO TABLE accident
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @dummy, @dummy, @dummy, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, accident_severity=@col2;

LOAD DATA INFILE "C:\\Notes\\Statistics\\Assignments\\FSDA_assignments\\Assignment2_SQL\\Dataset\\Vehicles_2015.csv"
INTO TABLE vehicles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
SET accident_index=@col1, vehicle_type=@col2;

LOAD DATA INFILE "C:\\Notes\\Statistics\\Assignments\\FSDA_assignments\\Assignment2_SQL\\Dataset\\vehicle_types.csv"
INTO TABLE vehicle_types
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
/* ---------------------------------------------------------------------------------------------------------------------------------------------------- */
call acc;
call veht;
call veh;

/* ---------------------------------------------------------------------------------------------------------------------------------------------------- */
# 2. Evaluate Accident Severity and total accidents per vehicle type 
SELECT t3.vehicle_type, t1.accident_severity, COUNT(t3.vehicle_type) AS "Number of Accidents"
FROM accident t1
INNER JOIN vehicles t2 ON t1.accident_index = t2.accident_index
Inner JOIN vehicle_types t3 ON t2.vehicle_type = t3.vehicle_code
GROUP BY t3.vehicle_type
ORDER BY 2, 3;

# 3. Calculate Average Severity By Vehicle Type
SELECT t3.vehicle_type, AVG(t1.accident_severity)
FROM accident t1
INNER JOIN vehicles t2 ON t1.accident_index = t2.accident_index
Inner JOIN vehicle_types t3 ON t2.vehicle_type = t3.vehicle_code
GROUP BY t3.vehicle_type
ORDER BY 2;

# 4. Average Severity and Total Accidents by Motorcyle
SELECT vt.vehicle_type AS 'Vehicle Type', AVG(a.accident_severity) AS 'Average Severity', COUNT(vt.vehicle_type) AS 'Number of Accidents'
FROM accident a
JOIN vehicles v ON a.accident_index = v.accident_index
JOIN vehicle_types vt ON v.vehicle_type = vt.vehicle_code
WHERE vt.vehicle_type LIKE '%otorcycle%'
GROUP BY 1
ORDER BY 2,3;

