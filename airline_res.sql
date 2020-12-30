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

DROP TABLE IF EXISTS Airline;
CREATE TABLE Airline(
airlineID INT AUTO_INCREMENT,
name VARCHAR(30),
tailNum INT UNIQUE, -- plane ID
PRIMARY KEY (airlineID)
);

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

DROP TABLE IF EXISTS Airport;
CREATE TABLE Airport(
airportID INT AUTO_INCREMENT,
name VARCHAR(50),
city VARCHAR(50),
state VARCHAR(5),
PRIMARY KEY (airportID),
UNIQUE(city, state)
); 

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

/* NOTE: We did not use a public data set, so here are our insert statements */

INSERT INTO User VALUES 
(1, 1234, 'alpha@gmail.com', 'password', '1983-02-12', 'Sam', 'Smith', '123 Candy Lane', '4085551928'),
(1, 1235, 'beta@gmail.com', 'mysql', '1998-05-29', 'Michelle', 'Nguyen', '392 Strawberry Street', '5555559299'),
(0, 1236, 'charlie@yahoo.com', '12345', '2000-09-01', 'Charlie', 'Do', '1314 Soup Way', '5551231234'),
(0, 1237, 'doggo@aim.com', 'asdfg', '1984-02-20', 'Faith', 'Schmitt', '1948 High Road', '5022302341'),
(0, 1238, 'itbelikethat@gmail.com', '5thperson', '1999-10-10', 'Sally', 'Johnson', '4443 Tumble Street', '4081229302');

INSERT INTO Airline value
(1, 'United', 1),
(2, 'American', 2),
(3, 'Alaska', 3),
(4, 'Hawaiian', 4),
(5, 'Southwest', 5);

INSERT INTO Pilot VALUES
(1, 'Michael Stuart', 4, 1, 1),
(2, 'Susie Lee', 10, 1, 3),
(3, 'Judy Gonzales', 8, 0, 5),
(4, 'Justin Rae', 2, 1, 2),
(5, 'Robin Tran', 3, 0, 4);

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


INSERT INTO ROUTE VALUES
(1, 1, 1, 2),
(2, 2, 1, 3),
(3, 3, 5, 6),
(4, 3, 3, 7),
(5, 4, 9, 8);

INSERT INTO Flight VALUES
(1, 1, '2020-03-24', 100000, 120000, 1, 90, 0),
(2, 1, '2020-03-25', 093000, 130000, 2, 100, 0),
(3, 3, '2020-03-26', 140000, 190000, 3, 95, 1),
(4, 2, '2020-03-27', 110000, 130000, 4, 110, 0),
(5, 5, '2020-03-24', 070000, 160000, 5, 95, 1);

INSERT INTO Booking VALUES
(1249, 1234, 1, 1, 223, 'Business', NOW()),
(1250, 1235, 2, 2, 250 , 'Economy', NOW()),
(1251, 1235, 3, 3, 625 , 'First Class', NOW()),
(1252, 1236, 4, 4, 317 , 'Business', NOW()),
(1253, 1237, 5, 5, 1274 , 'First Class', NOW());

-- 1. This is a procedure to create a User by obtaining their basic information.
DROP PROCEDURE IF EXISTS createUser;
DELIMITER // 
CREATE PROCEDURE createUser(
IN emailAddr VARCHAR(50),
IN password VARCHAR(30),
IN birthday DATE,
IN firstN VARCHAR(50),
IN lastN VARCHAR(50),
IN homeAddress TEXT,
IN phoneNumber CHAR(10))
BEGIN
	INSERT INTO User(email, passwd, birthdate, firstName, lastName, address, phoneNum) VALUES
    (emailAddr, password, birthday, firstN, lastN, homeAddress, phoneNumber);
END//
DELIMITER ;

call createUser('lkjhg@gmail.com', 'password', '1998-08-24', 'Kelly', 'Lam', '1234 Quimby Road', '4082940112');

-- 2.  This is a procedure to book a flight. 
DROP PROCEDURE IF EXISTS BookRes;
DELIMITER //
CREATE PROCEDURE BookRes(
IN userID INT,
IN fID INT,
IN rID INT,
IN totalAMT DOUBLE,
IN seatClass VARCHAR(30))
BEGIN
	INSERT INTO Booking (uID, flightID, routeID, totalFare, class)
    VALUES (userID, fID, rID, totalAMT, seatClass);
