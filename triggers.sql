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

INSERT INTO User(email, passwd) VALUES ('aabb@gmail.com', 'abc');
SELECT * FROM User;

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

