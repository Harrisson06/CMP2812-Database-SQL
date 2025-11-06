# NEW YORK STATE PATROL DEPT
CREATE DATABASE NYSPD;

USE NYSPD;

# Creating the table that hold Driver Information
CREATE TABLE DriverInformation (
FirstName varchar(20),
LastName varchar(30),
Address varchar(50),
City varchar(30),
State varchar(30),
ZipCode smallint,
DriverLicense int,
StateIssued varchar(30),
BirthDate date,
Height tinyint,
Weight tinyint,
EyeColour varchar(5),
PRIMARY KEY (DriverLicense)
);

# Creating the table that holds Vehicle Information
CREATE TABLE VehicleInformation (
VehicleLicense varchar(20),
Colour varchar(15),
make varchar(20),
VINNumber varchar(17),
RegisteredAddress varchar(40),
StateRegistered varchar(30),
RegisteredYear int(4),
CarType varchar(20),
RegisteredOwner varchar(40)
);

# Creating the table that holds Violation Information
CREATE TABLE ViolationInformation (
ViolationDate date,
District varchar(20),
ViolationLocation varchar(20),
ViolationTime varchar(10),
ViolationDesc varchar(255),
Detachment varchar(20)
);

# Creating the table that holds Violations 
CREATE TABLE Violations (
ViolationID int,
OfficerName varchar(30),
DriverLicense int,

PRIMARY KEY (ViolationID),
FOREIGN KEY (OfficerName) references OfficerInformation(OfficerName),
FOREIGN KEY (DriverLicense) references DriverInformation(DriverLicense)

);

# Creating the table that holds officer information and actions
CREATE TABLE OfficerInformation (
OfficerName varchar(30),
PersonalNumber int
);