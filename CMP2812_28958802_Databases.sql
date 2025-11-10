
# NEW YORK STATE PATROL Database
# Creating the Database
CREATE DATABASE NYSPD;

# Accessing the database to intput data
USE NYSPD;

# Creating the table that hold Driver Information
CREATE TABLE DriverInformation (
FirstName Char(20),
LastName Char(20),
Address tinytext,
City tinytext,
State tinytext,
ZipCode int,
DriverLicense int PRIMARY KEY,
StateIssuedLicense tinytext,
BirthDate date,
Height tinytext,
Weight int,
EyeColour tinytext
);

# Creating the table that holds Vehicle Information
CREATE TABLE VehicleInformation (
DriversLicense int,
Colour tinytext,
make tinytext,
VIN Varchar(17) PRIMARY KEY,
LicensePlate Varchar(8),
RegisteredAddress tinytext,
StateRegistered tinytext,
RegisteredYear int,
CarType tinytext,
OwnerLastName Char(20)
);

# Creating the table that holds Violation Information
# This is the table that the violation holder sees
CREATE TABLE ViolationInformation (
ViolationID int PRIMARY KEY,
DriversLicense int,
ViolationDate date,
District tinytext,
ViolationLocation tinytext,
ViolationTime time,
ViolationDesc tinytext,
Detachment tinytext,

CONSTRAINT DateCheck CHECK (ViolationDate >= date(2020-01-01)
AND ViolationDate <= date(2026-03-03)),	

FOREIGN KEY (DriversLicense) REFERENCES DriverInformation(DriverLicense)
);

# Creating the table that holds officer information and actions
CREATE TABLE OfficerInformation (
OfficerLastName varchar(20),
PersonelNumber int PRIMARY KEY,
Detachment tinytext
);

# Creating the table that holds Violations 
# This is the table the officer sees
CREATE TABLE Violations (
ViolationID int,
PersonelID int,
VehicleVIN Varchar(17),

FOREIGN KEY (ViolationID) REFERENCES ViolationInformation(ViolationID),
FOREIGN KEY (PersonelID) REFERENCES OfficerInformation(PersonelNumber),
FOREIGN KEY (VehicleVIN) REFERENCES VehicleInformation(VIN)
);

# FirstName LastName Address City State ZipCode DriverLicense StateIssuedLicense BirthDate Height Weight EyeColour
INSERT INTO DriverInformation
VALUES ("Reuben", "Hoover", "53 Cambridge Court", "NYC", "NY", 11743, 822895210, "NY", '1979-12-2', "5'9", 102, "BL");
INSERT INTO DriverInformation
VALUES ("Mia", "Dahn", "3770 Main Street", "NYC", "NY", 11743, 688867828, "NY", '1998-04-29', "6'1", 96, "BL");
INSERT INTO DriverInformation
VALUES ("Tristan", "Wright", "7317 Clay Street", "NYC", "NY", 10036, 707157183, "NY", '2001-11-2', "5'10", 140, "GR");
INSERT INTO DriverInformation
VALUES ("Dave", "Martin", "937A York Street", "NYC", "NY", 11224, 496461347, "NY", '1976-11-29', "5'6", 87, "BR");

# VehicleLicense Colour make VIN RegisteredAddress StateRegistered RegisteredYear CarType OwnerLastName
INSERT INTO VehicleInformation
VALUES ( 822895210, "White", "Peugeot", "2GCEC19WXX1260267","sds4234", "53 Cambridge Court", "NY", 2012, "208", "Hoover");
INSERT INTO VehicleInformation
VALUES (688867828, "Grey", "Jaguar", "SAJFA41C71N917210","afe9314", "3770 Main Street", "NY", 2001, "XK-Serise", "Dahn");
INSERT INTO VehicleInformation
VALUES (707157183, "Black", "Ford", "1FDWF31507EA22867","fbq8724", "7317 Clay Street", "NY", 2025, "F-350 SD", "Wright");
INSERT INTO VehicleInformation
VALUES (496461347, "White", "land Rover", "SALRGBBV9HA042091","bvh5623", "937A York Street", "NY", 2017, "Discovery", "Martin");

# ViolationID DriversLicense ViolationDate District ViolationLocation ViolationTime ViolationDesc Detachment
INSERT INTO ViolationInformation
VALUES (1, 822895210, '2025-11-05', "Brooklyn", "414 Hicks Street", '18:52:00', "Speeding in a school zone", "Patrol Officer");
INSERT INTO ViolationInformation
VALUES (2, 688867828, '2025-10-30', "Brooklyn", "735 Avenue W", '14:42:00', "Texting while driving", "Patrol Officer");
INSERT INTO ViolationInformation
VALUES (3, 707157183, '2025-11-01', "Queens", "49th Street", '09:29:00', "Speeding", "HighwayPatrol Officer");
INSERT INTO ViolationInformation
VALUES (4, 496461347, '2025-10-02', "Bronx", "600 Clarence Avenue", '22:03:00', "Speeding", "HighwayPatrol Officer");