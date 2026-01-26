/* ONE-SQL Hospital DB Validation (Postgres) */

WITH
row_counts AS (
  SELECT 'Rowcount: Department'    AS check_name, 'INFO' AS severity, COUNT(*)::bigint AS failing_rows, 'PASS' AS status, NULL::text AS notes FROM Department
  UNION ALL SELECT 'Rowcount: Room'           ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM Room
  UNION ALL SELECT 'Rowcount: Doctor'         ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM Doctor
  UNION ALL SELECT 'Rowcount: Nurse'          ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM Nurse
  UNION ALL SELECT 'Rowcount: Helpers'        ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM Helpers
  UNION ALL SELECT 'Rowcount: Ward'           ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM Ward
  UNION ALL SELECT 'Rowcount: Bed'            ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM Bed
  UNION ALL SELECT 'Rowcount: Patients'       ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM Patients
  UNION ALL SELECT 'Rowcount: BedRecords'     ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM BedRecords
  UNION ALL SELECT 'Rowcount: RoomRecords'    ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM RoomRecords
  UNION ALL SELECT 'Rowcount: Appointment'    ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM Appointment
  UNION ALL SELECT 'Rowcount: MedicalRecord'  ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM MedicalRecord
  UNION ALL SELECT 'Rowcount: StaffShift'     ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM StaffShift
  UNION ALL SELECT 'Rowcount: SurgeryRecord'  ,'INFO', COUNT(*)::bigint, 'PASS', NULL FROM SurgeryRecord
),
null_checks AS (
  SELECT 'NULL PK: Department.dept_id' AS check_name, 'ERROR' AS severity,
         COUNT(*)::bigint AS failing_rows,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END AS status,
         'Primary key should not be NULL' AS notes
  FROM Department WHERE dept_id IS NULL

  UNION ALL SELECT 'NULL PK: Room.room_no', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM Room WHERE room_no IS NULL

  UNION ALL SELECT 'NULL PK: Doctor.doct_id', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM Doctor WHERE doct_id IS NULL

  UNION ALL SELECT 'NULL PK: Nurse.nurse_id', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM Nurse WHERE nurse_id IS NULL

  UNION ALL SELECT 'NULL PK: Helpers.helper_id', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM Helpers WHERE helper_id IS NULL

  UNION ALL SELECT 'NULL PK: Ward.ward_no', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM Ward WHERE ward_no IS NULL

  UNION ALL SELECT 'NULL PK: Bed.bed_no', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM Bed WHERE bed_no IS NULL

  UNION ALL SELECT 'NULL PK: Patients.patient_id', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM Patients WHERE patient_id IS NULL

  UNION ALL SELECT 'NULL PK: BedRecords.admission_id', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM BedRecords WHERE admission_id IS NULL

  UNION ALL SELECT 'NULL PK: RoomRecords.admisson_id', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'PK column is admisson_id in your schema'
  FROM RoomRecords WHERE admisson_id IS NULL

  UNION ALL SELECT 'NULL PK: Appointment.appointment_id', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM Appointment WHERE appointment_id IS NULL

  UNION ALL SELECT 'NULL PK: MedicalRecord.record_id', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM MedicalRecord WHERE record_id IS NULL

  UNION ALL SELECT 'NULL PK: StaffShift.shift_id', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM StaffShift WHERE shift_id IS NULL

  UNION ALL SELECT 'NULL PK: SurgeryRecord.surgery_id', 'ERROR', COUNT(*)::bigint,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Primary key should not be NULL'
  FROM SurgeryRecord WHERE surgery_id IS NULL
),
orphan_fks AS (
  SELECT 'Orphan FK: Room.dept_id -> Department.dept_id' AS check_name, 'ERROR' AS severity,
         COUNT(*)::bigint AS failing_rows,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END AS status,
         NULL::text AS notes
  FROM Room r
  LEFT JOIN Department d ON d.dept_id = r.dept_id
  WHERE r.dept_id IS NOT NULL AND d.dept_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: Doctor.dept_id -> Department.dept_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM Doctor doc
  LEFT JOIN Department d ON d.dept_id = doc.dept_id
  WHERE doc.dept_id IS NOT NULL AND d.dept_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: Doctor.office_no -> Room.room_no', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM Doctor doc
  LEFT JOIN Room r ON r.room_no = doc.office_no
  WHERE doc.office_no IS NOT NULL AND r.room_no IS NULL

  UNION ALL
  SELECT 'Orphan FK: Nurse.dept_id -> Department.dept_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM Nurse n
  LEFT JOIN Department d ON d.dept_id = n.dept_id
  WHERE n.dept_id IS NOT NULL AND d.dept_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: Helpers.dept_id -> Department.dept_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM Helpers h
  LEFT JOIN Department d ON d.dept_id = h.dept_id
  WHERE h.dept_id IS NOT NULL AND d.dept_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: Ward.dept_id -> Department.dept_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM Ward w
  LEFT JOIN Department d ON d.dept_id = w.dept_id
  WHERE w.dept_id IS NOT NULL AND d.dept_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: Bed.ward_no -> Ward.ward_no', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM Bed b
  LEFT JOIN Ward w ON w.ward_no = b.ward_no
  WHERE b.ward_no IS NOT NULL AND w.ward_no IS NULL

  UNION ALL
  SELECT 'Orphan FK: BedRecords.bed_no -> Bed.bed_no', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM BedRecords br
  LEFT JOIN Bed b ON b.bed_no = br.bed_no
  WHERE br.bed_no IS NOT NULL AND b.bed_no IS NULL

  UNION ALL
  SELECT 'Orphan FK: BedRecords.patient_id -> Patients.patient_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM BedRecords br
  LEFT JOIN Patients p ON p.patient_id = br.patient_id
  WHERE br.patient_id IS NOT NULL AND p.patient_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: BedRecords.nurse_id -> Nurse.nurse_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM BedRecords br
  LEFT JOIN Nurse n ON n.nurse_id = br.nurse_id
  WHERE br.nurse_id IS NOT NULL AND n.nurse_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: BedRecords.helper_id -> Helpers.helper_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM BedRecords br
  LEFT JOIN Helpers h ON h.helper_id = br.helper_id
  WHERE br.helper_id IS NOT NULL AND h.helper_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: RoomRecords.room_no -> Room.room_no', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM RoomRecords rr
  LEFT JOIN Room r ON r.room_no = rr.room_no
  WHERE rr.room_no IS NOT NULL AND r.room_no IS NULL

  UNION ALL
  SELECT 'Orphan FK: RoomRecords.patient_id -> Patients.patient_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM RoomRecords rr
  LEFT JOIN Patients p ON p.patient_id = rr.patient_id
  WHERE rr.patient_id IS NOT NULL AND p.patient_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: RoomRecords.nurse_id -> Nurse.nurse_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM RoomRecords rr
  LEFT JOIN Nurse n ON n.nurse_id = rr.nurse_id
  WHERE rr.nurse_id IS NOT NULL AND n.nurse_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: RoomRecords.helper_id -> Helpers.helper_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM RoomRecords rr
  LEFT JOIN Helpers h ON h.helper_id = rr.helper_id
  WHERE rr.helper_id IS NOT NULL AND h.helper_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: Appointment.patient_id -> Patients.patient_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM Appointment a
  LEFT JOIN Patients p ON p.patient_id = a.patient_id
  WHERE a.patient_id IS NOT NULL AND p.patient_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: Appointment.doct_id -> Doctor.doct_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM Appointment a
  LEFT JOIN Doctor d ON d.doct_id = a.doct_id
  WHERE a.doct_id IS NOT NULL AND d.doct_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: MedicalRecord.patient_id -> Patients.patient_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM MedicalRecord mr
  LEFT JOIN Patients p ON p.patient_id = mr.patient_id
  WHERE mr.patient_id IS NOT NULL AND p.patient_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: MedicalRecord.doct_id -> Doctor.doct_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM MedicalRecord mr
  LEFT JOIN Doctor d ON d.doct_id = mr.doct_id
  WHERE mr.doct_id IS NOT NULL AND d.doct_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: StaffShift.doct_id -> Doctor.doct_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM StaffShift ss
  LEFT JOIN Doctor d ON d.doct_id = ss.doct_id
  WHERE ss.doct_id IS NOT NULL AND d.doct_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: StaffShift.nurse_id -> Nurse.nurse_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM StaffShift ss
  LEFT JOIN Nurse n ON n.nurse_id = ss.nurse_id
  WHERE ss.nurse_id IS NOT NULL AND n.nurse_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: StaffShift.helper_id -> Helpers.helper_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM StaffShift ss
  LEFT JOIN Helpers h ON h.helper_id = ss.helper_id
  WHERE ss.helper_id IS NOT NULL AND h.helper_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: SurgeryRecord.patient_id -> Patients.patient_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM SurgeryRecord sr
  LEFT JOIN Patients p ON p.patient_id = sr.patient_id
  WHERE sr.patient_id IS NOT NULL AND p.patient_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: SurgeryRecord.surgeon_id -> Doctor.doct_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM SurgeryRecord sr
  LEFT JOIN Doctor d ON d.doct_id = sr.surgeon_id
  WHERE sr.surgeon_id IS NOT NULL AND d.doct_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: SurgeryRecord.room_no -> Room.room_no', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM SurgeryRecord sr
  LEFT JOIN Room r ON r.room_no = sr.room_no
  WHERE sr.room_no IS NOT NULL AND r.room_no IS NULL

  UNION ALL
  SELECT 'Orphan FK: SurgeryRecord.nurse_id -> Nurse.nurse_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM SurgeryRecord sr
  LEFT JOIN Nurse n ON n.nurse_id = sr.nurse_id
  WHERE sr.nurse_id IS NOT NULL AND n.nurse_id IS NULL

  UNION ALL
  SELECT 'Orphan FK: SurgeryRecord.helper_id -> Helpers.helper_id', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM SurgeryRecord sr
  LEFT JOIN Helpers h ON h.helper_id = sr.helper_id
  WHERE sr.helper_id IS NOT NULL AND h.helper_id IS NULL
),
dup_keys AS (
  SELECT 'Duplicate PK: Department.dept_id' AS check_name, 'ERROR' AS severity,
         COUNT(*)::bigint AS failing_rows,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END AS status,
         NULL::text AS notes
  FROM (SELECT dept_id FROM Department GROUP BY dept_id HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: Room.room_no','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT room_no FROM Room GROUP BY room_no HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: Doctor.doct_id','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT doct_id FROM Doctor GROUP BY doct_id HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: Nurse.nurse_id','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT nurse_id FROM Nurse GROUP BY nurse_id HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: Helpers.helper_id','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT helper_id FROM Helpers GROUP BY helper_id HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: Ward.ward_no','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT ward_no FROM Ward GROUP BY ward_no HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: Bed.bed_no','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT bed_no FROM Bed GROUP BY bed_no HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: Patients.patient_id','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT patient_id FROM Patients GROUP BY patient_id HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: BedRecords.admission_id','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT admission_id FROM BedRecords GROUP BY admission_id HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: RoomRecords.admisson_id','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, 'Column is admisson_id'
  FROM (SELECT admisson_id FROM RoomRecords GROUP BY admisson_id HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: Appointment.appointment_id','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT appointment_id FROM Appointment GROUP BY appointment_id HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: MedicalRecord.record_id','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT record_id FROM MedicalRecord GROUP BY record_id HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: StaffShift.shift_id','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT shift_id FROM StaffShift GROUP BY shift_id HAVING COUNT(*)>1) x

  UNION ALL SELECT 'Duplicate PK: SurgeryRecord.surgery_id','ERROR', COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM (SELECT surgery_id FROM SurgeryRecord GROUP BY surgery_id HAVING COUNT(*)>1) x
),
quality_checks AS (
  SELECT 'Negative amount: BedRecords.amount < 0' AS check_name, 'WARN' AS severity,
         COUNT(*)::bigint AS failing_rows,
         CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END AS status,
         NULL::text AS notes
  FROM BedRecords WHERE amount < 0

  UNION ALL
  SELECT 'Negative amount: RoomRecords.amount < 0', 'WARN',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM RoomRecords WHERE amount < 0

  UNION ALL
  SELECT 'Negative payment: Appointment.payment_amount < 0', 'WARN',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM Appointment WHERE payment_amount < 0

  UNION ALL
  SELECT 'Date rule: BedRecords discharge_date < admission_date', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM BedRecords
  WHERE discharge_date IS NOT NULL AND discharge_date < admission_date

  UNION ALL
  SELECT 'Date rule: RoomRecords discharge_date < admission_date', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM RoomRecords
  WHERE discharge_date IS NOT NULL AND discharge_date < admission_date

  UNION ALL
  SELECT 'DOB rule: Patients.date_of_birth > CURRENT_DATE', 'ERROR',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END, NULL
  FROM Patients
  WHERE date_of_birth > CURRENT_DATE

  UNION ALL
  SELECT 'Time rule: SurgeryRecord end_time <= start_time', 'WARN',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END,
         'Flags overnight surgeries; adjust if allowed'
  FROM SurgeryRecord
  WHERE end_time IS NOT NULL AND start_time IS NOT NULL AND end_time <= start_time

  UNION ALL
  SELECT 'Time rule: StaffShift shift_end <= shift_start', 'WARN',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END,
         'Flags overnight shifts; adjust if allowed'
  FROM StaffShift
  WHERE shift_end IS NOT NULL AND shift_start IS NOT NULL AND shift_end <= shift_start

  UNION ALL
  SELECT 'Vitals: MedicalRecord curr_temp_f outside 90-110', 'WARN',
         COUNT(*)::bigint, CASE WHEN COUNT(*)=0 THEN 'PASS' ELSE 'FAIL' END,
         'Adjust bounds as needed'
  FROM MedicalRecord
  WHERE curr_temp_f IS NOT NULL AND (curr_temp_f < 90 OR curr_temp_f > 110)
)

SELECT *
FROM (
  SELECT * FROM row_counts
  UNION ALL SELECT * FROM null_checks
  UNION ALL SELECT * FROM orphan_fks
  UNION ALL SELECT * FROM dup_keys
  UNION ALL SELECT * FROM quality_checks
) u
ORDER BY
  CASE u.severity WHEN 'ERROR' THEN 1 WHEN 'WARN' THEN 2 ELSE 3 END,
  u.failing_rows DESC,
  u.check_name;
