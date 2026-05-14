DELIMITER //

CREATE TRIGGER after_patient_admission
AFTER INSERT ON emergency_cases
FOR EACH ROW
BEGIN
    UPDATE rooms 
    SET AVAILABILITY_STATUS = 'O' 
    WHERE ROOM_ID = NEW.ROOM_ID;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_patient_discharge
AFTER UPDATE ON emergency_cases
FOR EACH ROW
BEGIN
    IF NEW.DISCHARGE_TIME IS NOT NULL THEN
        UPDATE rooms 
        SET AVAILABILITY_STATUS = 'A' 
        WHERE ROOM_ID = NEW.ROOM_ID;
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER set_default_role
BEFORE INSERT ON user_accounts
FOR EACH ROW
BEGIN
    IF NEW.USER_ROLE IS NULL THEN
        SET NEW.USER_ROLE = 'Patient';
    END IF;
END //

DELIMITER ;