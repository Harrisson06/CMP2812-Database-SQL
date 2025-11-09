# NEW YORK STATE PATROL DEPT
# Creating the Database and then using the database
CREATE DATABASE NYSPD;
USE NYSPD;

### Commands that dont work the way i want 
# Creates both the officer profile and the Public profile 
# CREATE USER "Officer"@"host" IDENTIFIED BY "password";
#Create user "Public"@"localhost" identified by "Public";

# Allows all access to the Officer profile 
# Only allows ViolationInformation to Public profile 
#GRANT SELECT ON NYSPD.* TO "Officer"@"localhost";
#GRANT VIEW ON NYSPD.ViolationInformation TO "Public_User"@"localhost";
###

# Creating the table that hold Driver Information
CREATE TABLE DriverInformation (
FirstName tinytext,
LastName tinytext,
Address tinytext,
City tinytext,
State tinytext,
ZipCode smallint,
DriverLicense int,
StateIssuedLicense tinytext,
BirthDate date,
Height Decimal(2,2),
Weight tinyint,
EyeColour tinytext,

PRIMARY KEY (DriverLicense)
);

# Creating the table that holds Vehicle Information
CREATE TABLE VehicleInformation (
VehicleLicense varchar(20),
Colour tinytext,
make tinytext,
VIN int,
RegisteredAddress tinytext,
StateRegistered tinytext,
RegisteredYear tinyint,
CarType tinytext,
RegisteredOwner tinytext,

PRIMARY KEY (VIN)
);

# Creating the table that holds Violation Information
# This is the table that the violation holder sees
CREATE TABLE ViolationInformation (
ViolationID int,
ViolationDate date,
District tinytext,
ViolationLocation tinytext,
ViolationTime tinytext,
ViolationDesc tinytext,
Detachment tinytext,

CONSTRAINT DateCheck CHECK (ViolationDate >= date(2020-01-01)
AND ViolationDate <= date(2026-03-03)),

PRIMARY KEY (ViolationID)
);

# Creating the table that holds officer information and actions
CREATE TABLE OfficerInformation (
OfficerLastName varchar(20),
PersonelNumber int,
Detachment tinytext,

PRIMARY KEY (PersonelNumber)
);

# Creating the table that holds Violations 
# This is the table the officer sees
CREATE TABLE Violations (
ViolationID int,
ViolationDate date,
PersonelID int,
VehicleVIN int,

FOREIGN KEY (ViolationID) REFERENCES ViolationInformation(ViolationID),
FOREIGN KEY (PersonelID) REFERENCES OfficerInformation(PersonelNumber),
FOREIGN KEY (VehicleVIN) REFERENCES VehicleInformation(VIN)
);

# Inserting data into the tables 

#FirstName tinytext,
#LastName tinytext,
#Address tinytext,
#City tinytext,
#State tinytext,
#ZipCode smallint,
#DriverLicense int,
#StateIssuedLicense tinytext,
#BirthDate date,
#Height Decimal(2,2),
#Weight tinyint,
#EyeColour tinytext,


## DriverInformation Data Creation
INSERT INTO DriverInformation
VALUES ("Winter", "Elsey", "8346 Elm Street, Brooklyn", "Wa", "NY"




## OfficerInformation Data Creation
### Creating Patrol Officers 
INSERT INTO OfficerInformation
VALUES ("Angelo", 74361169, "PatrolOfficer");
INSERT INTO OfficerInformation
VALUES ("Wright", 8861767, "PatrolOfficer");
INSERT INTO OfficerInformation
VALUES ("Truss", 1118262, "PatrolOfficer");
INSERT INTO OfficerInformation
VALUES ("Madden", 1721804, "PatrolOfficer");

### Creating Traffic Enforcers 
INSERT INTO OfficerInformation
VALUES ("Doss", 7001990, "TrafficEnforcer");
INSERT INTO OfficerInformation
VALUES ("Vance", 9004461, "TrafficEnforcer");
INSERT INTO OfficerInformation
VALUES ("Pence", 5658260, "TrafficEnforcer");

### Creating HighwayPatrol Officers
INSERT INTO OfficerInformation
VALUES ("Danes", 6261011, "HighwayPatrolOfficer");
INSERT INTO OfficerInformation
VALUES ("Gates", 8179260, "HighwayPatrolOfficer")

