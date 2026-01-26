-- 1
Create Table Department 
(
	dept_Id Int Primary Key,
	dept_Name Varchar(100)
);

-- 2
Create Table Room 
(
	room_No Int Primary Key,
	dept_Id Int,
	room_Type Varchar(100),
	Foreign Key (dept_Id) References Department(dept_Id)
);

-- 3
Create Table Doctor 
(
	doct_Id Int Primary Key,
	dept_Id Int,
	FName Varchar(100),
	LName Varchar(100),
	Gender CHAR,
	contact_No Varchar(100),
	surgeon_Type Varchar(100),
	office_No Int,
	Foreign Key (dept_Id) References Department(dept_Id),
	Foreign Key (office_No) References Room(room_No)
);

-- 4
Create Table Nurse 
(
	nurse_Id Int Primary Key,
	dept_Id Int,
	FName Varchar(100),
	LName Varchar(100),
	Gender Char,
	conatct_No Varchar(100),
	Foreign Key (dept_Id) References Department(dept_Id)
);

-- 5
Create Table Helpers 
(
	helper_Id Int Primary Key,
	dept_Id Int,
	FName Varchar(100),
	LName Varchar(100),
	Gender Char,
	contact_No Varchar(100),
	Foreign Key (dept_Id) References Department(dept_Id)
);

-- 6
Create Table Ward 
(
	ward_No Int Primary Key,
	ward_Name Varchar(100),
	dept_Id Int,
	Foreign Key (dept_Id) References Department(dept_Id)
);

-- 7
Create Table Bed 
(
	bed_No Int Primary Key,
	ward_No Int,
	Foreign Key (ward_No) References Ward(ward_No)
);

-- 8
Create Table Patients 
(
	patient_Id Int Primary Key,
	FName Varchar(100),
	LName Varchar(100),
	Gender Char,
	Date_Of_Birth Date,
	contact_No Varchar(100),
	pt_Address Varchar(100)
);

-- 9
Create Table BedRecords 
(
	admission_Id Int Primary Key,
	bed_No Int,
	patient_Id Int,
	nurse_Id Int,
	helper_Id Int,
	admission_Date Date,
	discharge_Date Date,
	amount Int,
	mode_of_payment Varchar(50),
	Foreign Key (bed_No) References Bed(bed_No),
	Foreign Key (patient_Id) References Patients(patient_Id),
	Foreign Key (nurse_Id) References Nurse(nurse_Id),
	Foreign Key (helper_Id) References Helpers(helper_Id)
);

-- 10
Create Table RoomRecords 
(
	admisson_ID Int Primary Key,
	room_no Int,
	patient_Id Int,
	nurse_Id Int,
	helper_Id Int,
	admission_Date Date,
	discharge_Date Date,
	amount Int,
	mode_of_payment Varchar(50),
	Foreign Key (room_no) References Room(room_No),
	Foreign Key (patient_Id) References Patients(patient_Id),
	Foreign Key (nurse_Id) References Nurse(nurse_Id),
	Foreign Key (helper_Id) References Helpers(helper_Id)
);

-- 11
Create Table Appointment 
(
	appoIntment_Id Int Primary Key,
	patient_Id Int,
	doct_Id Int,
	reason Varchar(100),
	appointment_Date Date,
	payment_amount Int,
	mode_of_payment Varchar(100),
	mode_of_appointment Varchar(100),
	appointment_status Varchar(100),
	Foreign Key (patient_Id) References Patients(patient_Id),
	Foreign Key (doct_Id) References Doctor(doct_Id)
);

-- 12
Create Table MedicalRecord 
(
	record_Id Int Primary Key,
	doct_Id Int,
	patient_Id Int,
	visit_Date Date,
	curr_Weight Decimal(10,2),
	curr_height Decimal(10,2),
	curr_Blood_Pressure Varchar(100),
	curr_Temp_F Decimal(10,2),
	diagnosis Varchar(500),
	treatment Varchar(100),
	next_Visit Date,
	Foreign Key (doct_Id) References Doctor(doct_Id),
	Foreign Key (patient_Id) References Patients(patient_Id)
);

-- 13
Create Table StaffShift 
(
	shift_Id Int Primary Key,
	doct_Id Int,
	nurse_Id Int,
	helper_Id Int,
	shift_Date Date,
	shift_Start Time,
	shift_End Time,
	Foreign Key (doct_Id) References Doctor(doct_Id),
	Foreign Key (nurse_Id) References Nurse(nurse_Id),
	Foreign Key (helper_Id) References Helpers(helper_Id)
);

-- 14
Create Table SurgeryRecord 
(
	surgery_Id Int Primary Key,
	patient_Id Int,
	surgeon_Id Int,
	surgery_Type Varchar(100),
	surgery_Date Date,
	start_Time Time,
	end_Time Time,
	room_no Int,
	notes Varchar(1000),
	nurse_Id Int,
	helper_Id Int,
	Foreign Key (patient_Id) References Patients(patient_Id),
	Foreign Key (surgeon_Id) References Doctor(doct_Id),
	Foreign Key (room_no) References Room(room_No),
	Foreign Key (nurse_Id) References Nurse(nurse_Id),
	Foreign Key (helper_Id) References Helpers(helper_Id)
);
