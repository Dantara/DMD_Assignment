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
  receipt Varchar(100),
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
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Philip Taylor', '+7 739 841 90 12', '1946-12-30', 'tbradford@hotmail.com', 'Change little opportunity walk.', '22', 'pKSMfDKZRsopZeHztlya');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Terry Garcia', '8 (417) 533-17-79', '1999-06-06', 'boyerkyle@yahoo.com', 'Against happen describe cell.', '288', 'ngPkaMEK');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Sandra Wilson', '+7 082 853 12 66', '1953-05-18', 'collierevan@hotmail.com', 'Above structure leg general office environment.', '203', 'UrxEQfLtAomAIU');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Mary Martin', '+7 265 512 91 46', '2014-09-01', 'brianskinner@hotmail.com', 'Sell until executive change read in.', '371', 'BTNmGlOtyRPWxuSZ');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Anita Murray', '+7 (720) 120-45-64', '2010-02-11', 'harveyelizabeth@yahoo.com', 'Live blue quite better find we.', '139', 'xvifTncbxchIqhU');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Rebecca Madden', '8 564 630 10 33', '1970-06-24', 'uhall@hotmail.com', 'Development board rest professional back.', '315', 'WtMpuhnAaDa');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Tyrone Massey', '+73682787061', '2014-03-11', 'wwright@hotmail.com', 'Field those course decade still act place.', '375', 'gAIOxYojbGTBO');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Eric Moore', '+7 302 881 80 11', '1970-07-27', 'latasha66@hotmail.com', 'Still range prove sense identify stage choose.', '14', 'mUwzwRfvgg');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('David Ortega', '+7 (716) 883-7186', '1939-02-09', 'fred94@gmail.com', 'Prepare call almost course film.', '473', 'mGVTDACzsEPlyHP');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Kelly Watts', '+71985212186', '1928-10-18', 'gchristensen@hotmail.com', 'Bill bag shake tax third mean.', '332', 'DXKsIaBVBlxLZwzg');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Karen Jones', '+7 (208) 734-14-10', '1918-08-26', 'graceadams@gmail.com', 'For best tonight in seven several point.', '311', 'nTmTuKFihZwDgPSzc');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Christopher Torres', '+7 101 724 32 54', '1948-07-23', 'medwards@hotmail.com', 'Call generation blue wife word way.', '401', 'NTlrpOsrNcXLk');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Ronald Campbell', '8 383 638 7144', '2011-02-16', 'kathleen59@yahoo.com', 'Whole subject dinner difference usually allow.', '54', 'RLDeCyYyciWJqTIh');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Samantha Conley', '83607518898', '2002-08-01', 'stephanie09@gmail.com', 'Phone political first result.', '104', 'hBOnDqipzNCJBOIKMEi');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Theodore Turner', '81132134263', '1986-03-12', 'moniquepowers@yahoo.com', 'Experience once nothing.', '182', 'MRqoYqygtNueDI');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Rebecca Hines', '8 907 645 7290', '1914-01-21', 'nicholsonrodney@yahoo.com', 'Agent camera hard large station.', '181', 'FvHEkYIDuNjEsX');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Aimee Clark', '8 977 760 5502', '1964-10-03', 'foxkatrina@hotmail.com', 'Eat land staff allow program drug stand.', '446', 'doOxEBUCAZSRDhlWw');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Steven Rogers', '+7 (811) 250-97-01', '1904-01-10', 'ramireztaylor@yahoo.com', 'Go place far lay than keep.', '100', 'qejtIKOdzTZHr');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Jesse Santiago', '+7 (103) 151-19-40', '1991-02-21', 'goodmanjohn@hotmail.com', 'Fish so he coach front bit support.', '159', 'QYscLABS');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Joshua Howell', '8 242 966 1774', '1959-05-20', 'michellemurray@gmail.com', 'Lead young town paper. Rule team decide agent.', '383', 'lWBLHCxxE');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Shannon Nixon', '8 612 220 5878', '1960-03-28', 'robin54@gmail.com', 'Eight avoid direction help off offer.', '101', 'HBrgVbAHpOadUtg');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Leslie Brewer', '8 (685) 915-98-88', '1964-05-29', 'derek77@gmail.com', 'World factor hotel case message both.', '455', 'zdWplQVpBaXkDU');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Richard Romero', '+7 (212) 415-45-46', '1933-11-23', 'rlewis@hotmail.com', 'Call so decide mouth.', '308', 'eEXLJFbKYeeJPEDZLzq');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Nathan Warren', '8 935 520 2843', '1972-07-30', 'rodriguezkyle@yahoo.com', 'Yeah about four light century. What per local.', '386', 'XNyLimBMvlzfoVGw');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Cynthia Rodriguez', '+7 925 835 1141', '2019-11-20', 'collinsashley@yahoo.com', 'World environmental tell item represent.', '402', 'XojqjNqvXblGmaJlyvC');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Zachary Smith', '+7 923 235 05 27', '2017-06-07', 'crawfordsean@gmail.com', 'Perform day same message.', '404', 'qPfDxkHvpaIr');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Craig Woods', '82278638774', '1939-10-10', 'tmcpherson@yahoo.com', 'Customer Democrat particular fact finally.', '193', 'NKPnxJJs');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Linda Jones', '8 (612) 155-1763', '1935-11-25', 'tanyaalvarez@gmail.com', 'Than change condition win.', '69', 'fpHanDZTVPFiFILtOkI');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Chad Weber', '8 604 883 6603', '1916-04-20', 'davidmiller@hotmail.com', 'Summer also interest. Look play able.', '478', 'UqrREqSfEOZ');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Karen Morales', '8 (110) 709-8609', '1906-07-31', 'brownpeter@gmail.com', 'Live store fill meet. Travel top bar.', '59', 'ABADPzIeaz');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Jennifer Henry', '+7 411 023 55 73', '1922-06-17', 'amanda15@gmail.com', 'Class story rich throughout.', '54', 'MecRQWlgDwVf');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Lindsay Wagner', '+7 (843) 128-7393', '2009-12-31', 'jillroman@gmail.com', 'Wife gas why record.', '419', 'teXlYQtgJb');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Justin Torres', '+7 (157) 917-05-23', '1960-11-14', 'gregoryhenry@gmail.com', 'Gun effect find unit. Join choose nearly.', '294', 'LpKxGjqzRmSRStdygngH');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Richard Martinez', '+7 (488) 419-2016', '2015-12-08', 'averyjames@yahoo.com', 'Coach far medical statement chair art.', '197', 'DwFEfkxGRqSIluUVkvj');
INSERT INTO patient (name, phone_number, date_of_birth, email, medical_history, room_number, password) VALUES ('Kristin Escobar', '+7 (188) 720-69-64', '1915-04-15', 'nicolechang@yahoo.com', 'Third address purpose lose along news.', '65', 'ZPszlTEkp');
INSERT INTO accountant (name, email, password) VALUES ('Philip Taylor', 'tbradford@hotmail.com', 'pKSMfDKZRsopZeHztlya');
INSERT INTO accountant (name, email, password) VALUES ('Terry Garcia', 'boyerkyle@yahoo.com', 'ngPkaMEK');
INSERT INTO accountant (name, email, password) VALUES ('Sandra Wilson', 'collierevan@hotmail.com', 'UrxEQfLtAomAIU');
INSERT INTO accountant (name, email, password) VALUES ('Mary Martin', 'brianskinner@hotmail.com', 'BTNmGlOtyRPWxuSZ');
INSERT INTO accountant (name, email, password) VALUES ('Anita Murray', 'harveyelizabeth@yahoo.com', 'xvifTncbxchIqhU');
INSERT INTO accountant (name, email, password) VALUES ('Rebecca Madden', 'uhall@hotmail.com', 'WtMpuhnAaDa');
INSERT INTO accountant (name, email, password) VALUES ('Tyrone Massey', 'wwright@hotmail.com', 'gAIOxYojbGTBO');
INSERT INTO accountant (name, email, password) VALUES ('Eric Moore', 'latasha66@hotmail.com', 'mUwzwRfvgg');
INSERT INTO accountant (name, email, password) VALUES ('David Ortega', 'fred94@gmail.com', 'mGVTDACzsEPlyHP');
INSERT INTO accountant (name, email, password) VALUES ('Kelly Watts', 'gchristensen@hotmail.com', 'DXKsIaBVBlxLZwzg');
INSERT INTO accountant (name, email, password) VALUES ('Karen Jones', 'graceadams@gmail.com', 'nTmTuKFihZwDgPSzc');
INSERT INTO accountant (name, email, password) VALUES ('Christopher Torres', 'medwards@hotmail.com', 'NTlrpOsrNcXLk');
INSERT INTO accountant (name, email, password) VALUES ('Ronald Campbell', 'kathleen59@yahoo.com', 'RLDeCyYyciWJqTIh');
INSERT INTO accountant (name, email, password) VALUES ('Samantha Conley', 'stephanie09@gmail.com', 'hBOnDqipzNCJBOIKMEi');
INSERT INTO accountant (name, email, password) VALUES ('Theodore Turner', 'moniquepowers@yahoo.com', 'MRqoYqygtNueDI');
INSERT INTO accountant (name, email, password) VALUES ('Rebecca Hines', 'nicholsonrodney@yahoo.com', 'FvHEkYIDuNjEsX');
INSERT INTO accountant (name, email, password) VALUES ('Aimee Clark', 'foxkatrina@hotmail.com', 'doOxEBUCAZSRDhlWw');
INSERT INTO accountant (name, email, password) VALUES ('Steven Rogers', 'ramireztaylor@yahoo.com', 'qejtIKOdzTZHr');
INSERT INTO accountant (name, email, password) VALUES ('Jesse Santiago', 'goodmanjohn@hotmail.com', 'QYscLABS');
INSERT INTO accountant (name, email, password) VALUES ('Joshua Howell', 'michellemurray@gmail.com', 'lWBLHCxxE');
INSERT INTO accountant (name, email, password) VALUES ('Shannon Nixon', 'robin54@gmail.com', 'HBrgVbAHpOadUtg');
INSERT INTO accountant (name, email, password) VALUES ('Leslie Brewer', 'derek77@gmail.com', 'zdWplQVpBaXkDU');
INSERT INTO accountant (name, email, password) VALUES ('Richard Romero', 'rlewis@hotmail.com', 'eEXLJFbKYeeJPEDZLzq');
INSERT INTO accountant (name, email, password) VALUES ('Nathan Warren', 'rodriguezkyle@yahoo.com', 'XNyLimBMvlzfoVGw');
INSERT INTO accountant (name, email, password) VALUES ('Cynthia Rodriguez', 'collinsashley@yahoo.com', 'XojqjNqvXblGmaJlyvC');
INSERT INTO accountant (name, email, password) VALUES ('Zachary Smith', 'crawfordsean@gmail.com', 'qPfDxkHvpaIr');
INSERT INTO accountant (name, email, password) VALUES ('Craig Woods', 'tmcpherson@yahoo.com', 'NKPnxJJs');
INSERT INTO accountant (name, email, password) VALUES ('Linda Jones', 'tanyaalvarez@gmail.com', 'fpHanDZTVPFiFILtOkI');
INSERT INTO accountant (name, email, password) VALUES ('Chad Weber', 'davidmiller@hotmail.com', 'UqrREqSfEOZ');
INSERT INTO accountant (name, email, password) VALUES ('Karen Morales', 'brownpeter@gmail.com', 'ABADPzIeaz');
INSERT INTO accountant (name, email, password) VALUES ('Jennifer Henry', 'amanda15@gmail.com', 'MecRQWlgDwVf');
INSERT INTO accountant (name, email, password) VALUES ('Lindsay Wagner', 'jillroman@gmail.com', 'teXlYQtgJb');
INSERT INTO accountant (name, email, password) VALUES ('Justin Torres', 'gregoryhenry@gmail.com', 'LpKxGjqzRmSRStdygngH');
INSERT INTO accountant (name, email, password) VALUES ('Richard Martinez', 'averyjames@yahoo.com', 'DwFEfkxGRqSIluUVkvj');
INSERT INTO accountant (name, email, password) VALUES ('Kristin Escobar', 'nicolechang@yahoo.com', 'ZPszlTEkp');
INSERT INTO accountant (name, email, password) VALUES ('Hunter Gardner', 'johnnyward@yahoo.com', 'wmMmwsLbwZWoKTL');
INSERT INTO accountant (name, email, password) VALUES ('Jordan Williams', 'julie23@gmail.com', 'rXikPeBvzPCM');
INSERT INTO accountant (name, email, password) VALUES ('Julie Jones', 'mfranklin@gmail.com', 'hUILNgQwgWKC');
INSERT INTO accountant (name, email, password) VALUES ('Angela Booth', 'mark27@hotmail.com', 'EDATjfQBHMH');
INSERT INTO accountant (name, email, password) VALUES ('Michael Klein', 'henryturner@gmail.com', 'RIQSJxGAemnfidDBgbr');
INSERT INTO accountant (name, email, password) VALUES ('Katherine Mendoza', 'gabriel87@hotmail.com', 'pAKoXATtGeh');
INSERT INTO accountant (name, email, password) VALUES ('Isaiah Mercado', 'linda70@gmail.com', 'LJhsvMVK');
INSERT INTO accountant (name, email, password) VALUES ('Jennifer Wright', 'castrodaniel@yahoo.com', 'MUwpyQHkHVocR');
INSERT INTO accountant (name, email, password) VALUES ('Kayla Taylor', 'leejohn@hotmail.com', 'XGSXIlQVLTyY');
INSERT INTO accountant (name, email, password) VALUES ('Adam Owens', 'hallgeorge@hotmail.com', 'tTrBoKMwitqoIg');
INSERT INTO accountant (name, email, password) VALUES ('Matthew Burnett', 'colonrichard@yahoo.com', 'PRAXHOxNFjuBTLREsg');
INSERT INTO accountant (name, email, password) VALUES ('Amanda Watts', 'houstonaaron@gmail.com', 'FrodXQonFs');
INSERT INTO accountant (name, email, password) VALUES ('Paul Flores', 'pooleamanda@yahoo.com', 'zsgYgTOBYsI');
INSERT INTO accountant (name, email, password) VALUES ('Pamela Levine', 'chasejensen@yahoo.com', 'MSCppYIjWGRmEl');
INSERT INTO accountant (name, email, password) VALUES ('Nancy Mendoza', 'ftyler@yahoo.com', 'AYexWrAmxMMltbOUgQLS');
INSERT INTO accountant (name, email, password) VALUES ('Gail Wilson', 'johnsonscott@hotmail.com', 'YeqSyzNjddlGMO');
INSERT INTO accountant (name, email, password) VALUES ('Derrick Rowe', 'john79@yahoo.com', 'GUYmkoPykwVB');
INSERT INTO accountant (name, email, password) VALUES ('Oscar Gonzalez', 'deborah12@gmail.com', 'mtjFGFDpYPslaN');
INSERT INTO accountant (name, email, password) VALUES ('Antonio Morales', 'xtanner@yahoo.com', 'xPKXQEeyWDBTH');
INSERT INTO accountant (name, email, password) VALUES ('Erin Goodman', 'pgarcia@gmail.com', 'AeOamTcFZ');
INSERT INTO accountant (name, email, password) VALUES ('Jennifer Brown', 'nwilliams@hotmail.com', 'qiVDuMgTnDJbxW');
INSERT INTO accountant (name, email, password) VALUES ('Katrina Soto', 'chavezregina@yahoo.com', 'rNeZDtBLvL');
INSERT INTO accountant (name, email, password) VALUES ('Miss Christina Atkins', 'bford@yahoo.com', 'IjgVGypQT');
INSERT INTO accountant (name, email, password) VALUES ('Katelyn Pratt', 'smithwilliam@gmail.com', 'PdIDpycWsiaXZMHCnnQe');
INSERT INTO accountant (name, email, password) VALUES ('Laura Knight', 'taylor05@hotmail.com', 'PWwsgCWXeWBScVZONc');
INSERT INTO accountant (name, email, password) VALUES ('Crystal Perry', 'frankwright@yahoo.com', 'vaPxhqszStqWeMmUVnC');
INSERT INTO accountant (name, email, password) VALUES ('David Parker', 'jessetran@hotmail.com', 'dliqXMQfmzz');
INSERT INTO accountant (name, email, password) VALUES ('Todd Lane', 'morabrooke@gmail.com', 'LjRxfVucFD');
INSERT INTO accountant (name, email, password) VALUES ('Janet Whitaker', 'njohnson@yahoo.com', 'jqPMgGOvjWSjW');
INSERT INTO accountant (name, email, password) VALUES ('Emily Crawford', 'heathgreg@gmail.com', 'EjWdnBnp');
INSERT INTO accountant (name, email, password) VALUES ('Nicole West', 'lewismark@yahoo.com', 'yltqajDuzCbSD');
INSERT INTO accountant (name, email, password) VALUES ('Nancy Duncan', 'anthonylawson@gmail.com', 'jLEzXuDcWkhmafZmFOqO');
INSERT INTO accountant (name, email, password) VALUES ('Randall Martin', 'sarahkeller@gmail.com', 'IbOTjjIBmMNWDyQnte');
INSERT INTO accountant (name, email, password) VALUES ('Jeremy Bentley', 'ebony33@yahoo.com', 'XNbqrxedVQixvHgmMu');
INSERT INTO accountant (name, email, password) VALUES ('Darrell Finley', 'carrollpatrick@gmail.com', 'UpNRpAISNGtYoQ');
INSERT INTO accountant (name, email, password) VALUES ('Sean Moore', 'fthomas@yahoo.com', 'qRtmBObIavzpsOAekhhf');
INSERT INTO accountant (name, email, password) VALUES ('Ronald Holloway', 'marshallmelissa@hotmail.com', 'mMbquMjrmSuWGUfK');
INSERT INTO accountant (name, email, password) VALUES ('Julie Jones', 'changanne@yahoo.com', 'KwYMAvHSZgBG');
INSERT INTO accountant (name, email, password) VALUES ('Nicole Johnson', 'joannamartinez@gmail.com', 'FiCGfLKoV');
INSERT INTO accountant (name, email, password) VALUES ('James Alexander', 'dylanroberts@hotmail.com', 'XzgBJMjLUfuoWCLv');
INSERT INTO accountant (name, email, password) VALUES ('David Davis', 'zcrawford@hotmail.com', 'gJqndZGXPKIkfRI');
INSERT INTO accountant (name, email, password) VALUES ('Timothy Whitehead', 'bradley63@gmail.com', 'lhZsNsPqHTpfefaLcBh');
INSERT INTO accountant (name, email, password) VALUES ('Jill Curtis', 'lwilliams@gmail.com', 'rLOdnOJYJbyVNYLrE');
INSERT INTO accountant (name, email, password) VALUES ('Stephanie Robinson', 'dmiles@yahoo.com', 'JZsXtouy');
INSERT INTO accountant (name, email, password) VALUES ('Todd Charles', 'qdavenport@yahoo.com', 'NLQtQacCcage');
INSERT INTO accountant (name, email, password) VALUES ('Molly Wall', 'chris25@yahoo.com', 'KmxRcrlgFpKhA');
INSERT INTO accountant (name, email, password) VALUES ('Gregory Campbell', 'martinbird@yahoo.com', 'JpqmvufzKzNI');
INSERT INTO accountant (name, email, password) VALUES ('Sean Ramos', 'sporter@gmail.com', 'SlhlWvXnlvf');
INSERT INTO accountant (name, email, password) VALUES ('Zachary Conrad', 'hannahgibson@yahoo.com', 'fySWTKrCFGUYjLhKP');
INSERT INTO accountant (name, email, password) VALUES ('David Green', 'keith09@yahoo.com', 'pWEVNldZTmvVIL');
INSERT INTO accountant (name, email, password) VALUES ('Christine Harmon', 'jperry@hotmail.com', 'XzPlOpnXDQxgcEMAe');
INSERT INTO accountant (name, email, password) VALUES ('Alan Hernandez', 'keith31@gmail.com', 'PNrVaaosKZWJS');
INSERT INTO accountant (name, email, password) VALUES ('Kenneth Eaton', 'natalie97@gmail.com', 'JqiRQwQsYHJcfdp');
INSERT INTO accountant (name, email, password) VALUES ('Tammy Reyes', 'jerrybailey@gmail.com', 'vKNBAoGyB');
INSERT INTO accountant (name, email, password) VALUES ('Mariah Kane', 'eduardo97@gmail.com', 'TYbiPPJTVI');
INSERT INTO accountant (name, email, password) VALUES ('George King', 'patricia31@hotmail.com', 'KWhBSvnBxUxGaPHpr');
INSERT INTO accountant (name, email, password) VALUES ('Todd Bishop', 'yolandawhitney@yahoo.com', 'MPeWWISWaLAEYhU');
INSERT INTO accountant (name, email, password) VALUES ('Beth Wilkerson', 'qbrown@gmail.com', 'AwtgcbNBGSYK');
INSERT INTO accountant (name, email, password) VALUES ('Hannah Nielsen', 'rmcdonald@yahoo.com', 'uLoDUMMUxAVSyJSM');
INSERT INTO accountant (name, email, password) VALUES ('William Copeland', 'mkelly@hotmail.com', 'xzxhBOQXZvuknkGw');
INSERT INTO accountant (name, email, password) VALUES ('Alexis Evans', 'hponce@hotmail.com', 'RvbZvqDWj');
INSERT INTO accountant (name, email, password) VALUES ('Jessica Hernandez', 'ericawilliams@yahoo.com', 'oArmwTuLcrTcgUrYKs');
INSERT INTO salary (amount, payed) VALUES ('33165', 'False');
INSERT INTO salary (amount, payed) VALUES ('88289', 'True');
INSERT INTO salary (amount, payed) VALUES ('88708', 'False');
INSERT INTO salary (amount, payed) VALUES ('60665', 'True');
INSERT INTO salary (amount, payed) VALUES ('96220', 'True');
INSERT INTO salary (amount, payed) VALUES ('42619', 'True');
INSERT INTO salary (amount, payed) VALUES ('45640', 'False');
INSERT INTO salary (amount, payed) VALUES ('33390', 'False');
INSERT INTO salary (amount, payed) VALUES ('74189', 'False');
INSERT INTO salary (amount, payed) VALUES ('86756', 'True');
INSERT INTO salary (amount, payed) VALUES ('75559', 'False');
INSERT INTO salary (amount, payed) VALUES ('41653', 'True');
INSERT INTO salary (amount, payed) VALUES ('91564', 'False');
INSERT INTO salary (amount, payed) VALUES ('78012', 'True');
INSERT INTO salary (amount, payed) VALUES ('59741', 'False');
INSERT INTO salary (amount, payed) VALUES ('42148', 'False');
INSERT INTO salary (amount, payed) VALUES ('66105', 'True');
INSERT INTO salary (amount, payed) VALUES ('77595', 'False');
INSERT INTO salary (amount, payed) VALUES ('97822', 'True');
INSERT INTO salary (amount, payed) VALUES ('37778', 'False');
INSERT INTO salary (amount, payed) VALUES ('99361', 'True');
INSERT INTO salary (amount, payed) VALUES ('40439', 'False');
INSERT INTO salary (amount, payed) VALUES ('62755', 'False');
INSERT INTO salary (amount, payed) VALUES ('96378', 'False');
INSERT INTO salary (amount, payed) VALUES ('52544', 'True');
INSERT INTO salary (amount, payed) VALUES ('36525', 'True');
INSERT INTO salary (amount, payed) VALUES ('58486', 'True');
INSERT INTO salary (amount, payed) VALUES ('85554', 'False');
INSERT INTO salary (amount, payed) VALUES ('81131', 'True');
INSERT INTO salary (amount, payed) VALUES ('38939', 'True');
INSERT INTO salary (amount, payed) VALUES ('32421', 'True');
INSERT INTO salary (amount, payed) VALUES ('99148', 'False');
INSERT INTO salary (amount, payed) VALUES ('83520', 'True');
INSERT INTO salary (amount, payed) VALUES ('79460', 'True');
INSERT INTO salary (amount, payed) VALUES ('52401', 'False');
INSERT INTO salary (amount, payed) VALUES ('41478', 'True');
INSERT INTO salary (amount, payed) VALUES ('31833', 'True');
INSERT INTO salary (amount, payed) VALUES ('85608', 'False');
INSERT INTO salary (amount, payed) VALUES ('31758', 'False');
INSERT INTO salary (amount, payed) VALUES ('56433', 'False');
INSERT INTO salary (amount, payed) VALUES ('70585', 'True');
INSERT INTO salary (amount, payed) VALUES ('79144', 'False');
INSERT INTO salary (amount, payed) VALUES ('51792', 'False');
INSERT INTO salary (amount, payed) VALUES ('44158', 'False');
INSERT INTO salary (amount, payed) VALUES ('84483', 'False');
INSERT INTO salary (amount, payed) VALUES ('41806', 'True');
INSERT INTO salary (amount, payed) VALUES ('52871', 'False');
INSERT INTO salary (amount, payed) VALUES ('30318', 'True');
INSERT INTO salary (amount, payed) VALUES ('38632', 'True');
INSERT INTO salary (amount, payed) VALUES ('36551', 'True');
INSERT INTO hospital_administrator (name, email, password) VALUES ('Hunter Gardner', 'johnnyward@yahoo.com', 'wmMmwsLbwZWoKTL');
INSERT INTO hospital_administrator (name, email, password) VALUES ('Jordan Williams', 'julie23@gmail.com', 'rXikPeBvzPCM');
INSERT INTO hospital_administrator (name, email, password) VALUES ('Julie Jones', 'mfranklin@gmail.com', 'hUILNgQwgWKC');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Etoposide', '542', '66', '22');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cefixime', '2215', '62', '58');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cytarabine', '1842', '37', '0');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cefuroxime', '3667', '28', '28');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Elvitegravir / cobicistat / emtricitabine / tenofovir alafenamide (Genvoya®)', '3426', '71', '68');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cefixime', '106', '19', '10');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Factor IX complex', '874', '79', '4');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cisplatin', '3847', '1', '0');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Efavirenz / emtricitabine / tenofovir (Atripla®)', '3816', '76', '32');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Enoxaparin', '3863', '30', '29');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Bleomycin', '636', '5', '3');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Bortezomib', '789', '48', '17');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Emtricitabine / tenofovir alafenamide (Descovy®)', '3257', '75', '2');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Allopurinol', '101', '61', '34');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Dopamine', '2242', '69', '6');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cefixime', '3369', '95', '75');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Clofarabine', '2231', '20', '3');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Carboplatin', '2098', '33', '31');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Factor IX concentrate', '1653', '19', '3');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Crizotinib', '330', '38', '0');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Amitriptyline', '735', '44', '26');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Allopurinol', '584', '17', '13');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Emicizumab', '2540', '22', '3');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Bosentan', '2632', '88', '66');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Azithromycin', '1323', '52', '31');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Baclofen', '3899', '34', '33');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cytarabine', '664', '63', '25');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Factor VIIa (Recombinant)', '2048', '79', '17');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Fluorouracil', '2894', '62', '6');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Alemtuzumab', '3167', '40', '33');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Abacavir', '1439', '77', '4');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Carmustine', '674', '20', '10');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cladribine', '1929', '71', '47');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Baclofen', '1143', '11', '0');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Famciclovir', '1800', '52', '35');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Daunorubicin', '3725', '71', '63');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Famciclovir', '1685', '70', '13');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Factor IX complex', '326', '31', '14');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Dacarbazine', '2967', '83', '29');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Emtricitabine / tenofovir alafenamide (Descovy®)', '2770', '9', '0');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Atazanavir (Reyataz®)', '832', '40', '27');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Eltrombopag', '125', '57', '20');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cefixime', '955', '33', '10');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Calcium', '1259', '60', '38');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cephalexin', '1554', '19', '11');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Erythropoietin', '999', '23', '8');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Dronabinol', '1101', '18', '16');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Acyclovir', '1320', '12', '9');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Daunorubicin', '2882', '17', '16');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Amphotericin B', '252', '73', '16');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cyproheptadine', '2571', '44', '43');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Codeine', '2020', '55', '31');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Carboplatin', '1339', '11', '0');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Emtricitabine / tenofovir (Truvada®)', '164', '90', '13');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Enalapril', '2474', '2', '2');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Fludarabine', '2373', '87', '80');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cladribine', '401', '49', '2');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Enalapril', '1220', '0', '0');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cephalexin', '881', '67', '64');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Anti-thymocyte globulin', '3921', '23', '10');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Dopamine', '805', '17', '10');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Dornase alfa', '3872', '59', '52');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cidofovir', '822', '74', '67');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Diclofenac', '515', '20', '18');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Atenolol', '1575', '87', '12');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Efavirenz', '3852', '16', '2');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Daunorubicin', '494', '25', '19');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Factor VIII (Recombinant)', '3433', '87', '38');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cisplatin', '3859', '8', '3');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Celecoxib', '347', '23', '15');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Allopurinol', '2091', '84', '38');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Clindamycin', '1011', '55', '29');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Deferasirox (Exjade®)', '241', '59', '48');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Alemtuzumab', '3622', '38', '3');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Emtricitabine / tenofovir alafenamide (Descovy®)', '1795', '81', '34');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Atazanavir (Reyataz®)', '3993', '79', '77');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Alendronate', '640', '76', '14');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Eltrombopag', '1199', '90', '28');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cefixime', '2382', '84', '13');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Fluorouracil', '2850', '3', '1');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cisplatin', '1505', '60', '33');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Captopril', '1833', '100', '61');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Abacavir / dolutegravir / lamivudine (Triumeq®)', '301', '49', '19');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Amoxicillin', '1968', '71', '43');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Efavirenz', '650', '81', '40');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Cephalexin', '3401', '54', '41');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Allopurinol', '706', '46', '14');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Elvitegravir / cobicistat / emtricitabine / tenofovir (Stribild®)', '875', '18', '7');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Abacavir', '2571', '26', '3');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Abacavir / dolutegravir / lamivudine (Triumeq®)', '3789', '90', '37');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Emtricitabine / tenofovir alafenamide (Descovy®)', '1778', '45', '6');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Desmopressin (Stimate®)', '2641', '92', '88');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Abacavir', '679', '26', '5');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Didanosine', '1075', '58', '0');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Emtricitabine / tenofovir (Truvada®)', '3482', '37', '17');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Anti-thymocyte globulin', '1032', '11', '9');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Elvitegravir / cobicistat / emtricitabine / tenofovir (Stribild®)', '3502', '37', '24');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Fluorouracil', '847', '98', '23');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Desmopressin (Stimate®)', '348', '12', '1');
INSERT INTO inventory (name, price, amount, amount_paid) VALUES ('Baclofen', '3313', '0', '0');
INSERT INTO laboratory_assistant (name, email, password) VALUES ('Angela Booth', 'mark27@hotmail.com', 'EDATjfQBHMH');
INSERT INTO laboratory_assistant (name, email, password) VALUES ('Michael Klein', 'henryturner@gmail.com', 'RIQSJxGAemnfidDBgbr');
INSERT INTO laboratory_assistant (name, email, password) VALUES ('Katherine Mendoza', 'gabriel87@hotmail.com', 'pAKoXATtGeh');
INSERT INTO laboratory_assistant (name, email, password) VALUES ('Isaiah Mercado', 'linda70@gmail.com', 'LJhsvMVK');
INSERT INTO laboratory_assistant (name, email, password) VALUES ('Jennifer Wright', 'castrodaniel@yahoo.com', 'MUwpyQHkHVocR');
INSERT INTO system_administrator (name, email, password) VALUES ('Kayla Taylor', 'leejohn@hotmail.com', 'XGSXIlQVLTyY');
INSERT INTO system_administrator (name, email, password) VALUES ('Adam Owens', 'hallgeorge@hotmail.com', 'tTrBoKMwitqoIg');
INSERT INTO system_administrator (name, email, password) VALUES ('Matthew Burnett', 'colonrichard@yahoo.com', 'PRAXHOxNFjuBTLREsg');
INSERT INTO system_administrator (name, email, password) VALUES ('Amanda Watts', 'houstonaaron@gmail.com', 'FrodXQonFs');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Paul Flores', 'pooleamanda@yahoo.com', 'zsgYgTOBYsI', 'anesthesiology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Pamela Levine', 'chasejensen@yahoo.com', 'MSCppYIjWGRmEl', 'pediatrics');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Nancy Mendoza', 'ftyler@yahoo.com', 'AYexWrAmxMMltbOUgQLS', 'diagnostic radiology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Gail Wilson', 'johnsonscott@hotmail.com', 'YeqSyzNjddlGMO', 'anesthesiology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Derrick Rowe', 'john79@yahoo.com', 'GUYmkoPykwVB', 'family medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Oscar Gonzalez', 'deborah12@gmail.com', 'mtjFGFDpYPslaN', 'neurology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Antonio Morales', 'xtanner@yahoo.com', 'xPKXQEeyWDBTH', 'pediatrics');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Erin Goodman', 'pgarcia@gmail.com', 'AeOamTcFZ', 'emergency medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Jennifer Brown', 'nwilliams@hotmail.com', 'qiVDuMgTnDJbxW', 'emergency medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Katrina Soto', 'chavezregina@yahoo.com', 'rNeZDtBLvL', 'anesthesiology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Miss Christina Atkins', 'bford@yahoo.com', 'IjgVGypQT', 'diagnostic radiology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Katelyn Pratt', 'smithwilliam@gmail.com', 'PdIDpycWsiaXZMHCnnQe', 'neurology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Laura Knight', 'taylor05@hotmail.com', 'PWwsgCWXeWBScVZONc', 'emergency medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Crystal Perry', 'frankwright@yahoo.com', 'vaPxhqszStqWeMmUVnC', 'diagnostic radiology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('David Parker', 'jessetran@hotmail.com', 'dliqXMQfmzz', 'emergency medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Todd Lane', 'morabrooke@gmail.com', 'LjRxfVucFD', 'emergency medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Janet Whitaker', 'njohnson@yahoo.com', 'jqPMgGOvjWSjW', 'family medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Emily Crawford', 'heathgreg@gmail.com', 'EjWdnBnp', 'diagnostic radiology');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Nicole West', 'lewismark@yahoo.com', 'yltqajDuzCbSD', 'emergency medicine');
INSERT INTO doctor (name, email, password, speciality) VALUES ('Nancy Duncan', 'anthonylawson@gmail.com', 'jLEzXuDcWkhmafZmFOqO', 'dermatology');
INSERT INTO nurse (name, email, password) VALUES ('Randall Martin', 'sarahkeller@gmail.com', 'IbOTjjIBmMNWDyQnte');
INSERT INTO nurse (name, email, password) VALUES ('Jeremy Bentley', 'ebony33@yahoo.com', 'XNbqrxedVQixvHgmMu');
INSERT INTO nurse (name, email, password) VALUES ('Darrell Finley', 'carrollpatrick@gmail.com', 'UpNRpAISNGtYoQ');
INSERT INTO nurse (name, email, password) VALUES ('Sean Moore', 'fthomas@yahoo.com', 'qRtmBObIavzpsOAekhhf');
INSERT INTO nurse (name, email, password) VALUES ('Ronald Holloway', 'marshallmelissa@hotmail.com', 'mMbquMjrmSuWGUfK');
INSERT INTO nurse (name, email, password) VALUES ('Julie Jones', 'changanne@yahoo.com', 'KwYMAvHSZgBG');
INSERT INTO nurse (name, email, password) VALUES ('Nicole Johnson', 'joannamartinez@gmail.com', 'FiCGfLKoV');
INSERT INTO nurse (name, email, password) VALUES ('James Alexander', 'dylanroberts@hotmail.com', 'XzgBJMjLUfuoWCLv');
INSERT INTO nurse (name, email, password) VALUES ('David Davis', 'zcrawford@hotmail.com', 'gJqndZGXPKIkfRI');
INSERT INTO nurse (name, email, password) VALUES ('Timothy Whitehead', 'bradley63@gmail.com', 'lhZsNsPqHTpfefaLcBh');
INSERT INTO nurse (name, email, password) VALUES ('Jill Curtis', 'lwilliams@gmail.com', 'rLOdnOJYJbyVNYLrE');
INSERT INTO nurse (name, email, password) VALUES ('Stephanie Robinson', 'dmiles@yahoo.com', 'JZsXtouy');
INSERT INTO nurse (name, email, password) VALUES ('Todd Charles', 'qdavenport@yahoo.com', 'NLQtQacCcage');
INSERT INTO nurse (name, email, password) VALUES ('Molly Wall', 'chris25@yahoo.com', 'KmxRcrlgFpKhA');
INSERT INTO nurse (name, email, password) VALUES ('Gregory Campbell', 'martinbird@yahoo.com', 'JpqmvufzKzNI');
INSERT INTO nurse (name, email, password) VALUES ('Sean Ramos', 'sporter@gmail.com', 'SlhlWvXnlvf');
INSERT INTO nurse (name, email, password) VALUES ('Zachary Conrad', 'hannahgibson@yahoo.com', 'fySWTKrCFGUYjLhKP');
INSERT INTO nurse (name, email, password) VALUES ('David Green', 'keith09@yahoo.com', 'pWEVNldZTmvVIL');
INSERT INTO nurse (name, email, password) VALUES ('Christine Harmon', 'jperry@hotmail.com', 'XzPlOpnXDQxgcEMAe');
INSERT INTO nurse (name, email, password) VALUES ('Alan Hernandez', 'keith31@gmail.com', 'PNrVaaosKZWJS');
INSERT INTO nurse (name, email, password) VALUES ('Kenneth Eaton', 'natalie97@gmail.com', 'JqiRQwQsYHJcfdp');
INSERT INTO nurse (name, email, password) VALUES ('Tammy Reyes', 'jerrybailey@gmail.com', 'vKNBAoGyB');
INSERT INTO nurse (name, email, password) VALUES ('Mariah Kane', 'eduardo97@gmail.com', 'TYbiPPJTVI');
INSERT INTO nurse (name, email, password) VALUES ('George King', 'patricia31@hotmail.com', 'KWhBSvnBxUxGaPHpr');
INSERT INTO nurse (name, email, password) VALUES ('Todd Bishop', 'yolandawhitney@yahoo.com', 'MPeWWISWaLAEYhU');
INSERT INTO nurse (name, email, password) VALUES ('Beth Wilkerson', 'qbrown@gmail.com', 'AwtgcbNBGSYK');
INSERT INTO nurse (name, email, password) VALUES ('Hannah Nielsen', 'rmcdonald@yahoo.com', 'uLoDUMMUxAVSyJSM');
INSERT INTO nurse (name, email, password) VALUES ('William Copeland', 'mkelly@hotmail.com', 'xzxhBOQXZvuknkGw');
INSERT INTO nurse (name, email, password) VALUES ('Alexis Evans', 'hponce@hotmail.com', 'RvbZvqDWj');
INSERT INTO nurse (name, email, password) VALUES ('Jessica Hernandez', 'ericawilliams@yahoo.com', 'oArmwTuLcrTcgUrYKs');
INSERT INTO payment (amount, service, date) VALUES ('97792', 'doctor', '2019-10-16');
INSERT INTO payment (amount, service, date) VALUES ('94356', 'administrator', '2019-06-16');
INSERT INTO payment (amount, service, date) VALUES ('80611', 'nurse', '2019-07-25');
INSERT INTO payment (amount, service, date) VALUES ('64178', 'nurse', '2019-11-07');
INSERT INTO payment (amount, service, date) VALUES ('78727', 'doctor', '2019-01-26');
INSERT INTO payment (amount, service, date) VALUES ('57493', 'nurse', '2019-02-07');
INSERT INTO payment (amount, service, date) VALUES ('59342', 'nurse', '2019-11-07');
INSERT INTO payment (amount, service, date) VALUES ('30472', 'doctor', '2019-09-13');
INSERT INTO payment (amount, service, date) VALUES ('65196', 'administrator', '2019-10-04');
INSERT INTO payment (amount, service, date) VALUES ('78316', 'doctor', '2019-01-16');
INSERT INTO payment (amount, service, date) VALUES ('67840', 'nurse', '2019-09-23');
INSERT INTO payment (amount, service, date) VALUES ('36471', 'doctor', '2019-11-29');
INSERT INTO payment (amount, service, date) VALUES ('90130', 'administrator', '2019-04-13');
INSERT INTO payment (amount, service, date) VALUES ('82786', 'nurse', '2019-02-27');
INSERT INTO payment (amount, service, date) VALUES ('63832', 'nurse', '2019-02-04');
INSERT INTO payment (amount, service, date) VALUES ('63949', 'doctor', '2019-09-18');
INSERT INTO payment (amount, service, date) VALUES ('50053', 'administrator', '2019-05-15');
INSERT INTO payment (amount, service, date) VALUES ('62985', 'assistant', '2019-08-31');
INSERT INTO payment (amount, service, date) VALUES ('64146', 'administrator', '2019-09-14');
INSERT INTO payment (amount, service, date) VALUES ('43369', 'nurse', '2019-11-22');
INSERT INTO payment (amount, service, date) VALUES ('55349', 'doctor', '2019-10-04');
INSERT INTO payment (amount, service, date) VALUES ('34659', 'doctor', '2019-04-03');
INSERT INTO payment (amount, service, date) VALUES ('59937', 'administrator', '2019-05-19');
INSERT INTO payment (amount, service, date) VALUES ('54454', 'assistant', '2019-08-09');
INSERT INTO payment (amount, service, date) VALUES ('55045', 'nurse', '2019-10-06');
INSERT INTO payment (amount, service, date) VALUES ('73989', 'nurse', '2019-11-12');
INSERT INTO payment (amount, service, date) VALUES ('81620', 'doctor', '2019-11-23');
INSERT INTO payment (amount, service, date) VALUES ('86982', 'nurse', '2019-08-31');
INSERT INTO payment (amount, service, date) VALUES ('47043', 'doctor', '2019-05-05');
INSERT INTO payment (amount, service, date) VALUES ('45787', 'doctor', '2019-11-20');
INSERT INTO payment (amount, service, date) VALUES ('79361', 'assistant', '2019-08-24');
INSERT INTO payment (amount, service, date) VALUES ('86676', 'assistant', '2019-03-16');
INSERT INTO payment (amount, service, date) VALUES ('59083', 'administrator', '2019-02-15');
INSERT INTO payment (amount, service, date) VALUES ('60527', 'assistant', '2019-08-12');
INSERT INTO payment (amount, service, date) VALUES ('41590', 'administrator', '2019-02-07');
INSERT INTO payment (amount, service, date) VALUES ('86077', 'administrator', '2019-07-12');
INSERT INTO payment (amount, service, date) VALUES ('72477', 'nurse', '2019-11-02');
INSERT INTO payment (amount, service, date) VALUES ('45412', 'doctor', '2019-04-14');
INSERT INTO payment (amount, service, date) VALUES ('68221', 'nurse', '2019-10-27');
INSERT INTO payment (amount, service, date) VALUES ('42592', 'administrator', '2019-01-25');
INSERT INTO payment (amount, service, date) VALUES ('99169', 'nurse', '2019-02-21');
INSERT INTO payment (amount, service, date) VALUES ('36366', 'nurse', '2019-10-17');
INSERT INTO payment (amount, service, date) VALUES ('86218', 'assistant', '2019-07-22');
INSERT INTO payment (amount, service, date) VALUES ('91227', 'nurse', '2019-04-02');
INSERT INTO payment (amount, service, date) VALUES ('89521', 'nurse', '2019-06-17');
INSERT INTO payment (amount, service, date) VALUES ('43128', 'administrator', '2019-11-29');
INSERT INTO payment (amount, service, date) VALUES ('88073', 'nurse', '2019-07-07');
INSERT INTO payment (amount, service, date) VALUES ('95660', 'administrator', '2019-04-25');
INSERT INTO payment (amount, service, date) VALUES ('74391', 'assistant', '2019-09-27');
INSERT INTO payment (amount, service, date) VALUES ('32598', 'nurse', '2019-09-03');
INSERT INTO payment (amount, service, date) VALUES ('76809', 'administrator', '2019-11-17');
INSERT INTO payment (amount, service, date) VALUES ('75907', 'administrator', '2019-04-24');
INSERT INTO payment (amount, service, date) VALUES ('85932', 'administrator', '2019-03-19');
INSERT INTO payment (amount, service, date) VALUES ('66783', 'assistant', '2019-02-08');
INSERT INTO payment (amount, service, date) VALUES ('92428', 'administrator', '2019-10-28');
INSERT INTO payment (amount, service, date) VALUES ('65886', 'doctor', '2019-11-19');
INSERT INTO payment (amount, service, date) VALUES ('37217', 'nurse', '2019-08-02');
INSERT INTO payment (amount, service, date) VALUES ('61732', 'nurse', '2019-03-18');
INSERT INTO payment (amount, service, date) VALUES ('45410', 'doctor', '2019-07-20');
INSERT INTO payment (amount, service, date) VALUES ('95845', 'nurse', '2019-08-30');
INSERT INTO lab (room_number) VALUES ('389');
INSERT INTO lab (room_number) VALUES ('259');
INSERT INTO lab (room_number) VALUES ('9');
INSERT INTO lab (room_number) VALUES ('488');
INSERT INTO lab (room_number) VALUES ('38');
INSERT INTO lab (room_number) VALUES ('129');
INSERT INTO lab (room_number) VALUES ('441');
INSERT INTO lab (room_number) VALUES ('359');
INSERT INTO lab (room_number) VALUES ('213');
INSERT INTO lab (room_number) VALUES ('80');
INSERT INTO lab (room_number) VALUES ('171');
INSERT INTO lab (room_number) VALUES ('471');
INSERT INTO lab (room_number) VALUES ('424');
INSERT INTO lab (room_number) VALUES ('394');
INSERT INTO lab (room_number) VALUES ('496');
INSERT INTO lab (room_number) VALUES ('65');
INSERT INTO lab (room_number) VALUES ('176');
INSERT INTO lab (room_number) VALUES ('197');
INSERT INTO lab (room_number) VALUES ('174');
INSERT INTO lab (room_number) VALUES ('57');
INSERT INTO lab (room_number) VALUES ('285');
INSERT INTO lab (room_number) VALUES ('66');
INSERT INTO lab (room_number) VALUES ('419');
INSERT INTO lab (room_number) VALUES ('362');
INSERT INTO lab (room_number) VALUES ('402');
INSERT INTO lab (room_number) VALUES ('488');
INSERT INTO lab (room_number) VALUES ('299');
INSERT INTO lab (room_number) VALUES ('271');
INSERT INTO lab (room_number) VALUES ('405');
INSERT INTO lab (room_number) VALUES ('192');
INSERT INTO lab (room_number) VALUES ('226');
INSERT INTO lab (room_number) VALUES ('378');
INSERT INTO lab (room_number) VALUES ('75');
INSERT INTO lab (room_number) VALUES ('326');
INSERT INTO lab (room_number) VALUES ('306');
INSERT INTO test_results (result_file) VALUES ('/results/gqYmVZhpaV.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/ZStkKWeX.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/BWtuz.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/LuieUOqx.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/eYNPVKWnb.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/RbeWF.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/TdvsuGvNA.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/Yttlotk.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/GIjKHAO.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/slLjTrUIl.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/vlBhprXe.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/eRkRDZnTH.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/YmimfKon.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/nReIPfziz.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/aVvDEzyQjB.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/UKbLaQe.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/mvQwcy.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/DSVgKKWkk.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/etoVzGrMum.pdf');
INSERT INTO test_results (result_file) VALUES ('/results/geDo.pdf');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('4', '16');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('28', '14');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('12', '18');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('35', '3');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('13', '16');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('20', '14');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('3', '16');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('19', '15');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('29', '4');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('34', '1');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('6', '4');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('29', '3');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('16', '20');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('16', '20');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('22', '3');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('5', '17');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('29', '12');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('17', '9');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('31', '7');
INSERT INTO checks_medical_history (patient_id, doctor_id) VALUES ('35', '15');
INSERT INTO sends_receipt (patient_id, accountant_id, receipt) VALUES ('26', '29', 'Anti-Inhibitor Coagulant Complex (FEIBA)');
INSERT INTO sends_receipt (patient_id, accountant_id, receipt) VALUES ('2', '65', 'Aminocaproic Acid');
INSERT INTO sends_receipt (patient_id, accountant_id, receipt) VALUES ('20', '20', 'Cyclosporine');
INSERT INTO sends_receipt (patient_id, accountant_id, receipt) VALUES ('21', '49', 'Cefuroxime');
INSERT INTO sends_receipt (patient_id, accountant_id, receipt) VALUES ('24', '7', 'Acyclovir');
INSERT INTO sends_receipt (patient_id, accountant_id, receipt) VALUES ('3', '5', 'Cefaclor');
INSERT INTO sends_receipt (patient_id, accountant_id, receipt) VALUES ('1', '87', 'Elvitegravir / cobicistat / emtricitabine / tenofovir alafenamide (Genvoya®)');
INSERT INTO sends_receipt (patient_id, accountant_id, receipt) VALUES ('10', '37', 'Atenolol');
INSERT INTO sends_receipt (patient_id, accountant_id, receipt) VALUES ('32', '2', 'Fluorouracil');
INSERT INTO sends_receipt (patient_id, accountant_id, receipt) VALUES ('35', '51', 'Efavirenz / emtricitabine / tenofovir (Atripla®)');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('29', '15', 'Short itself story rest him. Final to station recent interesting.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('25', '4', 'Particularly tough job firm entire. Around someone skin focus floor trouble.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('2', '1', 'Back hot first me. Writer bring join thing than how.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('6', '7', 'Five he spend no view prove. Myself determine remain color they beautiful.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('11', '3', 'Action sure billion seek. Single cup news international collection.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('23', '17', 'Whole size officer artist agent address. Southern use consider.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('19', '18', 'Difficult your newspaper pull. Sell political beat world inside ball never.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('24', '5', 'Much thought their civil. End herself production table reveal.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('10', '6', 'Decade boy image spend great heart. Institution what concern prepare upon.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('12', '4', 'Raise public realize. Also small produce above prevent activity.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('23', '19', 'Couple career between able year always. Away near beautiful rate.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('5', '16', 'Eye him evidence. Leg research continue ok rich impact. More police save.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('5', '19', 'Respond office information they ten. Tough discover old among minute.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('8', '4', 'Begin learn whom model service. Drive only everything.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('22', '2', 'Age someone stay one. Himself begin five agreement people policy official.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('28', '15', 'Stage discover piece enough indicate together. Home stay pretty study.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('5', '2', 'Avoid tree social foreign value north enter.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('35', '6', 'Treat themselves civil simple large. Science control put card how stock answer.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('34', '1', 'Would true other two seven theory as lead.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('35', '1', 'Decide pay develop. Thus evening close Congress too.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('1', '5', 'Me hard town job behind money traditional field.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('22', '16', 'Class deep authority week. Each church nation.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('25', '3', 'Movie describe little century. President hard worker.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('9', '20', 'Cut not medical score left to memory pay. Yourself accept wall.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('34', '9', 'Wear whether add project. Last method best church.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('25', '5', 'Mind watch cold water up decision law involve.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('9', '16', 'Know already leader direction street lot factor. Lead price star ground.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('34', '14', 'Realize join indeed develop instead center.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('13', '10', 'Appear day open relate if national hear throughout.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('1', '20', 'Few traditional seat happen. Student wide example step.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('33', '6', 'Network stage voice interview imagine drive foot any.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('21', '18', 'His positive idea easy exist. Born address late same full exactly nearly.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('32', '5', 'Window girl head accept instead take.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('26', '17', 'How ball involve challenge yet. Cut usually item who cell dinner.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('4', '11', 'Person before red check meeting. System water fight beat.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('7', '18', 'Form modern floor teacher still edge job.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('28', '16', 'Both offer watch push idea. Will so water hit. However TV seem choose first.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('31', '15', 'Own account bank. Economic sea language effect ever old.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('3', '16', 'Brother yeah low coach chance. Market the water film hour score become.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('6', '9', 'Me many husband. Behind few list church individual.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('10', '5', 'Reflect listen development analysis. Health nation trouble then card cup.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('11', '7', 'Significant play project can pick. Customer green defense market nearly.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('22', '17', 'Someone on catch field born. Alone bed girl hit do point family.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('7', '7', 'Now hair in general will big. Late other section point husband.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('30', '7', 'Raise her subject letter. Wide whether sure answer lawyer.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('4', '15', 'Real interesting two win recognize cold. Night whose available.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('24', '20', 'Degree sometimes protect city imagine court main.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('5', '14', 'Set behavior mind medical discuss draw three fear. Develop law item us.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('16', '20', 'While foreign through responsibility. Wind road or big central through pull.');
INSERT INTO writes_message (patient_id, doctor_id, text_message) VALUES ('35', '4', 'Quickly themselves defense you amount human billion.');
INSERT INTO enrolls (admin_id, inventory_id) VALUES ('2', '100');
INSERT INTO enrolls (admin_id, inventory_id) VALUES ('2', '65');
INSERT INTO enrolls (admin_id, inventory_id) VALUES ('3', '14');
INSERT INTO enrolls (admin_id, inventory_id) VALUES ('3', '31');
INSERT INTO enrolls (admin_id, inventory_id) VALUES ('1', '19');
INSERT INTO enrolls (admin_id, inventory_id) VALUES ('1', '99');
INSERT INTO enrolls (admin_id, inventory_id) VALUES ('1', '64');
INSERT INTO enrolls (admin_id, inventory_id) VALUES ('2', '77');
INSERT INTO enrolls (admin_id, inventory_id) VALUES ('2', '92');
INSERT INTO enrolls (admin_id, inventory_id) VALUES ('3', '78');
INSERT INTO generates_results (lab_id, test_results_id) VALUES ('24', '15');
INSERT INTO generates_results (lab_id, test_results_id) VALUES ('11', '10');
INSERT INTO generates_results (lab_id, test_results_id) VALUES ('23', '20');
INSERT INTO generates_results (lab_id, test_results_id) VALUES ('3', '18');
INSERT INTO generates_results (lab_id, test_results_id) VALUES ('21', '14');
INSERT INTO makes_tests (lab_id, lab_assistant_id) VALUES ('4', '5');
INSERT INTO makes_tests (lab_id, lab_assistant_id) VALUES ('11', '2');
INSERT INTO makes_tests (lab_id, lab_assistant_id) VALUES ('29', '5');
INSERT INTO makes_tests (lab_id, lab_assistant_id) VALUES ('22', '1');
INSERT INTO makes_tests (lab_id, lab_assistant_id) VALUES ('25', '4');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('25', '10', 'Issue magazine people concern board morning close would.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('12', '5', 'Property remain pressure again good system.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('7', '10', 'Never street turn although. Movie Congress face study society door Mrs.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('24', '1', 'Stand describe real must along produce.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('5', '20', 'Bill south start start. Four approach store modern save charge.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('2', '13', 'Every news on. Natural watch investment especially Mrs week.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('24', '6', 'Energy agency north foot foreign raise away contain.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('23', '6', 'Little be million space smile there executive.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('22', '12', 'Let nothing any without. Imagine court level off current worker.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('26', '9', 'Term popular both around. Leg here social professional method institution.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('14', '5', 'Subject economic son report. Term leave order society sound usually deep.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('8', '15', 'People near full. It go cut the easy. Huge across chair if.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('25', '15', 'Miss film leave itself. Project fill sort travel out north.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('18', '4', 'Everybody apply officer moment day type collection.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('12', '14', 'With school really inside important yourself leave something.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('22', '2', 'Reduce above war two. Sure result avoid fund ok wish religious.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('21', '15', 'Ability data life remain body. Recent month view thought prove.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('3', '19', 'Him total well area candidate prepare thought.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('16', '6', 'Push reduce face crime. Green oil work as change officer others.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('11', '8', 'Late southern scientist understand because people.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('28', '16', 'Seat relate who paper past present. Indicate a us design order personal to.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('25', '19', 'Practice environmental spring heart my tough across. Page grow drug pressure.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('4', '17', 'Hear debate very throughout without.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('9', '2', 'Across group center among. Commercial provide production respond house.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('27', '4', 'Article commercial describe dinner way record.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('27', '19', 'High everybody box whose suggest environmental true.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('19', '5', 'Sell whom research economic form unit read.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('13', '14', 'Success response while entire growth black. Car modern shoulder allow fine.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('20', '12', 'Than small focus top when success. Tree low audience model color her.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('16', '8', 'Why level world yes statement. Term attention never minute.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('18', '13', 'Type bit place low third guess figure. Week few military else.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('10', '18', 'Subject adult attention economy claim whether. Too those easy fine couple add.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('29', '5', 'Father anything language behind because.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('25', '16', 'Friend budget company close. Lawyer tree live.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('24', '4', 'Art but certain can. Middle weight adult exactly measure.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('8', '9', 'Water form moment economy teacher even poor. Station hard open yes.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('11', '18', 'Order fly response second. Development you really him gun.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('27', '10', 'Rate apply morning almost table language. Test capital history so.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('7', '20', 'Majority size somebody big. Put successful test very administration risk apply.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('9', '13', 'Trade husband growth believe really charge process.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('3', '2', 'Low already audience list order large write.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('30', '19', 'Central reflect seek national. Create current toward west.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('21', '12', 'Military service about. Begin rate school weight current daughter less.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('17', '11', 'Response recently listen exactly movement professional hotel.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('30', '9', 'Mention daughter hear summer law through sort.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('27', '13', 'Check trouble father west provide eight.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('10', '9', 'Fine oil themselves wear health figure.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('21', '16', 'Office source nothing start sense democratic which.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('20', '12', 'War late question each above where.');
INSERT INTO writes_message_nurse (nurse_id, doctor_id, text_message) VALUES ('11', '6', 'Star doctor develop certain. Would whose yeah site get mouth car.');
