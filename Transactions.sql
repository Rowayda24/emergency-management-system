/* -------------------------------
   1) PRESCRIPTION MANAGEMENT
   ------------------------------- */
DELIMITER //

CREATE PROCEDURE CreatePrescription(
    IN p_case_id     INT,
    IN p_doctor_id   INT,
    IN p_med_id      INT,
    IN p_dosage      VARCHAR(50),
    IN p_directions  TEXT
)
BEGIN
    DECLARE new_presc_id INT;

    INSERT INTO prescriptions (CASE_ID, DOCTOR_ID, PRESCRIPTION_DATE)
    VALUES (p_case_id, p_doctor_id, CURDATE());

    SET new_presc_id = LAST_INSERT_ID();

    INSERT INTO prescription_details
        (PRESCRIPTION_ID, MEDICATION_ID, DOSAGE, DIRECTIONS, START_DATE)
    VALUES
        (new_presc_id, p_med_id, p_dosage, p_directions, CURDATE());
END //

DELIMITER ;

SELECT
    p.PRESCRIPTION_ID,
    p.CASE_ID,
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
    (PAYMENT_ID, CASE_ID, AMOUNT, PAYMENT_METHOD, PAYMENT_STATUS,
     PAYMENT_DATE, INSURANCE_PROVIDOR, TRANSACTION_REFRENCES)
VALUES
    (?, ?, ?, ?, ?, ?, ?, ?);

SELECT
    pay.PAYMENT_ID,
    pay.CASE_ID,
    ec.PATIENT_ID,
    pat.FNAME,
    pat.LNAME,
    pay.AMOUNT,
    pay.PAYMENT_METHOD,
    pay.PAYMENT_STATUS,
    pay.PAYMENT_DATE,
    pay.INSURANCE_PROVIDOR,
    pay.TRANSACTION_REFRENCES
FROM payments        pay
JOIN emergency_cases ec  ON ec.CASE_ID    = pay.CASE_ID
JOIN patients        pat ON pat.PATIENT_ID = ec.PATIENT_ID
WHERE pay.PAYMENT_ID = ?;

/* Update payment status */
UPDATE payments
SET    PAYMENT_STATUS        = ?,
       TRANSACTION_REFRENCES = ?,
       PAYMENT_DATE          = ?
WHERE  PAYMENT_ID            = ?;


/* Create refund */
INSERT INTO refunds
    (REFUND_ID, PAYMENT_ID, REFUND_AMOUNT, REFUND_DATE,
     REFUND_REASON, REFUND_STATUS)
VALUES
    (?, ?, ?, ?, ?, ?);

SELECT
    r.REFUND_ID,
    r.PAYMENT_ID,
    p.CASE_ID,
    r.REFUND_AMOUNT,
    r.REFUND_DATE,
    r.REFUND_REASON,
    r.REFUND_STATUS
FROM refunds  r
JOIN payments p ON p.PAYMENT_ID = r.PAYMENT_ID
WHERE r.REFUND_ID = ?;

/* Update refund status */
UPDATE refunds
SET    REFUND_STATUS = ?,
       REFUND_REASON = ?
WHERE  REFUND_ID     = ?;


SELECT
    p.PAYMENT_ID,
    p.CASE_ID,
    p.AMOUNT                                          AS GROSS_AMOUNT,
    COALESCE(SUM(r.REFUND_AMOUNT), 0)                AS TOTAL_REFUNDED,
    p.AMOUNT - COALESCE(SUM(r.REFUND_AMOUNT), 0)     AS NET_COLLECTED
FROM payments p
LEFT JOIN refunds r ON r.PAYMENT_ID = p.PAYMENT_ID
GROUP BY p.PAYMENT_ID, p.CASE_ID, p.AMOUNT;

SELECT
    p.PAYMENT_DATE,
    COUNT(*)       AS PAYMENT_COUNT,
    SUM(p.AMOUNT)  AS GROSS_REVENUE
FROM payments p
GROUP BY p.PAYMENT_DATE
ORDER BY p.PAYMENT_DATE;

SELECT
    r.REFUND_DATE,
    COUNT(*)             AS REFUND_COUNT,
    SUM(r.REFUND_AMOUNT) AS TOTAL_REFUNDED
FROM refunds r
GROUP BY r.REFUND_DATE
ORDER BY r.REFUND_DATE;

SELECT
    d.report_date,
    COALESCE(pay.gross_amount,    0)                                   AS GROSS_AMOUNT,
    COALESCE(ref.total_refunded,  0)                                   AS TOTAL_REFUNDED,
    COALESCE(pay.gross_amount, 0) - COALESCE(ref.total_refunded, 0)   AS NET_REVENUE
FROM (
    SELECT PAYMENT_DATE AS report_date FROM payments
    UNION
    SELECT REFUND_DATE  AS report_date FROM refunds
) d
LEFT JOIN (
    SELECT PAYMENT_DATE, SUM(AMOUNT)        AS gross_amount
    FROM   payments
    GROUP  BY PAYMENT_DATE
) pay ON pay.PAYMENT_DATE = d.report_date
LEFT JOIN (
    SELECT REFUND_DATE,  SUM(REFUND_AMOUNT) AS total_refunded
    FROM   refunds
    GROUP  BY REFUND_DATE
) ref ON ref.REFUND_DATE = d.report_date
ORDER BY d.report_date;

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

/*total patients visited today */
SELECT COUNT(DISTINCT PATIENT_ID) AS PATIENTS_TODAY
FROM   emergency_cases
WHERE  DATE_ISSUED = CURDATE();

/*prescriptions written today */
SELECT COUNT(*) AS PRESCRIPTIONS_TODAY
FROM   prescriptions
WHERE  PRESCRIPTION_DATE = CURDATE();