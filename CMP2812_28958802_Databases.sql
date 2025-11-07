# NEW YORK STATE PATROL DEPT
CREATE DATABASE NYSPD;
USE NYSPD;

GRANT ALL ON NYSPD.* TO "Officer_User";
GRANT Select On NYSPD.ViolationInformation TO "Public_User";

# Creating the table that hold Driver Information
CREATE TABLE DriverInformation (
FirstName tinytext,
LastName tinytext,
Address tinytext,
City tinytext,
State tinytext,
ZipCode smallint,
DriverLicense int,
StateIssued tinytext,
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
AND ViolationDate <= date(2026-01-01)),

PRIMARY KEY (ViolationID)

);

# Creating the table that holds officer information and actions
CREATE TABLE OfficerInformation (
OfficerName varchar(20),
PersonelNumber int,
Detachment tinytext,

PRIMARY KEY (OfficerName)
);

# Creating the table that holds Violations 
# This is the table the officer sees
CREATE TABLE Violations (
ViolationID int,
ViolationDate date,
OfficerName varchar(20),
VehicleVIN int,
DriverLicense int,

FOREIGN KEY (ViolationID) REFERENCES ViolationInformation(ViolationID),
FOREIGN KEY (OfficerName) REFERENCES OfficerInformation(OfficerName),
FOREIGN KEY (VehicleVIN) REFERENCES VehicleInformation(VIN)
);
