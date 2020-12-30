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
