USE EMERGENCYSYSTEM;

-- Disable constraints for clean bulk insert
SET FOREIGN_KEY_CHECKS = 0;

-- 3. ROOMS (Emergency & ICU Focus)
INSERT INTO rooms (ROOM_ID, ROOM_NO, ROOM_TYPE, PATIENT_ID, CAPACITY, AVAILABILITY_STATUS) VALUES 
(1, 101, 'Trauma Room', '3','1', 'A'),
(2, 102, 'ICU Bed 1', '2','1', 'A'),
(3, 103, 'Observation', '10','2', 'A'),
(4, 201, 'X-Ray Suite', '5','1', 'A'),
(5, 301, 'Cardiac ER', '7','1', 'A');

-- 4. DOCTORS (5 Specialized Members)
INSERT INTO doctors (DOCTOR_ID, SSN, FNAME, LNAME, GENDER, SPECIALTY, DEGREE, JOIN_DATE) VALUES 
(1, 100000001, 'Zyad', 'Mohamed', 'M', 'ER Specialist', 'Masters', '2025-01-01'),
(2, 100000002, 'Rowayda', 'Ahmed', 'F', 'Trauma Surgeon', 'PhD', '2025-06-01'),
(3, 100000003, 'Mazen', 'Ayman', 'M', 'Radiologist', 'Masters', '2025-03-01'),
(4, 100000004, 'Maya', 'Hatem', 'F', 'General Practitioner', 'MBChB', '2026-01-15'),
(5, 100000005, 'Ahmed', 'Elagami', 'M', 'Cardiologist', 'PhD', '2025-11-20');

-- 5. NURSES
INSERT INTO nurses (NURSE_ID, SSN, FNAME, LNAME, GENDER, SHIFT_TYPE) VALUES 
(1, 200000001, 'Jana', 'Sami', 'F', 'Night'),
(2, 200000002, 'Omar', 'Kamal', 'M', 'Day');

-- 6. PATIENTS (10 Diverse Cases)
INSERT INTO patients (PATIENT_ID, PATIENT_NO, SSN, FNAME, LNAME, GENDER, BLOODTYPE, ADDRESS) VALUES 
(1, 1001, 300000001, 'Karim', 'Fouad', 'M', 'O+', 'Sheikh Zayed City'),
(2, 1002, 300000002, 'Laila', 'Salem', 'F', 'A-', '6th of October'),
(3, 1003, 300000003, 'Youssef', 'Zaki', 'M', 'B+', 'Dokki, Giza'),
(4, 1004, 300000004, 'Mariam', 'Nasr', 'F', 'O-', 'Zamalek'),
(5, 1005, 300000005, 'Hassan', 'Reda', 'M', 'AB+', 'Maadi'),
(6, 1006, 300000006, 'Sara', 'Gad', 'F', 'A+', 'Heliopolis'),
(7, 1007, 300000007, 'Tarek', 'Amer', 'M', 'O+', 'Sheikh Zayed'),
(8, 1008, 300000008, 'Nour', 'Eldin', 'F', 'B-', 'Giza'),
(9, 1009, 300000009, 'Ali', 'Mansour', 'M', 'O-', 'New Cairo'),
(10, 1010, 300000010, 'Hoda', 'Saeed', 'F', 'A+', 'Dokki');

-- 7. EMERGENCY CASES (The "Core" of the Project)
INSERT INTO emergency_cases (CASE_ID, PATIENT_ID, DOCTOR_ID, AMBULANCE_ID, TRIAGE_LEVEL, CASE_STATUS, HEART_RATE, TEMP, BP, DATE_ISSUED) VALUES 
(1, 1, 1, 1, '1', 'Critical', '110', '38.5', '140/90', '2026-05-10'),
(2, 2, 2, 2, '2', 'Stable', '85', '37.2', '120/80', '2026-05-11'),
(3, 3, 1, 3, '3', 'Observation', '78', '36.8', '115/75', '2026-05-12'),
(4, 5, 5, 4, '1', 'Urgent', '125', '37.0', '160/100', '2026-05-13');

-- 8. MEDICATIONS
INSERT INTO medications (MEDICATION_ID, MEDICATION_NAME, MEDICATION_DESCRIPTION) VALUES 
(1, 'Adrenaline', 'Cardiac stimulant'),
(2, 'Morphine', 'Pain relief'),
(3, 'Insulin', 'Blood sugar control'),
(4, 'Aspirin', 'Blood thinner');

-- 9. AMBULANCES 
INSERT INTO AMBULANCES (AMBULANCE_ID, AMBULANCE_NO, DRIVER_NAME, AMBULANCE_STATUS) VALUES 
(1, 300, 'AHMED', 'OCCUPAIED'),
(2, 200, 'MOHAMED', 'AVAILABLE'),
(3, 500, 'HOSSAM', 'AVAILABLE'),
(4, 400, 'SAMIR', 'OCCUPAIED');

-- 10. INVESTIGATING (Doctor-Patient Hours)
INSERT INTO investigating (DOCTOR_ID, PATIENT_ID, HOURS_PER_WEEK) VALUES 
(1, 1, 12.5),
(2, 2, 8.0),
(1, 3, 4.5);

SET FOREIGN_KEY_CHECKS = 1;
