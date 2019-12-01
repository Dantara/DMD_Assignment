-- Database: DMD Phase 3

-- DROP DATABASE "DMD Phase 3";
CREATE TABLE PATIENT(
  pid SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  phone_number Char(20),
  date_of_birth Date,
  medical_history Varchar(50),
  room_number INT,
  email varchar(50),
  password Varchar(20),
  PRIMARY KEY(pid),
  UNIQUE(medical_history),
  UNIQUE(email)
);

CREATE TABLE ACCOUNTANT(
  acid SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  email varchar(50),
  password Varchar(20),
  PRIMARY KEY(acid),
  UNIQUE(email)
);

CREATE TABLE SALARY(
  wid INT NOT NULL,
  amount INT NOT NULL,
  payed INT NOT NULL,
  PRIMARY KEY(wid) --partial 
);

CREATE TABLE ROOM(
  rid SERIAL NOT NULL,
  room_number INT NOT NULL,
  capacity INT NOT NULL,
  building Varchar(15),
  PRIMARY KEY(rid),
  UNIQUE(room_number)
);

CREATE TABLE HOSPITAL_ADMINISTRATOR (
  adid SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  email Varchar(50) NOT NULL,
  password Varchar(20) NOT NULL,
  PRIMARY KEY(adid),
  UNIQUE(email),
  UNIQUE(adid)
);

CREATE TABLE INVENTORY(
  iid INT NOT NULL,
  name Varchar(20) NOT NULL,
  price INT NOT NULL,
  amount INT NOT NULL,
  amount_paid INT NOT NULL,
  PRIMARY KEY(iid));


CREATE TABLE LABORATORY_ASSISTANT (
  aid SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  email Varchar(50) NOT NULL,
  password Varchar(20) NOT NULL, 
  PRIMARY KEY(aid),
  UNIQUE(email)
);

CREATE TABLE SYSTEM_ADMINISTRATOR(
  said SERIAL NOT NULL, 
  name Varchar(50) NOT NULL,
  email Varchar(50) NOT NULL,
  password Varchar(20) NOT NULL,
  PRIMARY KEY(said),
  UNIQUE(email)
);

CREATE TABLE DOCTOR(
  did SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  speciality Varchar(50) NOT NULL,
  email Varchar(50) NOT NULL,
  password Varchar(20) NOT NULL,
  PRIMARY KEY(did),
  UNIQUE(email)
);

CREATE TABLE NURSE(
  nid SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  email Varchar(50) NOT NULL,
  password Varchar(20) NOT NULL,
  PRIMARY KEY(nid),
  UNIQUE(email)
);

CREATE TABLE PAYMENT(
  paid SERIAL NOT NULL,
  amount Int,
  service Varchar(30) NOT NULL,
  date Date NOT NULL,
  PRIMARY KEY(paid)
);

CREATE TABLE SCHEDULE(
  --added attribute that is not in the diagram
  schid SERIAL NOT NULL,
  description Text,
  date_time date NOT NULL,
  id1 Int,--reference
  id2 Int,--reference
  room Int NOT NULL,
  PRIMARY KEY(schid)
);

CREATE TABLE LAB(
  lid SERIAL NOT NULL,
  room_number Int NOT NULL,
  PRIMARY KEY(lid)
);

CREATE TABLE TEST_RESULTS(
  tid SERIAL NOT NULL,
  result_file Varchar(30) NOT NULL,
  PRIMARY KEY(tid) --partial
);

CREATE TABLE CHECKS_MEDICAL_HISTORY(
  patient_id INT NOT NULL,--n-1
  doctor_id INT NOT NULL,
  FOREIGN KEY(patient_id) REFERENCES PATIENT (pid),
  FOREIGN KEY(doctor_id) REFERENCES DOCTOR (did)
);

CREATE TABLE SENDS_RECEIPT(
  patient_id INT NOT NULL,--n-1
  accountant_id INT NOT NULL,
  receipt Varchar(30),
  FOREIGN KEY(patient_id) REFERENCES PATIENT (pid),
  FOREIGN KEY(accountant_id) REFERENCES ACCOUNTANT (acid)
);

CREATE TABLE MAKES_A_PAYMENT(
  patient_id INT NOT NULL,--1-n
  payment_id INT NOT NULL,--total
  FOREIGN KEY(patient_id) REFERENCES PATIENT (pid),
  FOREIGN KEY(payment_id) REFERENCES PAYMENT (paid)
);

CREATE TABLE WRITES_MESSAGE(
  patient_id INT NOT NULL,--n-n
  doctor_id INT NOT NULL,
  text_message text NOT NULL,
  FOREIGN KEY(patient_id) REFERENCES PATIENT (pid),
  FOREIGN KEY(doctor_id) REFERENCES DOCTOR (did)  
);

