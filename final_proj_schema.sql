DROP DATABASE IF EXISTS airline_res;
CREATE DATABASE airline_res;
USE airline_res;

DROP TABLE IF EXISTS User;
CREATE TABLE User(
userType INT CHECK (userType IN (0,1)), -- 0 meaning user, 1 meaning admin,
uID INT AUTO_INCREMENT,
email VARCHAR(50) NOT NULL,
passwd VARCHAR(30) NOT NULL,
birthdate DATE,
firstName VARCHAR(50),
lastName VARCHAR(50),
address TEXT,
phoneNum VARCHAR(20),
PRIMARY KEY (uID, email)
);

INSERT INTO User VALUES 
(1, 1234, 'alpha@gmail.com', 'password', '1983-02-12', 'Sam', 'Smith', '123 Candy Lane', '4085551928'),
(1, 1235, 'beta@gmail.com', 'mysql', '1998-05-29', 'Michelle', 'Nguyen', '392 Strawberry Street', '5555559299'),
(0, 1236, 'charlie@yahoo.com', '12345', '2000-09-01', 'Charlie', 'Do', '1314 Soup Way', '5551231234'),
(0, 1237, 'doggo@aim.com', 'asdfg', '1984-02-20', 'Faith', 'Schmitt', '1948 High Road', '5022302341'),
(0, 1238, 'itbelikethat@gmail.com', '5thperson', '1999-10-10', 'Sally', 'Johnson', '4443 Tumble Street', '4081229302');

DROP TABLE IF EXISTS Airline;
CREATE TABLE Airline(
airlineID INT AUTO_INCREMENT,
name VARCHAR(30),
tailNum INT UNIQUE, -- plane ID
PRIMARY KEY (airlineID)
);

INSERT INTO Airline value
(1, 'United', 1),
(2, 'American', 2),
(3, 'Alaska', 3),
(4, 'Hawaiian', 4),
(5, 'Southwest', 5);

DROP TABLE IF EXISTS Pilot;
CREATE TABLE Pilot(
pilotID INT AUTO_INCREMENT,
name VARCHAR(50) NOT NULL, 
yearExp INT,
available INT CHECK (available in (0,1)), -- 0 is free, 1 is unavailable 
airlineID INT, 
PRIMARY KEY (pilotID),
FOREIGN KEY (airlineID) REFERENCES Airline(airlineID) ON DELETE CASCADE
);

INSERT INTO Pilot VALUES
(1, 'Michael Stuart', 4, 1, 1),
(2, 'Susie Lee', 10, 1, 3),
(3, 'Judy Gonzales', 8, 0, 5),
(4, 'Justin Rae', 2, 1, 2),
(5, 'Robin Tran', 3, 0, 4);

DROP TABLE IF EXISTS Airport;
CREATE TABLE Airport(
airportID INT AUTO_INCREMENT,
name VARCHAR(50),
city VARCHAR(50),
state VARCHAR(5),
PRIMARY KEY (airportID),
UNIQUE(city, state)
); 

INSERT INTO Airport VALUES
(1, 'Mineta', 'San Jose', 'CA'),
(2, 'JFK', 'Los Angeles', 'CA'),
(3, 'SEA', 'Seattle', 'WA'),
(4, 'Sacramento', 'Sacramento', 'CA'),
(5, 'Austin-Bergstrom', 'Austin', 'TX'),
(6, 'SFO', 'San Francisco', 'SF'),
(7, 'McCarran', 'Las Vegas', 'NV'),
(8, 'Daniel K. Inouye', 'Honolulu', 'HI'),
(9, 'ORD', 'Chicago', 'IL');

DROP TABLE IF EXISTS Route;
CREATE TABLE Route(
routeID INT AUTO_INCREMENT,
airlineID INT,
originAirportID INT,
destinationAirportID INT,
PRIMARY KEY (RouteID),
FOREIGN KEY (airlineID) REFERENCES Airline(airlineID),
FOREIGN KEY (originAirportID) REFERENCES Airport(airportID),
FOREIGN KEY (destinationAirportID) REFERENCES Airport(airportID)
);

INSERT INTO ROUTE VALUES
(1, 1, 1, 2),
(2, 2, 1, 3),
(3, 3, 5, 6),
(4, 3, 3, 7),
(5, 4, 9, 8);

DROP TABLE IF EXISTS Flight;
CREATE TABLE Flight(
flightID INT AUTO_INCREMENT,
pilotID INT,
departureDate DATE NOT NULL,
departureTime TIME NOT NULL,
arrivalTime TIME NOT NULL,
routeID INT,
maxNumSeats INT NOT NULL,
status INT CHECK (status in (0,1)), -- 0 if ready, 1 if delayed
PRIMARY KEY (flightID),
FOREIGN KEY (pilotID) REFERENCES Pilot (pilotID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (routeID) REFERENCES Route (routeID) ON DELETE CASCADE
);

INSERT INTO Flight VALUES
(1, 1, '2020-03-24', 100000, 120000, 1, 90, 0),
(2, 1, '2020-03-25', 093000, 130000, 2, 100, 0),
(3, 3, '2020-03-26', 140000, 190000, 3, 95, 1),
(4, 2, '2020-03-27', 110000, 130000, 4, 110, 0),
(5, 5, '2020-03-24', 070000, 160000, 5, 95, 1);

DROP TABLE IF EXISTS Booking;
CREATE TABLE Booking(
ticketID INT AUTO_INCREMENT,
uID INT,
flightID INT,
routeID INT,
totalFare INT,
class VARCHAR(30) NOT NULL,
updatedAT TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (ticketID),
FOREIGN KEY (uID) REFERENCES User(uID),
FOREIGN KEY (flightID) REFERENCES Flight(flightID) ON DELETE CASCADE,
FOREIGN KEY (routeID) REFERENCES Route(routeID) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Booking VALUES
(1249, 1234, 1, 1, 223, 'Business', NOW()),
(1250, 1235, 2, 2, 250 , 'Economy', NOW()),
(1251, 1235, 3, 3, 625 , 'First Class', NOW()),
(1252, 1236, 4, 4, 317 , 'Business', NOW()),
(1253, 1237, 5, 5, 1274 , 'First Class', NOW());

DROP TABLE IF EXISTS BookingArchive;
CREATE TABLE BookingArchive(
uID INT,
ticketID INT,
flightID INT,
routeId INT,
totalFare DOUBLE,
class VARCHAR(30) NOT NULL,
PRIMARY KEY (ticketID)
);

DROP TABLE IF EXISTS PilotArchive;
CREATE TABLE PilotArchive(
pilotID INT,
name VARCHAR(50) NOT NULL, 
yearExp INT,
airlineID INT, 
PRIMARY KEY (pilotID)
);
