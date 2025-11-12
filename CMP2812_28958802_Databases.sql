# CMP2812 Full Stack Development
# Harrison Macdonald
# 28958802

# NEW YORK STATE PATROL DATABASE
# Creating the Database
CREATE DATABASE NYSPD;

# Accessing the database to intput data
USE NYSPD;

# Creating the table that hold Driver Information
CREATE TABLE Drivers (
FirstName Char(20),
LastName Char(20),
Address Varchar(50),
City Char(30),
State Char(20),
ZipCode Varchar(5),
DriverLicense int PRIMARY KEY,
StateIssuedLicense Varchar(15),	
BirthDate date,
HeightInCm Smallint,
Weight int,
EyeColour tinytext
);

# Creating the table that holds Vehicle Information
CREATE TABLE Vehicles (
DriversLicense int,
Colour Char(12),
make Char(20),
VIN Varchar(17) PRIMARY KEY,
LicensePlate Varchar(8),
RegisteredAddress Varchar(30),
StateRegistered Varchar(20),
RegisteredYear int,
CarType Varchar(20)
);

# Creating a table for officer details
CREATE TABLE Officers (
OfficerID int PRIMARY KEY AUTO_INCREMENT,
FirstName Varchar(30),
LastName Varchar(30),
PersonnelNumber int UNIQUE
);

# Creating the table that holds Notice details
CREATE TABLE CorrectionsNotice (
NoticeID int AUTO_INCREMENT PRIMARY KEY,
DriversLicense int,
noticeIssueDate date,
District Char(20),
Location Varchar(40),
ViolationTime time,
ViolationDesc Varchar(255),
Detachment Varchar(30),
OfficerID int,

FOREIGN KEY (DriversLicense) REFERENCES Drivers(DriverLicense),
FOREIGN KEY (OfficerID) REFERENCES Officers(OfficerID),

# Constraint created to make sure dates are issues 
CONSTRAINT DateCheck 
	CHECK (noticeIssuedate BETWEEN '2020-01-01' AND '2025-11-30')
);

# Creating a table to hold the actionID and a description of each action
CREATE TABLE Actions (
ActionID int PRIMARY KEY AUTO_INCREMENT,
ActionDesc Varchar(255)
);

# Creating IDs for notices issued
CREATE TABLE NoticeActions (
NoticeID int,
ActionID int,
PRIMARY KEY (NoticeID, ActionID),
FOREIGN KEY (NoticeID) REFERENCES CorrectionsNotice(NoticeID),
FOREIGN KEY (ActionID) REFERENCES Actions(ActionID)
);

# Creating 3 users, Admin, Officer and citizen
-- Admin (Complete access to the database)
CREATE USER 'admin_user'@'%' IDENTIFIED BY 'admin_pass';
GRANT ALL PRIVILEGES ON NYSPD.* TO 'admin_user'@'%';

-- Officer (view and edit CorrectionsNotice and NoticeActions)
CREATE USER 'officer_user'@'%' IDENTIFIED BY 'officer_pass';
GRANT SELECT, INSERT ON NYSPD.CorrectionsNotice TO 'officer_user'@'%';
GRANT SELECT, INSERT ON NYSPD.NoticeActions TO 'officer_user'@'%';

-- Violation Holder (read only, filtered access by DriversLicense)
CREATE USER 'citizen_user'@'%' IDENTIFIED BY 'citizen_pass';
GRANT SELECT ON NYSPD.CorrectionsNotice TO 'citizen_user'@'%';

# This creates a view only table that joins notices connected to each Drivers lincense
CREATE VIEW CitizenNotices AS
SELECT CN.DriversLicense, noticeIssueDate, District, Location, ViolationTime, ViolationDesc, Detachment, OfficerID
FROM CorrectionsNotice CN
JOIN Vehicles V ON CN.DriversLicense = V.DriversLicense;

# Adding data to my tables
# Creating and inserting data into the drivers table
INSERT INTO Drivers
VALUES ("Reuben", "Hoover", "53 Cambridge Court", "NYC", "NY", "11743", 822895210, "NY", '1979-12-02', 180, 102, "BL");
INSERT INTO Drivers
VALUES ("Mia", "Dahn", "3770 Main Street", "NYC", "NY", "11743", 688867828, "NY", '1998-04-29', 188, 96, "BL");
INSERT INTO Drivers
VALUES ("Tristan", "Wright", "7317 Clay Street", "NYC", "NY", "10036", 707157183, "NY", '2001-11-02', 179, 140, "GR");
INSERT INTO Drivers
VALUES ("Dave", "Martin", "937A York Street", "NYC", "NY", "11224", 496461347, "NY", '1976-11-29', 167, 87, "BR");

# Creating and inserting data into the Vehciles table
INSERT INTO Vehicles
VALUES ( 822895210, "White", "Peugeot", "2GCEC19WXX1260267","sds4234", "53 Cambridge Court", "NY", 2012, "208");
INSERT INTO Vehicles
VALUES (688867828, "Grey", "Jaguar", "SAJFA41C71N917210","afe9314", "3770 Main Street", "NY", 2001, "XK-Seriese");
INSERT INTO Vehicles
VALUES (707157183, "Black", "Ford", "1FDWF31507EA22867","fbq8724", "7317 Clay Street", "NY", 2025, "F-350 SD");
INSERT INTO Vehicles
VALUES (496461347, "White", "land Rover", "SALRGBBV9HA042091","bvh5623", "937A York Street", "NY", 2017, "Discovery");

