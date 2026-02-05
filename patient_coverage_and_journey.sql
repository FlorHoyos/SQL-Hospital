-- Which patients have never had an appointment scheduled

SELECT p.FName AS First_Name, p.LName AS Last_Name, p.patient_id 
FROM Patients p
LEFT JOIN Appointment a ON p.patient_id = a.patient_id 
WHERE a.appointment_id IS NULL
ORDER BY patient_id ASC ;

-- For each patient, what was their first ever appointment
-- date and doctor

SELECT a.patient_id, a.appointment_date::date AS first_appt, d.doct_id, d.fname, d.lname
FROM Appointment a 
JOIN doctor d ON d.doct_id = a.doct_id
ORDER BY a.patient_id, first_appt ASC, a.appointment_id ASC;

WITH first_appt AS (
    SELECT patient_id, MIN(appointment_date) AS first_appt
    FROM appointment
    GROUP BY patient_id
)
SELECT f.patient_id,
       f.first_appt::date,
       d.doct_id,
       d.fname,
       d.lname
FROM first_appt f
JOIN appointment a ON a.patient_id = f.patient_id
 AND a.appointment_date = f.first_appt
JOIN doctor d ON d.doct_id = a.doct_id
ORDER BY f.patient_id;