END //
DELIMITER ;

call BookRes(1239, 4, 4, 317 , 'Business');

-- 3. This is a procedure to cancel a flight reservation.
DROP PROCEDURE IF EXISTS CancelFlightRes;
DELIMITER //
CREATE PROCEDURE CancelFlightRes(IN tID INT)
BEGIN
	DELETE FROM Booking WHERE ticketID = tID;
END //
DELIMITER ;

call CancelFlightRes(1249);

-- 4. This is a procedure to get the number of passengers on a specific flight.
DROP PROCEDURE IF EXISTS getNumPassenger;
DELIMITER //
CREATE PROCEDURE getNumPassenger(IN fID INT, OUT numPassengers INT)
BEGIN
	SELECT count(uID) INTO numPassengers 
    FROM Booking WHERE fID = flightID;
END // 
DELIMITER ;

call getNumPassenger(1, @result);
SELECT @result;

-- 5. This is a procedure to get all the information of all flights for a specific destination city, state.
DROP PROCEDURE IF EXISTS getFlightByDestination;
DELIMITER //
CREATE PROCEDURE getFlightByDestination(IN destinationCity VARCHAR(45), IN destinationState VARCHAR(45))
BEGIN
	 SELECT departureDate, al.name, f.flightID, f.routeID, a2.city, a2.state, destinationCity, destinationState, f.departureTime, f.arrivalTime
     FROM Flight f, Route r, Airport a1, Airport a2, Airline al
     WHERE f.routeID = r.routeID AND a1.airportID = r.destinationAirportID
     AND destinationCity = a1.city AND a2.airportID = r.originAirportID AND r.airlineID = al.airlineID
     AND (destinationCity, destinationState) in (SELECT city, state from airport);
END //
DELIMITER ;

call getFlightByDestination('Las Vegas', 'NV');

-- 6. This is a procedure to get the basic information of Business class passengers on a specific flight.
DROP PROCEDURE IF EXISTS getBusinessPassengers;
DELIMITER // 
CREATE PROCEDURE getBusinessPassengers(IN fID INT)
BEGIN
	SELECT b.uID, firstName, lastName, birthDate 
    FROM User u, Booking b 
    WHERE u.uID = b.uID 
    AND flightID = fID AND class = 'Business';
END // 
DELIMITER ;

call getBusinessPassengers(1);

-- 7. This is a procedure to get the basic information of Economy class passengers on a specific flight.
DROP PROCEDURE IF EXISTS getEconomyPassengers;
DELIMITER // 
CREATE PROCEDURE getEconomyPassengers(IN fID INT)
BEGIN
	SELECT b.uID, firstName, lastName, birthDate 
    FROM User u, Booking b 
    WHERE u.uID = b.uID
    AND flightID = fID AND class = 'Economy';
END // 
DELIMITER ;

call getEconomyPassengers(2);

-- 8. This is a procedure to get the basic information of First class passengers on a specific flight.
DROP PROCEDURE IF EXISTS getFirstClassPassengers;
DELIMITER // 
CREATE PROCEDURE getFirstClassPassengers(IN fID INT)
BEGIN
	SELECT b.uID, firstName, lastName, birthDate 
    FROM User u, Booking b 
    WHERE u.uID = b.uID
    AND flightID = fID AND class = 'First Class';
END //
DELIMITER ; 

call getFirstClassPassengers(3);

-- 9. This is a procedure to get the information of available flights by each airline.
DROP PROCEDURE IF EXISTS getFlightsByAirline;
DELIMITER // 
CREATE PROCEDURE getFlightsByAirline(IN name VARCHAR(45))
BEGIN
	SELECT f.routeID, flightID, ar1.city, ar1.state, ar2.city, ar2.state, departureDate, departureTime, arrivalTime 
    FROM Flight f, Airline a, Route r, Airport ar1, Airport ar2
    WHERE f.routeID = r.routeID 
    AND r.airlineID = a.airlineID AND ar1.airportID = r.originAirportID AND ar2.airportID = r.destinationAirportID
    AND a.name = name;
END //
DELIMITER ;

call getFlightsByAirline('United');

