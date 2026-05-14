DELIMITER //

CREATE PROCEDURE AdmitPatient(
    IN p_fname VARCHAR(50),
    IN p_lname VARCHAR(50),
    IN p_ssn INT,
    IN p_gender VARCHAR(1),
    IN p_doctor_id INT,
    IN p_room_id INT,
    IN p_triage VARCHAR(1)
)
BEGIN
    DECLARE new_patient_id INT;

    -- 1. Insert into Patients table
    INSERT INTO patients (FNAME, LNAME, SSN, GENDER)
    VALUES (p_fname, p_lname, p_ssn, p_gender);

    -- 2. Get the ID of the patient we just created
    SET new_patient_id = LAST_INSERT_ID();

    -- 3. Create the Emergency Case
    INSERT INTO emergency_cases (PATIENT_ID, DOCTOR_ID, ROOM_ID, TRIAGE_LEVEL, CASE_STATUS, DATE_ISSUED)
    VALUES (new_patient_id, p_doctor_id, p_room_id, p_triage, 'Admitted', CURDATE());

    -- NOTE: Member 2's Trigger will automatically set the room to 'Occupied' now!
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE CreatePrescription(
    IN p_case_id INT,
    IN p_doctor_id INT,
    IN p_med_id INT,
    IN p_dosage VARCHAR(50),
    IN p_directions TEXT
)
BEGIN
    DECLARE new_presc_id INT;

    -- 1. Create the main Prescription record
    INSERT INTO prescriptions (CASE_ID, DOCTOR_ID, PRESCRIPTION_DATE)
    VALUES (p_case_id, p_doctor_id, CURDATE());

    SET new_presc_id = LAST_INSERT_ID();

    -- 2. Insert the medication details
    INSERT INTO prescription_details (PRESCRIPTION_ID, MEDICATION_ID, DOSAGE, DIRECTIONS, START_DATE)
    VALUES (new_presc_id, p_med_id, p_dosage, p_directions, CURDATE());
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE DischargePatient(
    IN p_case_id INT,
    IN p_diagnosis VARCHAR(100)
)
BEGIN
    UPDATE emergency_cases
    SET DISCHARGE_TIME = CURRENT_TIME(),
        CASE_STATUS = 'Discharged',
        DIAGNOSIS = p_diagnosis
    WHERE CASE_ID = p_case_id;

END //

DELIMITER ;