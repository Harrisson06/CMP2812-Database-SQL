# NEW YORK STATE PATROL DEPT
CREATE DATABASE NYSPD;
USE NYSPD;

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
VehicleLicense tinytext,
Colour tinytext,
make tinytext),
VINNumber tinytext,
RegisteredAddress tinytext,
StateRegistered tinytext,
RegisteredYear int(4),
CarType tinytext,
RegisteredOwner tinytext,

PRIMARY KEY (VINNumber)
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

PRIMARY KEY (ViolationID)
);

# Creating the table that holds officer information and actions
CREATE TABLE OfficerInformation (
OfficerName tinytext,
BadgeNumber int,
Detachment tinytext,

PRIMARY KEY (BadgeNumber)
);

# Creating the table that holds Violations 
# This is the table the officer sees
CREATE TABLE Violations (
ViolationID int,
OfficerName tinytext,
BadgeNumber int,
DriverLicense int,

PRIMARY KEY (ViolationID),
FOREIGN KEY (ViolationID) references ViolationInformation(ViolationID),
FOREIGN KEY (OfficerName) references OfficerInformation(OfficerName),
FOREIGN KEY (DriverLicense) references DriverInformation(DriverLicense)
);
