
# NEW YORK STATE PATROL Database
# Creating the Database
CREATE DATABASE NYSPD;

# Accessing the database to intput data
USE NYSPD;

# Creating three users, Admin that has complete access,
# Officer That has Access to view and create notices,
# Violation Holder that can view notices linked to their vehicle

# Creating the table that hold Driver Information
CREATE TABLE Drivers (
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
CREATE TABLE Vehicles (
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

CREATE TABLE Officers (
OfficerID int PRIMARY KEY AUTO_INCREMENT,
FirstName Varchar(30),
LastName Varchar(30),
PersonnelNumber int UNIQUE
);

# Creating the table that holds Violation Information
# This is the table that the violation holder sees
CREATE TABLE CorrectionsNotice (
NoticeID int PRIMARY KEY,
DriversLicense int,
ViolationDate date,
District tinytext,
Location tinytext,
ViolationTime time,
ViolationDesc tinytext,
Detachment tinytext,
OfficerID int,

FOREIGN KEY (DriversLicense) REFERENCES Drivers(DriverLicense),
FOREIGN KEY (OfficerID) REFERENCES Officers(OfficerID),

# Constraint created to make sure dates are issues into the future or more than 5 years ago.
CONSTRAINT DateCheck CHECK (
	ViolationDate >= '2020-01-01'AND ViolationDate <= '2026-01-01'
    )
);

# Creating a table to hold the actionID and a description of each action
CREATE TABLE Actions (
ActionID int PRIMARY KEY AUTO_INCREMENT,
DEscription Varchar(255)
);

CREATE TABLE NoticeActions (
NoticeID int,
ActionID int,
PRIMARY KEY (NoticeID, ActionID),
FOREIGN KEY (NoticeID) REFERENCES CorrectionsNotice(NoticeID),
FOREIGN KEY (ActionID) REFERENCES Actions(ActionID)
);


# FirstName LastName Address City State ZipCode DriverLicense StateIssuedLicense BirthDate Height Weight EyeColour
INSERT INTO Drivers
VALUES ("Reuben", "Hoover", "53 Cambridge Court", "NYC", "NY", 11743, 822895210, "NY", '1979-12-2', "5'9", 102, "BL");
INSERT INTO Drivers
VALUES ("Mia", "Dahn", "3770 Main Street", "NYC", "NY", 11743, 688867828, "NY", '1998-04-29', "6'1", 96, "BL");
INSERT INTO Drivers
VALUES ("Tristan", "Wright", "7317 Clay Street", "NYC", "NY", 10036, 707157183, "NY", '2001-11-2', "5'10", 140, "GR");
INSERT INTO Drivers
VALUES ("Dave", "Martin", "937A York Street", "NYC", "NY", 11224, 496461347, "NY", '1976-11-29', "5'6", 87, "BR");

# VehicleLicense Colour make VIN RegisteredAddress StateRegistered RegisteredYear CarType OwnerLastName
INSERT INTO Vehicles
VALUES ( 822895210, "White", "Peugeot", "2GCEC19WXX1260267","sds4234", "53 Cambridge Court", "NY", 2012, "208", "Hoover");
INSERT INTO Vehicles
VALUES (688867828, "Grey", "Jaguar", "SAJFA41C71N917210","afe9314", "3770 Main Street", "NY", 2001, "XK-Serise", "Dahn");
INSERT INTO Vehicles
VALUES (707157183, "Black", "Ford", "1FDWF31507EA22867","fbq8724", "7317 Clay Street", "NY", 2025, "F-350 SD", "Wright");
INSERT INTO Vehicles
VALUES (496461347, "White", "land Rover", "SALRGBBV9HA042091","bvh5623", "937A York Street", "NY", 2017, "Discovery", "Martin");

INSERT INTO Officers
VALUES (1, "Mark", "Sloan", 29351);

#NoticeID DriversLicense ViolationDate District Location ViolationTime ViolationDesc Detachment OfficerID
INSERT INTO CorrectionsNotice
VALUES (1, 822895210, '2025-11-05', "Brooklyn", "414 Hicks Street", '18:52:00', "Speeding in a school zone", "Patrol Officer");
INSERT INTO CorrectionsNotice
VALUES (2, 688867828, '2025-10-30', "Brooklyn", "735 Avenue W", '14:42:00', "Texting while driving", "Patrol Officer");
INSERT INTO CorrectionsNotice
VALUES (3, 707157183, '2025-11-01', "Queens", "49th Street", '09:29:00', "Speeding", "HighwayPatrol Officer");
INSERT INTO CorrectionsNotice
VALUES (4, 496461347, '2025-10-02', "Bronx", "600 Clarence Avenue", '22:03:00', "Speeding", "HighwayPatrol Officer");