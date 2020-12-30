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
	SELECT flightID, ar1.city, ar1.state, ar2.city, ar2.state, departureTime, arrivalTime 
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
