# Airline Reservation System: Project Overview 
* Coordinated with 2 software engineering students to design an airline reservation system utilizing Java and MySQL to allow users interact with the airline database that supports archiving.
* Supplemented the system with 16 procedures and 2 triggers along with 5 queries that involved 2-5 relations simultaneously using correlated subqueries, joins, and/or aggregation.
* Created a database such that its relations were in 3NF or BCNF to eliminate data redundancies.
* Wrote a detailed report that explains each relational dependency and how the database has been normalized.

## Techniques used 
* Check constraints, Unique constraints
* Cascading (Delete and Update)
* Archiving
* Stored procedures
* Joins (Left, Inner, Self) of 2-5 different relations
* Group by/ Having
* Union
* Aggregation
* Correlated Subquery 
* Any/Not in
* Triggers

## Types of Procedure
* Create a User account
* Book a flight
* Cancel reservation
* Get number of passengers on a specific flight
* Get all information of all flights with specific destination city, state
* Get basic information of Business, Economy, and First class passengers on a specific flight
* Get basic information of senior citizens and children on given flight
* Get information of available flights by airline
* Get information of available flights by date
* Get information of flights for specific origin city, state 
* Get name of pilot available to fly for given airline
* Get number of available seats left on a specific flight
* See whether or not a flight has been delayed
* Upgrade passenger to new class and adjust total fees accordingly
* Check if email has been used before
* Login user if email and password matches an entry in the database

## Supporting Queries
* Pilot who works the most **(aggregation)**
* Flights with duration sorted **(group by)**
* Airline offering any flights **(set operation)**
* Pilots employed to any airline **(outer join)**
* Pilot with the same name **(correlated subquery)**

## Trigger Statements and Archive Function
* Denies user to create a password less than 5 characters long and sends an error message
* Add information to a pilot archive table when a pilot is fired or retires
* Add information of booking into the archive booking table after the booking tuple has reached a specific cutoff date and time
  
## Functionality Demonstration
Below are screenshots of getFlightByDestination procedure, booking archive, and a check constraint violation.
![alt text](https://github.com/kodingwithkelly/AirlineReservationSystem/blob/main/README_pngs/getFlightByDestination%20procedure.png "getFlightByDestinationProcedure")

![alt text](https://github.com/kodingwithkelly/AirlineReservationSystem/blob/main/README_pngs/Booking%20Archive.png "Booking Archive")

![alt text](https://github.com/kodingwithkelly/AirlineReservationSystem/blob/main/README_pngs/Check%20Constraint.png "Check Constraint")


## Functional Dependencies For Each Table
**User Table:**

uID, email → userType, passwd, birthdate, firstName, lastName, address, phoneNum

**Airline Table:**

airlineID → name, tailNum 

**Pilot Table:**

pilotID → name, yearExp, available, airlineID

**Airport Table:**

airportID → name, city, state

city, state → airportID, name

**Route Table:**

routeID → originAirportID, destinationAirportID

originAirportID, destinationAirportID → routeID

**Flight Table:**

flightID → pilotID, departureDate, departureTime, arrivalTime, routeID, maxNumSeats

pilotID → flightID

**Booking Table:**

ticketID → uID, flightID, routeID, totalFare, class

 