CREATE TABLE MAKES_A_REQUEST(
  patient_id INT NOT NULL,--n-n
  nurse_id INT NOT NULL,
  date_time time NOT NULL,
  FOREIGN KEY(patient_id) REFERENCES PATIENT (pid),
  FOREIGN KEY(nurse_id) REFERENCES NURSE (nid)  
);

CREATE TABLE MAKES_AN_APPOINTMENT(
  patient_id INT NOT NULL,--1-n
  schedule_id INT NOT NULL,
  FOREIGN KEY(patient_id) REFERENCES PATIENT (pid),
  FOREIGN KEY(schedule_id) REFERENCES SCHEDULE (schid)  
);

CREATE TABLE NOTIFIES(
  patient_id INT NOT NULL,--1-1
  schedule_id INT NOT NULL,
  FOREIGN KEY(patient_id) REFERENCES PATIENT (pid),
  FOREIGN KEY(schedule_id) REFERENCES SCHEDULE (schid)  
);

CREATE TABLE OCCUPIES(
  schedule_id INT NOT NULL,--1-1
  room_id INT NOT NULL,
  FOREIGN KEY(schedule_id) REFERENCES SCHEDULE (schid),
  FOREIGN KEY(room_id) REFERENCES ROOM (rid)  
);

CREATE TABLE SCHEDULES_CLEANING(
  schedule_id INT NOT NULL,--n-1
  admin_id INT NOT NULL,
  FOREIGN KEY(schedule_id) REFERENCES SCHEDULE (schid),
  FOREIGN KEY(admin_id) REFERENCES HOSPITAL_ADMINISTRATOR (adid)  
);

CREATE TABLE IS_READY(
  schedule_id INT NOT NULL,--1-1
  test_result_id INT NOT NULL,--total
  FOREIGN KEY(schedule_id) REFERENCES SCHEDULE (schid),
  FOREIGN KEY(test_result_id) REFERENCES TEST_RESULTS (tid)
);

CREATE TABLE NOTIFIES_DOCTOR(
  schedule_id INT NOT NULL,--1-n(1-1)
  doctor_id INT NOT NULL,
  FOREIGN KEY(schedule_id) REFERENCES SCHEDULE (schid),
  FOREIGN KEY(doctor_id) REFERENCES DOCTOR (did)  
);

CREATE TABLE NOTIFIES_NURSE(
  schedule_id INT NOT NULL,--1-n(1-1)
  nurse_id INT NOT NULL,
  FOREIGN KEY(schedule_id) REFERENCES SCHEDULE (schid),
  FOREIGN KEY(nurse_id) REFERENCES NURSE (nid)  
);

CREATE TABLE BOOKS_ROOM(
  schedule_id INT NOT NULL,--1-n
  nurse_id INT NOT NULL,
  FOREIGN KEY(schedule_id) REFERENCES SCHEDULE (schid),
  FOREIGN KEY(nurse_id) REFERENCES NURSE (nid)  
);

CREATE TABLE DOCTOR_MAKES_AN_APPOINTMENT(
  doctor_id INT NOT NULL,--1-n
  schedule_id INT NOT NULL,
  FOREIGN KEY(doctor_id) REFERENCES  DOCTOR(did),
  FOREIGN KEY(schedule_id) REFERENCES SCHEDULE (schid)  
);

CREATE TABLE ENROLLS(
  admin_id INT NOT NULL,--1-n
  inventory_id INT NOT NULL,
  FOREIGN KEY(admin_id) REFERENCES HOSPITAL_ADMINISTRATOR (adid),
  FOREIGN KEY(inventory_id) REFERENCES INVENTORY (iid)  
);

CREATE TABLE GENERATES_RESULTS(
  lab_id INT NOT NULL,--1-1
  test_results_id INT NOT NULL,
  FOREIGN KEY(lab_id) REFERENCES LAB (lid),
  FOREIGN KEY(test_results_id) REFERENCES TEST_RESULTS (tid)  
);

CREATE TABLE MAKES_TESTS(
  lab_id INT NOT NULL,--n-n
  lab_assistant_id INT NOT NULL,
  FOREIGN KEY(lab_id) REFERENCES LAB (lid),
  FOREIGN KEY(lab_assistant_id) REFERENCES LABORATORY_ASSISTANT (aid)
);

CREATE TABLE NOTIFIES_LAB_ASSISTANT(
  lab_assistant_id INT NOT NULL,--1-1
  schedule_id INT NOT NULL,
  FOREIGN KEY(lab_assistant_id) REFERENCES LABORATORY_ASSISTANT (aid),
  FOREIGN KEY(schedule_id) REFERENCES SCHEDULE (schid)  
);

CREATE TABLE WRITES_MESSAGE_NURSE(
  nurse_id INT NOT NULL,--n-n
  doctor_id INT NOT NULL,
  text_message text NOT NULL,
  FOREIGN KEY(nurse_id) REFERENCES NURSE (nid),
  FOREIGN KEY(doctor_id) REFERENCES DOCTOR (did)  
);