-- 10. This is a procedure to get the information of flights for a specific origin city, state.
DROP PROCEDURE IF EXISTS getFlightsByOrigin;
DELIMITER //
CREATE PROCEDURE getFlightsByOrigin(IN originCity VARCHAR(45), IN originState VARCHAR(45))
BEGIN
	 SELECT departureDate, al.name, f.flightID, f.routeID, originCity, originState, a2.city, a2.state, f.departureTime, f.arrivalTime
     FROM Flight f, Route r, Airport a1, Airport a2, Airline al
     WHERE f.routeID = r.routeID AND a1.airportID = r.originAirportID
     AND originCity = a1.city AND a2.airportID = r.destinationAirportID  AND r.airlineID = al.airlineID
     AND (originCity, originState) in (SELECT city, state from airport);
END // 
DELIMITER ;

call getFlightsByOrigin('San Jose', 'CA');

-- 11. This is a procedure to get information of available flights by a specific date. 
DROP PROCEDURE IF EXISTS getFlightsByDate;
DELIMITER //
CREATE PROCEDURE getFlightsByDate(IN day DATE)
BEGIN
	SELECT departureDate, al.name, flightID, r.routeID, a1.city AS originCity, a1.state AS originState, a2.city AS destinCity,
		a2.state as destinState, departureTime, arrivalTime
    FROM Airline al, Airport a1, Airport a2, Flight f, Route r 
    WHERE a1.airportID = r.originAirportID AND a2.airportID = r.destinationAirportID AND r.airlineID = al.airlineID AND f.routeID = r.routeID
    AND day = departureDate;
END // 
DELIMITER ;

call getFlightsByDate('2020-03-24');

-- 12. This is a procedure to get the name of a pilot available to fly for a specific airline. 
DROP PROCEDURE IF EXISTS getAvailablePilots;
DELIMITER // 
CREATE PROCEDURE getAvailablePilots(IN aID INT)
BEGIN
	SELECT name FROM Pilot WHERE available = 0 and airlineID = aID;
END //
DELIMITER ;

call getAvailablePilots(4);

-- 13. This is a procedure to get the number of available seats left on a specific flight. 
DROP PROCEDURE IF EXISTS getNumAvailableSeats;
DELIMITER //
CREATE PROCEDURE getNumAvailableSeats(IN fID INT, OUT numAvailableSeats INT)
BEGIN
	SELECT (maxNumSeats-taken) INTO numAvailableSeats
    FROM (SELECT count(uID) AS taken, maxNumSeats 
		  FROM Booking b, Flight f WHERE b.flightID = f.flightID AND b.flightID = fID) as t;
END // 
DELIMITER ;

call getNumAvailableSeats(1, @result);
SELECT @result;

-- 14. This is a procedure to see whether or not a flight has been delayed. 
DROP PROCEDURE IF EXISTS getFlightStatus;
DELIMITER // 
CREATE PROCEDURE getFlightStatus(IN fID INT)
BEGIN
	SELECT status FROM flight WHERE flightID = fID;
END // 
DELIMITER ;

call getFlightStatus(1);

-- 15. This is a procedure to get the basic information of senior citizens and children on a specific flight.
DROP PROCEDURE IF EXISTS getSeniorAndChildren;
DELIMITER //
CREATE PROCEDURE getSeniorAndChildren(IN fID INT)
BEGIN
	SELECT u.uID, firstName, lastName, birthDate FROM Booking b, User u WHERE b.uID = u.uID AND b.flightID = fID 
    AND (year(birthDate)<1960 or year(birthDate)>2002);
END //
DELIMITER ;

call getSeniorAndChildren(5);

-- 16. This is a procedure to upgrade a passenger to a new class and adjust their total fees accordingly. 
DROP PROCEDURE IF EXISTS upgradeClass;
DELIMITER // 
CREATE PROCEDURE upgradeClass(IN ID INT, IN newClass VARCHAR(50), IN fee INT)
BEGIN
	UPDATE Booking SET class = newClass, totalfare = totalfare + fee WHERE ticketID = ID;
END //
DELIMITER ;

call upgradeClass(1234, 'First Class', 400);

-- 17. This is a procedure to check if an email is already being used. 
DROP PROCEDURE IF EXISTS isEMAILTaken;
DELIMITER //
CREATE PROCEDURE isEMAILTaken(IN userEmail VARCHAR(50))
BEGIN
	IF EXISTS(SELECT email from User where email = userEmail) THEN SELECT 1 AS result;
	ELSE SELECT 0 AS result;
	END IF;
