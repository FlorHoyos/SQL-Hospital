-- CTE for discharged rooms
-- total paid
-- average paid
-- where date is not null

WITH discharged_room AS 
(SELECT SUM(rr.amount) AS total_paid_room, 
		ROUND(AVG(rr.amount), 0) AS avg_paid_room, 	
		COUNT(rr.admisson_id) AS room
FROM roomrecords rr
WHERE rr.discharge_date IS NOT NULL),

-- CTE admitted rooms
-- total paid
-- average paid
-- where date is null
admitted_room AS (
  SELECT
    SUM(re.amount) AS total_paid_room_ad,
    AVG(re.amount) AS avg_paid_room_ad,
    COUNT(re.admisson_id) AS room_ad
  FROM roomrecords re
  WHERE re.discharge_date IS NULL
),

-- CTE discharged bed
-- total paid
-- average paid
-- where date is not null
discharged_bed AS 
(SELECT SUM(b.amount) AS total_paid_bed,
		ROUND(AVG(b.amount), 0) AS avg_paid_bed,
		COUNT(b.admission_id) AS bed
FROM bedrecords b
WHERE b.discharge_date IS NOT NULL),

-- CTE discharged bed
-- total paid
-- average paid
-- where date is null
admitted_bed AS (
  SELECT
    SUM(be.amount) AS total_paid_bed_ad,
    AVG(be.amount) AS avg_paid_bed_ad,
    COUNT(be.admission_id) AS bed_ad
  FROM bedrecords be
  WHERE be.discharge_date IS NULL
)

-- select and cross join 
SELECT
  rr.total_paid_room + b.total_paid_bed AS total_discharge_paid,
  (rr.total_paid_room + b.total_paid_bed)/ NULLIF(rr.room + b.bed, 0) AS avg_discharge_paid,
  rr.room + b.bed AS discharged_admissions,

  re.total_paid_room_ad + be.total_paid_bed_ad AS total_admitted_paid,
  (re.total_paid_room_ad + be.total_paid_bed_ad)/ NULLIF(re.room_ad + be.bed_ad, 0) AS avg_admitted_paid,
  re.room_ad + be.bed_ad AS admissions_still_admitted

FROM discharged_room rr
CROSS JOIN discharged_bed b
CROSS JOIN admitted_room re
CROSS JOIN admitted_bed be;


