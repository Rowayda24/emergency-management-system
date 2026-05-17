/* -------------------------------
   1) PRESCRIPTION MANAGEMENT
   ------------------------------- */
DELIMITER //

CREATE PROCEDURE CreatePrescription(
    IN p_patient_id     INT,
    IN p_doctor_id   INT,
    IN p_med_id      INT,
    IN p_dosage      VARCHAR(50),
    IN p_directions  TEXT
)
BEGIN
    DECLARE new_presc_id INT;

    INSERT INTO prescriptions (PATIENT_ID, DOCTOR_ID, PRESCRIPTION_DATE)
    VALUES (p_patient_id, p_doctor_id, CURDATE());

    SET new_presc_id = LAST_INSERT_ID();

    INSERT INTO prescription_details
        (PRESCRIPTION_ID, MEDICATION_ID, DOSAGE, DIRECTIONS, START_DATE)
    VALUES
        (new_presc_id, p_med_id, p_dosage, p_directions, CURDATE());
END //

DELIMITER ;

SELECT
    p.PRESCRIPTION_ID,
    p.PATIENT_ID,
    p.DOCTOR_ID,
    p.PRESCRIPTION_DATE,
    p.NOTES                      AS PRESCRIPTION_NOTES,
    pd.PRESCRIPTION_DETAILS_ID,
    pd.MEDICATION_ID,
    m.MEDICATION_NAME,
    pd.DOSAGE,
    pd.FREQUANCY,
    pd.START_DATE,
    pd.END_DATE,
    pd.DIRECTIONS
FROM prescriptions p
JOIN prescription_details pd ON pd.PRESCRIPTION_ID = p.PRESCRIPTION_ID
JOIN medications          m  ON m.MEDICATION_ID    = pd.MEDICATION_ID
WHERE p.PRESCRIPTION_ID = ?;

UPDATE prescriptions
SET    NOTES             = ?,
       PRESCRIPTION_DATE = ?
WHERE  PRESCRIPTION_ID  = ?;

UPDATE prescription_details
SET    MEDICATION_ID              = ?,
       DOSAGE                     = ?,
       FREQUANCY                  = ?,
       START_DATE                 = ?,
       END_DATE                   = ?,
       DIRECTIONS                 = ?
WHERE  PRESCRIPTION_DETAILS_ID   = ?;

/* Create payment */
INSERT INTO payments
    (PAYMENT_ID, PATIENT_ID, AMOUNT, PAYMENT_METHOD, PAYMENT_STATUS,
     PAYMENT_DATE, INSURANCE_PROVIDOR, TRANSACTION_REFRENCES)
VALUES
    (?, ?, ?, ?, ?, ?, ?, ?);

SELECT
    pay.PAYMENT_ID,
    pay.PATIENT_ID,
    pat.FNAME,
    pat.LNAME,
    pay.AMOUNT,
    pay.PAYMENT_METHOD,
    pay.PAYMENT_STATUS,
    pay.PAYMENT_DATE,
    pay.INSURANCE_PROVIDOR,
    pay.TRANSACTION_REFRENCES
FROM payments        pay
JOIN emergency_cases ec  ON ec.PATIENT_ID  = pay.PATIENT_ID
JOIN patients        pat ON pat.PATIENT_ID = ec.PATIENT_ID
WHERE pay.PAYMENT_ID = ?;

/* Update payment status */
UPDATE payments
SET    PAYMENT_STATUS        = ?,
       TRANSACTION_REFRENCES = ?,
       PAYMENT_DATE          = ?
WHERE  PAYMENT_ID            = ?;

SELECT
    PAYMENT_STATUS,
    COUNT(*)      AS CNT,
    SUM(AMOUNT)   AS TOTAL_AMOUNT
FROM payments
GROUP BY PAYMENT_STATUS;

/* Payment method */
SELECT
    PAYMENT_METHOD,
    COUNT(*)      AS CNT,
    SUM(AMOUNT)   AS TOTAL_AMOUNT
FROM payments
GROUP BY PAYMENT_METHOD;

/* Total patients visited today */
SELECT COUNT(DISTINCT PATIENT_ID) AS PATIENTS_TODAY
FROM   emergency_cases
WHERE  DATE_ISSUED = CURDATE();

/* Prescriptions written today */
SELECT COUNT(*) AS PRESCRIPTIONS_TODAY
FROM   prescriptions
WHERE  PRESCRIPTION_DATE = CURDATE();
