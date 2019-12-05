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
  UNIQUE(medical_history)
);

CREATE TABLE ACCOUNTANT(
  acid SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  email varchar(50),
  password Varchar(20),
  PRIMARY KEY(acid)
);

CREATE TABLE SALARY(
  wid SERIAL NOT NULL,
  amount INT NOT NULL,
  payed BOOLEAN NOT NULL,
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
  UNIQUE(adid)
);

CREATE TABLE INVENTORY(
  iid SERIAL NOT NULL,
  name Varchar(100) NOT NULL,
  price INT NOT NULL,
  amount INT NOT NULL,
  amount_paid INT NOT NULL,
  PRIMARY KEY(iid)
);

CREATE TABLE LABORATORY_ASSISTANT (
  aid SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  email Varchar(50) NOT NULL,
  password Varchar(20) NOT NULL,
  PRIMARY KEY(aid)
);

CREATE TABLE SYSTEM_ADMINISTRATOR(
  said SERIAL NOT NULL, 
  name Varchar(50) NOT NULL,
  email Varchar(50) NOT NULL,
  password Varchar(20) NOT NULL,
  PRIMARY KEY(said)
);

CREATE TABLE DOCTOR(
  did SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  speciality Varchar(50) NOT NULL,
  email Varchar(50) NOT NULL,
  password Varchar(20) NOT NULL,
  PRIMARY KEY(did)
);

