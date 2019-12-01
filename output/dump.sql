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
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Joseph Clark', 'brewercarol@hotmail.com', 'FlRIxVpaUWok');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Joseph Clark', '8 943 209 1031', '1940-07-21', 'brewercarol@hotmail.com', 'Early thus leader thus human.', '406', 'FlRIxVpaUWok');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Jeremy Robinson', 'whitesarah@hotmail.com', 'GtsNVgEHryYxngxKV');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Jeremy Robinson', '+7 343 553 5364', '1921-09-29', 'whitesarah@hotmail.com', 'Office fly major short type.', '433', 'GtsNVgEHryYxngxKV');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Angela Graham', 'jenny08@hotmail.com', 'sSSaQatWBSqvdPfFkqG');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Angela Graham', '87744564222', '1955-05-12', 'jenny08@hotmail.com', 'Upon available indeed parent prove would.', '460', 'sSSaQatWBSqvdPfFkqG');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Kimberly Parker', 'dawn71@gmail.com', 'aPfrjNBoJdg');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Kimberly Parker', '+74718625646', '2007-08-24', 'dawn71@gmail.com', 'Either space despite.', '77', 'aPfrjNBoJdg');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Rhonda Escobar MD', 'rromero@yahoo.com', 'rBDazhqtZ');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Rhonda Escobar MD', '+7 377 776 62 71', '1933-01-01', 'rromero@yahoo.com', 'Partner no yet large. Economic once government.', '237', 'rBDazhqtZ');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Joyce Anderson', 'stewartkim@hotmail.com', 'zaQrSyIptMdKoCCo');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Joyce Anderson', '+7 (986) 830-2777', '1984-06-30', 'stewartkim@hotmail.com', 'Impact cover southern here far.', '314', 'zaQrSyIptMdKoCCo');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Richard Murray', 'leenicole@gmail.com', 'zXQncwjGfvkFjjO');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Richard Murray', '+7 (399) 642-6381', '1952-06-18', 'leenicole@gmail.com', 'Role be people six.', '388', 'zXQncwjGfvkFjjO');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Alexander Romero', 'nbutler@yahoo.com', 'OKRGmXFFKI');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Alexander Romero', '+7 (812) 823-5356', '1948-02-12', 'nbutler@yahoo.com', 'Late agree month word. Rate turn will.', '435', 'OKRGmXFFKI');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Karen Novak', 'mitchellcraig@gmail.com', 'LqlUjBPeNSrD');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Karen Novak', '8 (080) 596-52-98', '2010-10-03', 'mitchellcraig@gmail.com', 'Statement mind again product church.', '136', 'LqlUjBPeNSrD');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Christopher Hanson', 'nathan10@yahoo.com', 'vNYBEnJWRzPPrh');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Christopher Hanson', '8 692 580 2730', '1911-12-19', 'nathan10@yahoo.com', 'Best respond child beyond develop current.', '424', 'vNYBEnJWRzPPrh');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Kim Nelson', 'brianestrada@hotmail.com', 'kwrvwquKprZZnVIKPym');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Kim Nelson', '8 579 593 80 60', '1932-01-05', 'brianestrada@hotmail.com', 'Man experience structure hold budget.', '466', 'kwrvwquKprZZnVIKPym');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Rachel Townsend', 'michelle37@yahoo.com', 'SdVmkUuNDFTIVUNGuFGG');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Rachel Townsend', '8 378 865 50 47', '2002-06-30', 'michelle37@yahoo.com', 'Door tough task every painting owner.', '180', 'SdVmkUuNDFTIVUNGuFGG');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Jody Powers', 'nicholas16@gmail.com', 'ZuHrYIOfLyTbgkXy');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Jody Powers', '+77881410593', '1973-06-03', 'nicholas16@gmail.com', 'Skill especially not foot million into.', '17', 'ZuHrYIOfLyTbgkXy');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Sharon Edwards', 'david89@yahoo.com', 'WlJrNBfogkqPHtg');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Sharon Edwards', '+7 (250) 275-72-50', '1946-09-18', 'david89@yahoo.com', 'Southern much you candidate actually.', '212', 'WlJrNBfogkqPHtg');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Barbara Nguyen', 'idixon@yahoo.com', 'PpULIDnAdsIJSdRoOPgL');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Barbara Nguyen', '8 (998) 638-14-71', '2003-05-27', 'idixon@yahoo.com', 'Close else network instead group meet rise.', '136', 'PpULIDnAdsIJSdRoOPgL');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Laura Jones', 'cgreen@hotmail.com', 'JYHEoavofotN');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Laura Jones', '8 (892) 742-6870', '1908-01-02', 'cgreen@hotmail.com', 'Decision only because risk.', '69', 'JYHEoavofotN');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Natalie Clay', 'stephenswalter@yahoo.com', 'CDpoFSsYfGdfDoO');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Natalie Clay', '8 616 744 1411', '1975-06-06', 'stephenswalter@yahoo.com', 'Cover air on cup successful present young.', '113', 'CDpoFSsYfGdfDoO');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Alexis Patrick', 'frygarrett@hotmail.com', 'wIRBJFJXqorTJ');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Alexis Patrick', '+7 196 537 4111', '2007-07-27', 'frygarrett@hotmail.com', 'Through sell world thus four base.', '30', 'wIRBJFJXqorTJ');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Ana Graham', 'qallison@yahoo.com', 'ibEuFgWgBhDwgfa');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Ana Graham', '8 (720) 827-6023', '1941-12-04', 'qallison@yahoo.com', 'View expect turn keep east somebody white.', '82', 'ibEuFgWgBhDwgfa');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Brian Bailey', 'crystal63@hotmail.com', 'MBHTTeFQA');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Brian Bailey', '80971474517', '1954-04-22', 'crystal63@hotmail.com', 'Week father maybe far.', '278', 'MBHTTeFQA');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Joseph Lam', 'riveracarlos@gmail.com', 'GfHiZPyWSIlYAqNvNB');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Joseph Lam', '+7 895 469 6986', '1944-05-12', 'riveracarlos@gmail.com', 'Reduce writer response individual check clear.', '332', 'GfHiZPyWSIlYAqNvNB');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Jeffery Smith', 'hollylewis@hotmail.com', 'KKihaimtEgqNI');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Jeffery Smith', '+7 (877) 090-82-06', '2008-07-09', 'hollylewis@hotmail.com', 'Woman investment point fish reason herself.', '38', 'KKihaimtEgqNI');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Joshua Barrera', 'donnathomas@yahoo.com', 'WaQKgXbgVyiRLiQYiP');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Joshua Barrera', '8 969 059 82 49', '1979-10-09', 'donnathomas@yahoo.com', 'Pick against friend agency myself down.', '405', 'WaQKgXbgVyiRLiQYiP');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Gabriela Allen', 'jennifercruz@gmail.com', 'xSLCqznSlrZfd');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Gabriela Allen', '85815976094', '1985-02-12', 'jennifercruz@gmail.com', 'Peace huge central expert nice reason.', '171', 'xSLCqznSlrZfd');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Joshua Bernard', 'andreweaton@hotmail.com', 'qvDJRoLkUQuJFtZ');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Joshua Bernard', '8 620 595 35 42', '1983-03-09', 'andreweaton@hotmail.com', 'World stage field gun behavior your reduce.', '305', 'qvDJRoLkUQuJFtZ');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Steven Nicholson', 'petersmelissa@hotmail.com', 'RyQfzIlufrV');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Steven Nicholson', '8 261 744 5479', '1905-11-14', 'petersmelissa@hotmail.com', 'Ok win miss nearly. True large think shake.', '64', 'RyQfzIlufrV');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Sherry Soto', 'ccastillo@hotmail.com', 'qmdWfSwIlIkpk');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Sherry Soto', '8 (697) 980-78-17', '1912-09-20', 'ccastillo@hotmail.com', 'Worry part shoulder tough red.', '381', 'qmdWfSwIlIkpk');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Kevin Ramirez', 'rebeccarodriguez@hotmail.com', 'FeRZJtUaigU');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Kevin Ramirez', '8 (228) 821-1605', '1999-05-05', 'rebeccarodriguez@hotmail.com', 'Every live specific day can education sell.', '95', 'FeRZJtUaigU');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Anthony Murray', 'morgandouglas@gmail.com', 'pUlrUCUSXFddmMqfK');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Anthony Murray', '+70146670887', '1990-02-26', 'morgandouglas@gmail.com', 'Drop physical performance.', '45', 'pUlrUCUSXFddmMqfK');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Patrick Whitaker', 'braunsharon@yahoo.com', 'yzzjkSuHHZQxzD');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Patrick Whitaker', '8 908 172 99 02', '1926-12-11', 'braunsharon@yahoo.com', 'Kind past catch gun.', '469', 'yzzjkSuHHZQxzD');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Kristina Elliott', 'harrisjeffrey@hotmail.com', 'CryPWfExwu');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Kristina Elliott', '+7 (277) 000-86-97', '1928-03-29', 'harrisjeffrey@hotmail.com', 'Case seat until business.', '55', 'CryPWfExwu');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Nathan Fowler', 'coxcrystal@yahoo.com', 'YROwUgMdKBRTTkaFNBAR');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Nathan Fowler', '+7 320 944 30 77', '2005-11-15', 'coxcrystal@yahoo.com', 'Fire there I successful time simply more child.', '440', 'YROwUgMdKBRTTkaFNBAR');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Jessica House', 'lawrencemiller@gmail.com', 'frKnHXwsvHHznWdQF');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Jessica House', '8 916 914 0638', '1982-04-16', 'lawrencemiller@gmail.com', 'Loss four deal relationship since.', '366', 'frKnHXwsvHHznWdQF');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('David Stewart', 'ashley79@gmail.com', 'uUgeceIraqWMR');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('David Stewart', '8 (615) 696-9976', '2005-10-16', 'ashley79@gmail.com', 'Charge build rock national everyone sound.', '421', 'uUgeceIraqWMR');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Shirley Leon', 'thomasjones@yahoo.com', 'jssxVVNCBpfl');
INSERT INTO PATIENT (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Shirley Leon', '+74476897282', '2016-12-01', 'thomasjones@yahoo.com', 'Expect friend make small wonder.', '6', 'jssxVVNCBpfl');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Patricia Dyer', 'john97@gmail.com', 'nKFRWjmkD');
INSERT INTO HOSPITAL_ADMINISTRATOR (name, email, password) VALUES ('Patricia Dyer', 'john97@gmail.com', 'nKFRWjmkD');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Michael Vasquez', 'oritter@gmail.com', 'GJeicdrJoOgPg');
INSERT INTO HOSPITAL_ADMINISTRATOR (name, email, password) VALUES ('Michael Vasquez', 'oritter@gmail.com', 'GJeicdrJoOgPg');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Kristin Bridges', 'davisroberto@yahoo.com', 'SvlMvzLwyJDVlVT');
INSERT INTO HOSPITAL_ADMINISTRATOR (name, email, password) VALUES ('Kristin Bridges', 'davisroberto@yahoo.com', 'SvlMvzLwyJDVlVT');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Lori Phillips', 'olopez@hotmail.com', 'sbUdDtUeSSyFdNeaNSi');
INSERT INTO LABORATORY_ASSISTANT (name, email, password) VALUES ('Lori Phillips', 'olopez@hotmail.com', 'sbUdDtUeSSyFdNeaNSi');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Natalie Allen DVM', 'duarteeduardo@gmail.com', 'ilSgKquoxFsmSaBXiZJ');
INSERT INTO LABORATORY_ASSISTANT (name, email, password) VALUES ('Natalie Allen DVM', 'duarteeduardo@gmail.com', 'ilSgKquoxFsmSaBXiZJ');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Daniel Ferguson', 'carol56@gmail.com', 'hjqkOgbEBdVDAjzHH');
INSERT INTO LABORATORY_ASSISTANT (name, email, password) VALUES ('Daniel Ferguson', 'carol56@gmail.com', 'hjqkOgbEBdVDAjzHH');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Leah Lewis', 'melissa86@gmail.com', 'wZISizxqUNPVqGyRhJXw');
INSERT INTO LABORATORY_ASSISTANT (name, email, password) VALUES ('Leah Lewis', 'melissa86@gmail.com', 'wZISizxqUNPVqGyRhJXw');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Jennifer Morrow', 'robert83@gmail.com', 'bAUdsPuvqRfnjw');
INSERT INTO LABORATORY_ASSISTANT (name, email, password) VALUES ('Jennifer Morrow', 'robert83@gmail.com', 'bAUdsPuvqRfnjw');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('William Huynh', 'dennis57@hotmail.com', 'szosbcVNRTKF');
INSERT INTO SYSTEM_ADMINISTRATOR (name, email, password) VALUES ('William Huynh', 'dennis57@hotmail.com', 'szosbcVNRTKF');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Shawn Hunt', 'levi50@gmail.com', 'MVihxovUR');
INSERT INTO SYSTEM_ADMINISTRATOR (name, email, password) VALUES ('Shawn Hunt', 'levi50@gmail.com', 'MVihxovUR');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('James Ball', 'carrjose@hotmail.com', 'dOQuxfJONigKvrj');
INSERT INTO SYSTEM_ADMINISTRATOR (name, email, password) VALUES ('James Ball', 'carrjose@hotmail.com', 'dOQuxfJONigKvrj');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Christopher Hernandez', 'mccormickcaitlin@gmail.com', 'sSMjWYdkNDperFPcF');
INSERT INTO SYSTEM_ADMINISTRATOR (name, email, password) VALUES ('Christopher Hernandez', 'mccormickcaitlin@gmail.com', 'sSMjWYdkNDperFPcF');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Damon Gonzalez', 'kelly67@hotmail.com', 'WcffBTconinwesuaXZ');
INSERT INTO DOCTOR (name, email, password, speciality) VALUES ('Damon Gonzalez', 'kelly67@hotmail.com', 'WcffBTconinwesuaXZ', 'pediatrics');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Frank King II', 'chapmanchristine@yahoo.com', 'pdYoFdhfjlSWDicB');
INSERT INTO DOCTOR (name, email, password, speciality) VALUES ('Frank King II', 'chapmanchristine@yahoo.com', 'pdYoFdhfjlSWDicB', 'dermatology');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('John Foster', 'nataliepayne@hotmail.com', 'ojudGWLALkiXaoV');
INSERT INTO DOCTOR (name, email, password, speciality) VALUES ('John Foster', 'nataliepayne@hotmail.com', 'ojudGWLALkiXaoV', 'emergency medicine');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Jennifer Miller', 'erika83@hotmail.com', 'MjccWmPypiMODG');
INSERT INTO DOCTOR (name, email, password, speciality) VALUES ('Jennifer Miller', 'erika83@hotmail.com', 'MjccWmPypiMODG', 'diagnostic radiology');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Nicole Smith', 'destiny43@gmail.com', 'TwYhhlRVm');
INSERT INTO DOCTOR (name, email, password, speciality) VALUES ('Nicole Smith', 'destiny43@gmail.com', 'TwYhhlRVm', 'neurology');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Madison White', 'karafisher@gmail.com', 'fBdShESLJi');
INSERT INTO DOCTOR (name, email, password, speciality) VALUES ('Madison White', 'karafisher@gmail.com', 'fBdShESLJi', 'emergency medicine');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Jaclyn Madden', 'charles16@hotmail.com', 'FAEXAxOeWfWRhn');
INSERT INTO DOCTOR (name, email, password, speciality) VALUES ('Jaclyn Madden', 'charles16@hotmail.com', 'FAEXAxOeWfWRhn', 'family medicine');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Jon Clayton', 'richardsbrittney@yahoo.com', 'WAMhVjhT');
INSERT INTO DOCTOR (name, email, password, speciality) VALUES ('Jon Clayton', 'richardsbrittney@yahoo.com', 'WAMhVjhT', 'family medicine');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Tina Johnson', 'williamadams@gmail.com', 'GjuhQEnaHYaCgAKZmgMN');
INSERT INTO DOCTOR (name, email, password, speciality) VALUES ('Tina Johnson', 'williamadams@gmail.com', 'GjuhQEnaHYaCgAKZmgMN', 'pediatrics');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Alexandra Cooper', 'thomasbrittany@yahoo.com', 'QFIiUkHkl');
INSERT INTO DOCTOR (name, email, password, speciality) VALUES ('Alexandra Cooper', 'thomasbrittany@yahoo.com', 'QFIiUkHkl', 'neurology');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Vernon Elliott', 'kimberly62@yahoo.com', 'UCRxrswXM');
INSERT INTO NURSE (name, email, password) VALUES ('Vernon Elliott', 'kimberly62@yahoo.com', 'UCRxrswXM');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Alejandro Gonzalez', 'rayhaley@gmail.com', 'DwMeVkxHI');
INSERT INTO NURSE (name, email, password) VALUES ('Alejandro Gonzalez', 'rayhaley@gmail.com', 'DwMeVkxHI');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Tracey Walker', 'paulclark@gmail.com', 'LndpwtjU');
INSERT INTO NURSE (name, email, password) VALUES ('Tracey Walker', 'paulclark@gmail.com', 'LndpwtjU');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Jenna Ruiz', 'xsimon@yahoo.com', 'MgKiJiIKHWqTLV');
INSERT INTO NURSE (name, email, password) VALUES ('Jenna Ruiz', 'xsimon@yahoo.com', 'MgKiJiIKHWqTLV');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Justin Morris', 'jameshart@gmail.com', 'NJdgRmTQb');
INSERT INTO NURSE (name, email, password) VALUES ('Justin Morris', 'jameshart@gmail.com', 'NJdgRmTQb');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Michelle Fuller', 'melaniemartin@yahoo.com', 'kMJXsDHpbGFfCwreu');
INSERT INTO NURSE (name, email, password) VALUES ('Michelle Fuller', 'melaniemartin@yahoo.com', 'kMJXsDHpbGFfCwreu');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Paul Jones', 'cole75@yahoo.com', 'zxjZqzjlNmPMBOziu');
INSERT INTO NURSE (name, email, password) VALUES ('Paul Jones', 'cole75@yahoo.com', 'zxjZqzjlNmPMBOziu');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Christina Bullock', 'zbennett@yahoo.com', 'wjGbjLIIOmWCoScvE');
INSERT INTO NURSE (name, email, password) VALUES ('Christina Bullock', 'zbennett@yahoo.com', 'wjGbjLIIOmWCoScvE');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Ronald Swanson', 'diana38@gmail.com', 'JBNBySewqKWy');
INSERT INTO NURSE (name, email, password) VALUES ('Ronald Swanson', 'diana38@gmail.com', 'JBNBySewqKWy');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Daniel Decker', 'kristi08@hotmail.com', 'mtKMxnEQldOE');
INSERT INTO NURSE (name, email, password) VALUES ('Daniel Decker', 'kristi08@hotmail.com', 'mtKMxnEQldOE');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Brandon Keller', 'bradley12@hotmail.com', 'ederbxmKOUGptSt');
INSERT INTO NURSE (name, email, password) VALUES ('Brandon Keller', 'bradley12@hotmail.com', 'ederbxmKOUGptSt');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Karen Smith', 'yblake@yahoo.com', 'TAIJTnGBmxCVF');
INSERT INTO NURSE (name, email, password) VALUES ('Karen Smith', 'yblake@yahoo.com', 'TAIJTnGBmxCVF');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Eric Sanchez', 'ryanlamb@gmail.com', 'jHEUrnwnH');
INSERT INTO NURSE (name, email, password) VALUES ('Eric Sanchez', 'ryanlamb@gmail.com', 'jHEUrnwnH');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Marcus Hicks', 'lisagonzales@hotmail.com', 'pptsyCPqTQnQFn');
INSERT INTO NURSE (name, email, password) VALUES ('Marcus Hicks', 'lisagonzales@hotmail.com', 'pptsyCPqTQnQFn');
INSERT INTO ACCOUNTANT (name, email, password) VALUES ('Paul Brown', 'martinezlaura@gmail.com', 'KGbwdNuZgE');
INSERT INTO NURSE (name, email, password) VALUES ('Paul Brown', 'martinezlaura@gmail.com', 'KGbwdNuZgE');