END//
DELIMITER ;

-- 18. This is a procedure to “login” a user if email and password matches an entry in the DB. 
DROP PROCEDURE IF EXISTS Login;
DELIMITER //
CREATE PROCEDURE Login(IN
userEmail VARCHAR(50),
userPasswd VARCHAR(50))
BEGIN
	IF EXISTS(SELECT email FROM user WHERE email = userEmail AND passwd = userPasswd) THEN SELECT 1 AS result;
	ELSE SELECT 0 AS result;
	END IF;
END//
DELIMITER  ;

-- 1. Pilot who works the most (aggregation)
SELECT p.Pilotid, name, COUNT(flightid) AS working 
FROM Pilot p, Flight f
WHERE p.pilotID = f.pilotID
GROUP BY p.pilotID ORDER BY working DESC;

-- 2. Flights with duration sorted (group by)
SELECT flightid, a1.city AS originCity, a1.state AS originState, a2.city AS destinCity, a2.state AS destinState,
	timestampdiff(minute, departuretime, arrivaltime) AS duration
FROM Flight f, Route r, Airport a1, Airport a2
WHERE f.routeid = r.routeid AND a1.airportID = r.originAirportID AND a2.airportID = r.destinationAirportID
GROUP BY flightID
ORDER BY duration desc;

-- 3. Airline offering what flights (set operation)
SELECT a.airlineID, a.name, ar1.city AS originCity, ar1.state AS originState, ar2.city AS destinCity, ar2.state AS destinState
FROM Airline a, Route r, Flight f, Airport ar1, Airport ar2
WHERE a.airlineID = r.airlineid AND r.routeID = f.routeid AND ar1.airportID = r.originAirportID AND ar2.airportID = r.destinationAirportID
UNION
SELECT a.airlineID, a.name, null, null, null, null
FROM Airline a
WHERE airlineID NOT IN (SELECT airlineID FROM Route r, Flight f WHERE f.routeid = r.routeid);

-- 4. Pilots employed to which airline (outer join)
SELECT a.name, tailnum, pilotid, p.name
FROM Airline a 
LEFT JOIN Pilot p
ON a.airlineID = p.airlineID;

-- 5. Pilot with the same name (correlated subquery)
SELECT pilotID, name, airlineID
FROM Pilot p1
WHERE pilotID !=  ANY (SELECT pilotID FROM Pilot p2 WHERE p1.name = p2.name);

-- A trigger that denies a user to create a password less than 5 characters long and sends an error message
DROP TRIGGER IF EXISTS validate_password_before_insert_user;
DELIMITER //
CREATE TRIGGER validate_password_before_insert_user
BEFORE INSERT ON User
FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(100);
    IF (LENGTH(new.passwd) < 5) THEN
        SET msg = "Invalid password. Must be longer than 5 characters";
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END //
DELIMITER ; 

-- INSERT INTO User(email, passwd) VALUES ('aabb@gmail.com', 'abc');
-- SELECT * FROM User;

-- A trigger to add information to the pilotArchive table when a pilot is fired. This is a trigger instead of a procedure so that it adds to the table before it is deleted.
DROP TRIGGER IF EXISTS archivePilot; 
DELIMITER //
CREATE TRIGGER archivePilot
BEFORE DELETE ON Pilot
FOR EACH ROW 
BEGIN 
	INSERT INTO PilotArchive(
     SELECT pilotID, name, yearExp, airlineID
	 FROM Pilot 
	 WHERE pilotID = old.pilotID);
END//
DELIMITER ;

DELETE FROM Pilot where pilotID = 1;
SELECT * FROM PilotArchive;
SELECT * FROM Pilot;

-- Procedure to add information of booking into archiveBooking after the booking tuple has reached a specific cutoff date and time. 
DROP PROCEDURE IF EXISTS archiveBooking;
DELIMITER //
CREATE PROCEDURE archiveBooking(IN cutoff TIMESTAMP)
BEGIN
	INSERT INTO BookingArchive(
	SELECT uID, ticketID, flightID, routeID, totalFare, class
	FROM Booking WHERE updatedAT < cutoff);
	DELETE FROM Booking WHERE updatedAt < cutoff; 
END //
DELIMITER ;

call archiveBooking('2020-01-19 03:14:07');
SELECT * FROM Booking;
SELECT * FROM BookingArchive;