CREATE TABLE NURSE(
  nid SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  email Varchar(50) NOT NULL,
  password Varchar(20) NOT NULL,
  PRIMARY KEY(nid)
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
  result_file Varchar(50) NOT NULL,
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
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Angela Glover', '+78308361465', '1964-01-08', 'atkinsmatthew@gmail.com', 'Employee today poor away.', '464', 'VbVfEFcvhyJrjupUMEte');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Steven Murphy', '8 (946) 876-1193', '2011-01-31', 'shawnlopez@gmail.com', 'Appear camera against boy court remain.', '276', 'ecEJVdLjuoTRgdCMrh');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Carolyn Harrell', '8 803 184 08 64', '2018-03-04', 'riosjoseph@hotmail.com', 'Design step oil worker project.', '477', 'HGfnfJRZnIntMHYLhjal');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Angela Mason', '8 (342) 884-13-15', '1919-05-25', 'jennifer73@yahoo.com', 'Street range front more head idea.', '235', 'jlzrqquqzTLtaoiXKu');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Brittany Jackson', '8 (322) 994-16-42', '1978-06-10', 'kimberly47@gmail.com', 'That life paper rate understand scientist.', '442', 'YhYoogtBWnsQxK');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Christopher Orozco', '+7 651 710 0154', '2004-12-20', 'ccrosby@yahoo.com', 'Head wide ability fill.', '420', 'gStxjLqeZ');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Mackenzie Davies', '+7 858 310 19 42', '2006-10-17', 'nicholasford@yahoo.com', 'Such total choose term so.', '418', 'ghsEBmsGfTJiQaOHYQ');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Brandy Carter', '+7 122 159 83 36', '1918-12-07', 'mooredorothy@hotmail.com', 'Reality some manage hand onto bit.', '444', 'LCSYWucorlyGUDxa');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Anthony Duncan', '8 538 698 1673', '1943-05-02', 'jermaine26@hotmail.com', 'Light note individual health.', '453', 'LxdVnemQrwTLjhGpzp');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Lydia Perkins', '+7 (886) 644-9133', '1991-01-11', 'mitchellware@yahoo.com', 'Ask husband fall behavior very yes.', '256', 'NiNGulFxJDnjryItObrY');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Sarah Cruz', '+7 000 012 4622', '2008-08-15', 'victoria43@hotmail.com', 'Little car American gas simple read between.', '236', 'KQagjdwUNZtVldPckh');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Matthew Hamilton', '+77733258986', '2015-06-22', 'cathy88@yahoo.com', 'Can hand floor check major tree.', '224', 'qBaEAfYvnVMDtHmmxlp');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Stephanie Ross', '8 (213) 524-45-27', '1954-08-11', 'alicia87@gmail.com', 'Central same minute huge future small bank.', '353', 'uzRRIsoIkxMHcJcpoT');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Sabrina Elliott', '8 (890) 365-11-03', '1938-07-21', 'zmoss@hotmail.com', 'Would before threat cause.', '497', 'CoaxgnhozDQuyUjc');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Angela Burke', '8 (845) 641-19-55', '1935-07-11', 'kelleyjustin@hotmail.com', 'Seat might about resource ability.', '58', 'TvlwzGqLgM');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Stephen Guerra', '+72893520711', '1969-08-06', 'cjefferson@gmail.com', 'Last opportunity consumer agency far.', '146', 'MdVnxxDC');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Daniel Davidson', '+7 419 184 5632', '2008-07-19', 'rogerssandra@yahoo.com', 'Military like author federal.', '315', 'ySiQpGFBojuzSFqxtu');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Ann Bauer', '+7 (874) 194-3869', '2017-09-18', 'evelyn35@hotmail.com', 'Tv collection note. Physical quickly sell toward.', '299', 'wfrBdkyUad');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Sandra Lee', '8 (215) 820-6048', '1999-09-13', 'derekwalters@gmail.com', 'Place kitchen attorney war if American.', '370', 'jtjcgueCf');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Laura Kent', '8 (906) 105-34-44', '2007-12-29', 'derek11@yahoo.com', 'Try around little national fish.', '178', 'YXyeYpVUCAT');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Bonnie Moses', '8 185 884 93 65', '1936-04-06', 'hadams@hotmail.com', 'Apply talk director argue them.', '80', 'GkuCYNaFZhvCk');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Stephen Dean', '8 368 159 23 45', '1947-07-21', 'christopherallen@yahoo.com', 'Will themselves music example growth worry.', '76', 'BcXUXpHrtxGWbDLc');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Keith Dickerson', '+7 660 473 7471', '1938-12-03', 'lmason@gmail.com', 'Onto drug major perhaps know after only grow.', '69', 'sxkcvQpHQWWDopzcKorQ');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Todd Johnson', '+7 910 437 07 37', '1991-10-27', 'graycharles@gmail.com', 'Popular worry number wind church become.', '178', 'ZaHkgKtVfkTfZHM');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Jamie Frederick', '8 023 002 8263', '1959-07-10', 'william83@hotmail.com', 'Person draw Mrs spring explain have.', '6', 'xkjmkXcsdE');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Mrs. Lynn Robinson', '+7 031 441 77 61', '1923-07-07', 'jonathan34@yahoo.com', 'Bad while end blue well change investment argue.', '260', 'AsPgGmOtOQnXbUR');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Michael Craig', '+79566668820', '2003-02-15', 'ambergarcia@yahoo.com', 'Include century between prevent to.', '23', 'XNcXkuVfIbxv');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Anna Thomas', '+7 (353) 720-91-27', '1986-09-04', 'ymartin@yahoo.com', 'People we whole writer wrong.', '57', 'XEQuikuD');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Barbara Johnson', '+7 775 133 28 93', '1952-12-21', 'maryfoster@yahoo.com', 'Goal land once name stop full level.', '428', 'mUTROaLtHelhusT');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Jose Marshall', '+7 564 917 70 36', '1909-06-11', 'mclaughlinlatoya@yahoo.com', 'Article firm method. At consumer machine score.', '429', 'KjbdCTKyRg');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Pamela Thompson', '+7 (133) 316-0637', '1974-05-03', 'rjones@yahoo.com', 'Follow international loss.', '427', 'gRqUGsOHESl');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Tyler Estrada', '8 366 525 3576', '1981-07-04', 'kthomas@hotmail.com', 'Not official focus best success whose meet.', '77', 'OvEpnVJPDFnNTk');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('John Ware', '+71012907725', '1926-05-23', 'alicia34@yahoo.com', 'Woman while want edge interesting without.', '320', 'JSWRZFwaDdDWyv');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Tricia Ewing', '8 922 557 34 12', '1909-02-06', 'johnwolf@gmail.com', 'Would technology happy her loss.', '348', 'GzsBbhsfkYPLXCVDPaq');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Steve Brown', '8 (075) 644-74-20', '2010-07-07', 'elizabeth81@gmail.com', 'Would activity factor couple stand before these.', '89', 'edqSLUmpOmufAGpmD');
INSERT INTO accountant (name, email, password) VALUES ('Angela Glover', 'atkinsmatthew@gmail.com', 'VbVfEFcvhyJrjupUMEte');
INSERT INTO accountant (name, email, password) VALUES ('Steven Murphy', 'shawnlopez@gmail.com', 'ecEJVdLjuoTRgdCMrh');
INSERT INTO accountant (name, email, password) VALUES ('Carolyn Harrell', 'riosjoseph@hotmail.com', 'HGfnfJRZnIntMHYLhjal');
INSERT INTO accountant (name, email, password) VALUES ('Angela Mason', 'jennifer73@yahoo.com', 'jlzrqquqzTLtaoiXKu');
INSERT INTO accountant (name, email, password) VALUES ('Brittany Jackson', 'kimberly47@gmail.com', 'YhYoogtBWnsQxK');
INSERT INTO accountant (name, email, password) VALUES ('Christopher Orozco', 'ccrosby@yahoo.com', 'gStxjLqeZ');
INSERT INTO accountant (name, email, password) VALUES ('Mackenzie Davies', 'nicholasford@yahoo.com', 'ghsEBmsGfTJiQaOHYQ');
INSERT INTO accountant (name, email, password) VALUES ('Brandy Carter', 'mooredorothy@hotmail.com', 'LCSYWucorlyGUDxa');
INSERT INTO accountant (name, email, password) VALUES ('Anthony Duncan', 'jermaine26@hotmail.com', 'LxdVnemQrwTLjhGpzp');
INSERT INTO accountant (name, email, password) VALUES ('Lydia Perkins', 'mitchellware@yahoo.com', 'NiNGulFxJDnjryItObrY');
INSERT INTO accountant (name, email, password) VALUES ('Sarah Cruz', 'victoria43@hotmail.com', 'KQagjdwUNZtVldPckh');
INSERT INTO accountant (name, email, password) VALUES ('Matthew Hamilton', 'cathy88@yahoo.com', 'qBaEAfYvnVMDtHmmxlp');
INSERT INTO accountant (name, email, password) VALUES ('Stephanie Ross', 'alicia87@gmail.com', 'uzRRIsoIkxMHcJcpoT');
INSERT INTO accountant (name, email, password) VALUES ('Sabrina Elliott', 'zmoss@hotmail.com', 'CoaxgnhozDQuyUjc');
INSERT INTO accountant (name, email, password) VALUES ('Angela Burke', 'kelleyjustin@hotmail.com', 'TvlwzGqLgM');
INSERT INTO accountant (name, email, password) VALUES ('Stephen Guerra', 'cjefferson@gmail.com', 'MdVnxxDC');
INSERT INTO accountant (name, email, password) VALUES ('Daniel Davidson', 'rogerssandra@yahoo.com', 'ySiQpGFBojuzSFqxtu');
INSERT INTO accountant (name, email, password) VALUES ('Ann Bauer', 'evelyn35@hotmail.com', 'wfrBdkyUad');
INSERT INTO accountant (name, email, password) VALUES ('Sandra Lee', 'derekwalters@gmail.com', 'jtjcgueCf');
INSERT INTO accountant (name, email, password) VALUES ('Laura Kent', 'derek11@yahoo.com', 'YXyeYpVUCAT');
INSERT INTO accountant (name, email, password) VALUES ('Bonnie Moses', 'hadams@hotmail.com', 'GkuCYNaFZhvCk');
INSERT INTO accountant (name, email, password) VALUES ('Stephen Dean', 'christopherallen@yahoo.com', 'BcXUXpHrtxGWbDLc');
INSERT INTO accountant (name, email, password) VALUES ('Keith Dickerson', 'lmason@gmail.com', 'sxkcvQpHQWWDopzcKorQ');
INSERT INTO accountant (name, email, password) VALUES ('Todd Johnson', 'graycharles@gmail.com', 'ZaHkgKtVfkTfZHM');
INSERT INTO accountant (name, email, password) VALUES ('Jamie Frederick', 'william83@hotmail.com', 'xkjmkXcsdE');
INSERT INTO accountant (name, email, password) VALUES ('Mrs. Lynn Robinson', 'jonathan34@yahoo.com', 'AsPgGmOtOQnXbUR');
INSERT INTO accountant (name, email, password) VALUES ('Michael Craig', 'ambergarcia@yahoo.com', 'XNcXkuVfIbxv');
INSERT INTO accountant (name, email, password) VALUES ('Anna Thomas', 'ymartin@yahoo.com', 'XEQuikuD');
INSERT INTO accountant (name, email, password) VALUES ('Barbara Johnson', 'maryfoster@yahoo.com', 'mUTROaLtHelhusT');
INSERT INTO accountant (name, email, password) VALUES ('Jose Marshall', 'mclaughlinlatoya@yahoo.com', 'KjbdCTKyRg');
INSERT INTO accountant (name, email, password) VALUES ('Pamela Thompson', 'rjones@yahoo.com', 'gRqUGsOHESl');
INSERT INTO accountant (name, email, password) VALUES ('Tyler Estrada', 'kthomas@hotmail.com', 'OvEpnVJPDFnNTk');
INSERT INTO accountant (name, email, password) VALUES ('John Ware', 'alicia34@yahoo.com', 'JSWRZFwaDdDWyv');
INSERT INTO accountant (name, email, password) VALUES ('Tricia Ewing', 'johnwolf@gmail.com', 'GzsBbhsfkYPLXCVDPaq');
INSERT INTO accountant (name, email, password) VALUES ('Steve Brown', 'elizabeth81@gmail.com', 'edqSLUmpOmufAGpmD');
INSERT INTO accountant (name, email, password) VALUES ('Kristina Stevens', 'douglas05@yahoo.com', 'JVuVzQtplLY');
INSERT INTO accountant (name, email, password) VALUES ('Debra Barker', 'ithomas@gmail.com', 'wrrEePPqu');
INSERT INTO accountant (name, email, password) VALUES ('Kyle Vang', 'wcummings@gmail.com', 'tQfdFdeZBM');
INSERT INTO accountant (name, email, password) VALUES ('Linda Bass', 'danieljones@hotmail.com', 'BTpMdwBgIBXzfdvRuy');
INSERT INTO accountant (name, email, password) VALUES ('Benjamin Mcintosh', 'ygriffin@gmail.com', 'UvJrFupmTpKlyEndmJi');
INSERT INTO accountant (name, email, password) VALUES ('Suzanne Pollard', 'qcervantes@gmail.com', 'vAnHKLnswKbIjz');
INSERT INTO accountant (name, email, password) VALUES ('Jeremy Rodriguez', 'combsmatthew@hotmail.com', 'cyoYWEgNrUMyJiASVA');
INSERT INTO accountant (name, email, password) VALUES ('Annette Potts', 'jonesrebecca@gmail.com', 'NoVfKgkPVMNK');
INSERT INTO accountant (name, email, password) VALUES ('Patricia Hernandez', 'annevelasquez@gmail.com', 'PVaPrKLdvIqYvTA');
INSERT INTO accountant (name, email, password) VALUES ('Andrew Weaver', 'collinsmichael@hotmail.com', 'deoTFVxv');
INSERT INTO accountant (name, email, password) VALUES ('Denise Moore', 'patricianichols@gmail.com', 'PrzsHrqMImcD');
INSERT INTO accountant (name, email, password) VALUES ('Sarah Patel', 'melissafriedman@hotmail.com', 'NqIiKgyiXwg');
INSERT INTO accountant (name, email, password) VALUES ('Tammy Hanson', 'zachary92@gmail.com', 'cOyjZvXga');
INSERT INTO accountant (name, email, password) VALUES ('Erin Washington', 'aprilwilson@gmail.com', 'AAhqYNaGEU');
INSERT INTO accountant (name, email, password) VALUES ('David Nelson', 'xstrickland@hotmail.com', 'PxvsWLOYAMQuEWJ');
INSERT INTO accountant (name, email, password) VALUES ('Patricia Gray', 'matthew05@gmail.com', 'oSMUCfJAZr');
INSERT INTO accountant (name, email, password) VALUES ('Linda Mueller', 'davidsmith@yahoo.com', 'WHcsEhLSmgAbHqchuKN');
INSERT INTO accountant (name, email, password) VALUES ('Rachel Price', 'walleraustin@hotmail.com', 'ROmFVdtVteAm');
INSERT INTO accountant (name, email, password) VALUES ('Donald Figueroa', 'kmorales@hotmail.com', 'GWuTHuGsaImoJIz');
INSERT INTO accountant (name, email, password) VALUES ('Mark Davis', 'victoria13@hotmail.com', 'YekDJdrPL');
INSERT INTO accountant (name, email, password) VALUES ('Richard Mitchell', 'phillipsmichelle@gmail.com', 'ZvpPhTsDxFSdauMZxlLr');
INSERT INTO accountant (name, email, password) VALUES ('Stephanie Chambers', 'timothy93@gmail.com', 'cEqfCqomRKXMbFMUN');
INSERT INTO accountant (name, email, password) VALUES ('Scott Rogers', 'johnrangel@gmail.com', 'CYYQtPEfGdTXRAulbb');
INSERT INTO accountant (name, email, password) VALUES ('Elizabeth Soto', 'charles39@gmail.com', 'pcFCJslhVjv');
INSERT INTO accountant (name, email, password) VALUES ('Pamela Smith', 'iwoodard@gmail.com', 'zBhHKmYOQeMwDNmKRRQ');
INSERT INTO accountant (name, email, password) VALUES ('Jonathan Moore', 'jasminewebb@gmail.com', 'BDUcGQBUebEz');
INSERT INTO accountant (name, email, password) VALUES ('Darrell Williams', 'rwilliams@gmail.com', 'HAdRLKhpdFIGIcl');
INSERT INTO accountant (name, email, password) VALUES ('Michael Walker', 'adamsandrew@gmail.com', 'KKtDDVyLWlnNIOklMAEm');
INSERT INTO accountant (name, email, password) VALUES ('Kirk Wilson', 'zunigamatthew@yahoo.com', 'ViQegUPLhOVAzFfq');
INSERT INTO accountant (name, email, password) VALUES ('Christopher Payne', 'laurie26@hotmail.com', 'PZBXnPsVZfzKkf');
INSERT INTO accountant (name, email, password) VALUES ('Blake Moore', 'alexander98@hotmail.com', 'YYAnwliXjL');
INSERT INTO accountant (name, email, password) VALUES ('Ms. Nicole Williams', 'graykaylee@hotmail.com', 'udolBXdPXcGHiSabdBdq');
INSERT INTO accountant (name, email, password) VALUES ('Matthew Rogers', 'leslie21@yahoo.com', 'bWneqddNEFkTJiZyhqML');
INSERT INTO accountant (name, email, password) VALUES ('Shirley Garcia', 'jmiller@hotmail.com', 'ALXbEbTRSKZbonGdITu');
INSERT INTO accountant (name, email, password) VALUES ('Kerry Giles', 'paula42@yahoo.com', 'QQbEkRGttOuN');
INSERT INTO accountant (name, email, password) VALUES ('Nathaniel Lawrence', 'vbradley@gmail.com', 'IGvrKnNYLsfgpmZRG');
INSERT INTO accountant (name, email, password) VALUES ('Maria Mcclure', 'robinsoncourtney@gmail.com', 'DXMDrStSMzQcqRY');
INSERT INTO hospital_administrator (name, email, password) VALUES ('Kristina Stevens', 'douglas05@yahoo.com', 'JVuVzQtplLY');
INSERT INTO hospital_administrator (name, email, password) VALUES ('Debra Barker', 'ithomas@gmail.com', 'wrrEePPqu');
INSERT INTO hospital_administrator (name, email, password) VALUES ('Kyle Vang', 'wcummings@gmail.com', 'tQfdFdeZBM');
INSERT INTO laboratory_assistant (name, email, password) VALUES ('Linda Bass', 'danieljones@hotmail.com', 'BTpMdwBgIBXzfdvRuy');
INSERT INTO laboratory_assistant (name, email, password) VALUES ('Benjamin Mcintosh', 'ygriffin@gmail.com', 'UvJrFupmTpKlyEndmJi');
INSERT INTO laboratory_assistant (name, email, password) VALUES ('Suzanne Pollard', 'qcervantes@gmail.com', 'vAnHKLnswKbIjz');
INSERT INTO laboratory_assistant (name, email, password) VALUES ('Jeremy Rodriguez', 'combsmatthew@hotmail.com', 'cyoYWEgNrUMyJiASVA');
INSERT INTO laboratory_assistant (name, email, password) VALUES ('Annette Potts', 'jonesrebecca@gmail.com', 'NoVfKgkPVMNK');
INSERT INTO system_administrator (name, email, password) VALUES ('Patricia Hernandez', 'annevelasquez@gmail.com', 'PVaPrKLdvIqYvTA');
INSERT INTO system_administrator (name, email, password) VALUES ('Andrew Weaver', 'collinsmichael@hotmail.com', 'deoTFVxv');
INSERT INTO system_administrator (name, email, password) VALUES ('Denise Moore', 'patricianichols@gmail.com', 'PrzsHrqMImcD');
INSERT INTO system_administrator (name, email, password) VALUES ('Sarah Patel', 'melissafriedman@hotmail.com', 'NqIiKgyiXwg');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Tammy Hanson', 'zachary92@gmail.com', 'cOyjZvXga', 'family medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Erin Washington', 'aprilwilson@gmail.com', 'AAhqYNaGEU', 'family medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('David Nelson', 'xstrickland@hotmail.com', 'PxvsWLOYAMQuEWJ', 'family medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Patricia Gray', 'matthew05@gmail.com', 'oSMUCfJAZr', 'neurology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Linda Mueller', 'davidsmith@yahoo.com', 'WHcsEhLSmgAbHqchuKN', 'emergency medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Rachel Price', 'walleraustin@hotmail.com', 'ROmFVdtVteAm', 'pediatrics');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Donald Figueroa', 'kmorales@hotmail.com', 'GWuTHuGsaImoJIz', 'dermatology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Mark Davis', 'victoria13@hotmail.com', 'YekDJdrPL', 'pediatrics');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Richard Mitchell', 'phillipsmichelle@gmail.com', 'ZvpPhTsDxFSdauMZxlLr', 'diagnostic radiology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Stephanie Chambers', 'timothy93@gmail.com', 'cEqfCqomRKXMbFMUN', 'pediatrics');
INSERT INTO nurse (name, email, password) VALUES ('Scott Rogers', 'johnrangel@gmail.com', 'CYYQtPEfGdTXRAulbb');
INSERT INTO nurse (name, email, password) VALUES ('Elizabeth Soto', 'charles39@gmail.com', 'pcFCJslhVjv');
INSERT INTO nurse (name, email, password) VALUES ('Pamela Smith', 'iwoodard@gmail.com', 'zBhHKmYOQeMwDNmKRRQ');
INSERT INTO nurse (name, email, password) VALUES ('Jonathan Moore', 'jasminewebb@gmail.com', 'BDUcGQBUebEz');
INSERT INTO nurse (name, email, password) VALUES ('Darrell Williams', 'rwilliams@gmail.com', 'HAdRLKhpdFIGIcl');
INSERT INTO nurse (name, email, password) VALUES ('Michael Walker', 'adamsandrew@gmail.com', 'KKtDDVyLWlnNIOklMAEm');
INSERT INTO nurse (name, email, password) VALUES ('Kirk Wilson', 'zunigamatthew@yahoo.com', 'ViQegUPLhOVAzFfq');
INSERT INTO nurse (name, email, password) VALUES ('Christopher Payne', 'laurie26@hotmail.com', 'PZBXnPsVZfzKkf');
INSERT INTO nurse (name, email, password) VALUES ('Blake Moore', 'alexander98@hotmail.com', 'YYAnwliXjL');
INSERT INTO nurse (name, email, password) VALUES ('Ms. Nicole Williams', 'graykaylee@hotmail.com', 'udolBXdPXcGHiSabdBdq');
INSERT INTO nurse (name, email, password) VALUES ('Matthew Rogers', 'leslie21@yahoo.com', 'bWneqddNEFkTJiZyhqML');
INSERT INTO nurse (name, email, password) VALUES ('Shirley Garcia', 'jmiller@hotmail.com', 'ALXbEbTRSKZbonGdITu');
INSERT INTO nurse (name, email, password) VALUES ('Kerry Giles', 'paula42@yahoo.com', 'QQbEkRGttOuN');
INSERT INTO nurse (name, email, password) VALUES ('Nathaniel Lawrence', 'vbradley@gmail.com', 'IGvrKnNYLsfgpmZRG');
INSERT INTO nurse (name, email, password) VALUES ('Maria Mcclure', 'robinsoncourtney@gmail.com', 'DXMDrStSMzQcqRY');
