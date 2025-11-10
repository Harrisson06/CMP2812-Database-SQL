
# NEW YORK STATE PATROL Database
# Creating the Database
CREATE DATABASE NYSPD;

# Accessing the database to intput data
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
FirstName Char(20),
LastName Char(20),
Address tinytext,
Borough tinytext,
City tinytext,
State tinytext,
ZipCode int,
DriverLicense int,
StateIssuedLicense tinytext,
BirthDate date,
Height tinytext,
Weight tinyint,
EyeColour tinytext,

PRIMARY KEY (DriverLicense)
);

# Creating the table that holds Vehicle Information
CREATE TABLE VehicleInformation (
VehicleLicense varchar(20),
Colour tinytext,
make tinytext,
VIN Varchar(17),
RegisteredAddress tinytext,
StateRegistered tinytext,
RegisteredYear int,
CarType tinytext,
OwnerLastName Char(20),

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
VehicleVIN Varchar(17),

FOREIGN KEY (ViolationID) REFERENCES ViolationInformation(ViolationID),
FOREIGN KEY (ViolationDate) REFERENCES ViolationInformation(ViolationDate),
FOREIGN KEY (PersonelID) REFERENCES OfficerInformation(PersonelNumber),
FOREIGN KEY (VehicleVIN) REFERENCES VehicleInformation(VIN)
);

# Inserting data into the tables 

#FirstName tinytext,
#LastName tinytext,
#Address tinytext,
#borough
#City tinytext,
#State tinytext,
#ZipCode smallint,
#DriverLicense ,
#StateIssuedLicense tinytext,
#BirthDate date,
#Height Decimal(2,2),
#Weight tinyint,
#EyeColour tinytext,

## DriverInformation Data Creation
INSERT INTO DriverInformation
VALUES ("Winter", "Elsey", "8346 Elm Street", "Brooklyn", "New York", "NY", 98104, 99063208,
"NY", '2001-01-01', "5'5", 96, "GR");
INSERT INTO DriverInformation
VALUES ("Alex", "gray", "64 North Street", "Fresh Meadows", "New York", "NY", 11365, 9378395,
"NY", '1999-02-12', "5'7", 84, "BL");
 
#VehicleLicense varchar(20),
#Colour tinytext,
#make tinytext,
#VIN int,
#RegisteredAddress tinytext,
#StateRegistered tinytext,
#RegisteredYear tinyint,
#CarType tinytext,
#OwnerLastName char(200
## VehicleInformation Data Creation

INSERT INTO VehicleInformation
VALUES ("vdf3928", "Blue", "Ford", "1C6RR7SM5ES476429", "8346 Elm Street", "New York", 2015, "Fiesta", "Elsey");
INSERT INTO VehicleInformation
VALUES ("afe9384","Red","Toyota","1HD4CAM18WK119007","682 Orange Street","New York", "2001","Yaris", "Gray");


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
