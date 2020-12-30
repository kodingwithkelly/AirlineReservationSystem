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