# Creating officers to issue notices
INSERT INTO Officers (FirstName, LastName, PersonnelNumber)
VALUES ("Mark", "Sloan", 29351);
INSERT INTO Officers (FirstName, LastName, PersonnelNumber)
VALUES ("John", "ThoughtKnight", 51745);
INSERT INTO Officers (FirstName, LastName, PersonnelNumber)
VALUES ("Adam", "Francis", 77311);

# Notices to vehicle/driverslicense
INSERT INTO CorrectionsNotice (DriversLicense, noticeIssueDate, District, Location, ViolationTime, ViolationDesc, Detachment, OfficerID)
VALUES (822895210, '2025-11-05', "Brooklyn", "414 Hicks Street", '18:52:00', "Speeding", "Patrol Officer", 2);
INSERT INTO CorrectionsNotice (DriversLicense, noticeIssueDate, District, Location, ViolationTime, ViolationDesc, Detachment, OfficerID)
VALUES (688867828, '2025-10-30', "Brooklyn", "735 Avenue W", '14:42:00', "Texting while driving", "Patrol Officer", 1);
INSERT INTO CorrectionsNotice (DriversLicense, noticeIssueDate, District, Location, ViolationTime, ViolationDesc, Detachment, OfficerID)
VALUES (707157183, '2025-11-01', "Queens", "49th Street", '09:29:00', "Speeding", "HighwayPatrol Officer", 3);
INSERT INTO CorrectionsNotice (DriversLicense, noticeIssueDate, District, Location, ViolationTime, ViolationDesc, Detachment, OfficerID)
VALUES (496461347, '2025-10-02', "Bronx", "600 Clarence Avenue", '22:03:00', "Speeding", "HighwayPatrol Officer", 3);

# Available actions for the officer to issue 
INSERT INTO Actions (ActionDesc)
VALUES ("Warning Issued");
INSERT INTO Actions (ActionDesc)
VALUES ("Fine Issued");
INSERT INTO Actions (ActionDesc)
VALUES ("License Suspended");
INSERT INTO Actions (ActionDesc)
VALUES ("No Action");

# 10 QUEREIES

# Query #1 Simluates a citizen query related to License: 707157183
SELECT * FROM CitizenNotices
WHERE DriversLicense = 707157183;

# Query #2 Creates another Notice for the Drivers License 496461347
INSERT INTO CorrectionsNotice (DriversLicense, NoticeIssueDate, District, Location, ViolationTime, ViolationDesc, Detachment, OfficerID)
VALUES (496461347, '2025-11-12', "Queens", "45th Avenue", '02:48:00', "Multiple damaged rear lights", "Patrol Officer", 2);

# Query #3 Checks the database for under 21 drivers with a Notice
SELECT COUNT(*) AS Under21
FROM CorrectionsNotice CN
JOIN Drivers D ON CN.DriversLicense = D.DriverLicense
WHERE TIMESTAMPDIFF(YEAR, D.BirthDate, CN.noticeIssueDate) < 21;

# Query #4 Searches the database for drivers who have speeding notices 
SELECT NoticeID, ViolationDesc, Location, ViolationTime
FROM CorrectionsNotice
WHERE ViolationDesc LIKE 'Speeding';

# Query #5 Updating a correction notice and changing the Violation Description
UPDATE CorrectionsNotice
SET ViolationDesc = "Speeding in a school zone"	
WHERE NoticeID = 3;

# Viewing the change in description
SELECT * FROM CitizenNotices
WHERE DriversLicense = 822895210;

# Query #6 Displays the number of Violations at each location In the past 6 months
SELECT CN.Location, O.PersonnelNumber, COUNT(*) AS ViolationCount
FROM CorrectionsNotice CN
JOIN Officers O ON CN.OfficerID = O.OfficerID
WHERE CN.noticeIssueDate >= CURDATE() - INTERVAL 6 MONTH
GROUP BY CN.Location, O.PersonnelNumber;

# Query #7 simple query that deletes data from a table
DELETE FROM CorrectionsNotice
WHERE NoticeID = 2;

# query #8 joins 4 tables and uses a 5th as a junction
SELECT 
D.DriverLicense, D.FirstName, D.LastName,
V.Make, V.CarType,
CN.ViolationDesc, CN.Location, CN.noticeIssueDate,
A.ActionDesc
FROM Drivers D
JOIN Vehicles V ON D.DriverLicense = V.DriversLicense
JOIN CorrectionsNotice CN ON D.DriverLicense = CN.DriversLicense
JOIN NoticeActions NA ON CN.NoticeID = NA.NoticeID
JOIN Actions A ON NA.ActionID = A.ActionID
ORDER BY CN.noticeIssueDate DESC;

# Query #9 Drivers with multiple violations 
SELECT 
D.DriverLicense,
D.FirstName,
D.LastName,
COUNT(CN.NoticeID) AS ViolationCount,
V.Make,
V.CarType
FROM Drivers D
JOIN CorrectionsNotice CN ON D.DriverLicense =CN.DriversLicense
JOIN Vehicles V ON D.DriverLicense = V.DriversLicense
GROUP BY D.DriverLicense, V.VIN
HAVING COUNT(CN.NoticeID) > 1
ORDER BY ViolationCount DESC;

# Query #10 Checks for officers who have issues notices to mutliple districts
SELECT 
O.OfficerID,
O.FirstName,
O.LastName,
COUNT(DISTINCT CN.District) AS DistrictsCovered,
COUNT(CN.NoticeID) AS TotalNotices
FROM Officers O 
JOIN CorrectionsNotice CN ON O.OfficerID = CN.OfficerID
GROUP BY O.OfficerID
HAVING COUNT(DISTINCT CN.District) > 1
ORDER BY DistrictsCovered DESC;