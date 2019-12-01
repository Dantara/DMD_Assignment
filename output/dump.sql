-- Database: DMD Phase 3

-- DROP DATABASE "DMD Phase 3";
CREATE TABLE PATIENT(
  pid SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  phone_number Char(11),
  date_of_birth Date,
  medical_history Varchar(50),
  room_number INT,
  email varchar(20),
  password Varchar(20),
  PRIMARY KEY(pid),
  UNIQUE(medical_history),
  UNIQUE(email)
);

CREATE TABLE ACCOUNTANT(
  acid SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  email varchar(20),
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
  email Varchar(20) NOT NULL,
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
  email Varchar(20) NOT NULL,
  password Varchar(20) NOT NULL, 
  PRIMARY KEY(aid),
  UNIQUE(email)
);

CREATE TABLE SYSTEM_ADMINISTRATOR(
  said SERIAL NOT NULL, 
  name Varchar(50) NOT NULL,
  email Varchar(20) NOT NULL,
  password Varchar(20) NOT NULL,
  PRIMARY KEY(said),
  UNIQUE(email)
);

CREATE TABLE DOCTOR(
  did SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  speciality Varchar(50) NOT NULL,
  email Varchar(20) NOT NULL,
  password Varchar(20) NOT NULL,
  PRIMARY KEY(did),
  UNIQUE(email)
);

CREATE TABLE NURSE(
  nid SERIAL NOT NULL,
  name Varchar(50) NOT NULL,
  email Varchar(20) NOT NULL,
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
INSERT INTO ACCOUNTANT VALUES ('Christian Braun', 'brianna84@yahoo.com', 'aSBQILzSuouZ');
INSERT INTO PATIENT VALUES ('Christian Braun', '+7 370 705 15 59', '1959-08-22', 'brianna84@yahoo.com', 'Nearly my your especially require century occur.', '391', 'aSBQILzSuouZ');
INSERT INTO ACCOUNTANT VALUES ('Anna Gonzales', 'garcialynn@hotmail.com', 'ekRrIcXhkUcExFVLzYry');
INSERT INTO PATIENT VALUES ('Anna Gonzales', '87086488162', '2017-03-12', 'garcialynn@hotmail.com', 'Bar game friend many it lead.', '290', 'ekRrIcXhkUcExFVLzYry');
INSERT INTO ACCOUNTANT VALUES ('Sean Dunn', 'joel23@hotmail.com', 'BnOLgnEJMtDaqYmASPBf');
INSERT INTO PATIENT VALUES ('Sean Dunn', '+7 (153) 971-0080', '1956-02-16', 'joel23@hotmail.com', 'Than land list guess inside parent machine.', '194', 'BnOLgnEJMtDaqYmASPBf');
INSERT INTO ACCOUNTANT VALUES ('Rebecca Young', 'tboyd@hotmail.com', 'YhIlAxDvFnq');
INSERT INTO PATIENT VALUES ('Rebecca Young', '8 (963) 721-3719', '2006-12-28', 'tboyd@hotmail.com', 'Fine former wind door.', '66', 'YhIlAxDvFnq');
INSERT INTO ACCOUNTANT VALUES ('Savannah Chavez', 'greenmary@hotmail.com', 'wMCkbGbQzwLrXe');
INSERT INTO PATIENT VALUES ('Savannah Chavez', '8 (909) 695-97-26', '2011-12-02', 'greenmary@hotmail.com', 'Language already describe relate stuff audience.', '481', 'wMCkbGbQzwLrXe');
INSERT INTO ACCOUNTANT VALUES ('Mr. Christopher Joyce', 'mpetersen@hotmail.com', 'XeGBgHsnI');
INSERT INTO PATIENT VALUES ('Mr. Christopher Joyce', '8 (242) 751-82-51', '2002-08-12', 'mpetersen@hotmail.com', 'Ask although door financial.', '4', 'XeGBgHsnI');
INSERT INTO ACCOUNTANT VALUES ('Ashley Banks', 'melvin39@yahoo.com', 'OVYzUywsVmfXmqu');
INSERT INTO PATIENT VALUES ('Ashley Banks', '8 589 058 46 62', '1981-10-16', 'melvin39@yahoo.com', 'Choose north if next east officer worry.', '386', 'OVYzUywsVmfXmqu');
INSERT INTO ACCOUNTANT VALUES ('Scott Fisher', 'jeffreywilliams@gmail.com', 'AprizrGIL');
INSERT INTO PATIENT VALUES ('Scott Fisher', '88247990509', '1916-09-21', 'jeffreywilliams@gmail.com', 'Establish coach term personal.', '246', 'AprizrGIL');
INSERT INTO ACCOUNTANT VALUES ('Kristi Tucker', 'fbray@hotmail.com', 'QVRqZgNAIfyqVdBwnr');
INSERT INTO PATIENT VALUES ('Kristi Tucker', '+77386900166', '1963-09-17', 'fbray@hotmail.com', 'Rest subject include.', '325', 'QVRqZgNAIfyqVdBwnr');
INSERT INTO ACCOUNTANT VALUES ('Christina Reed', 'lauraaguilar@hotmail.com', 'dNnMuREvIT');
INSERT INTO PATIENT VALUES ('Christina Reed', '8 (701) 068-8273', '1984-04-29', 'lauraaguilar@hotmail.com', 'Always firm cut suggest.', '44', 'dNnMuREvIT');
INSERT INTO ACCOUNTANT VALUES ('Christopher Watkins', 'webblori@hotmail.com', 'FDoAOBBJYZsDSh');
INSERT INTO PATIENT VALUES ('Christopher Watkins', '8 (699) 668-94-07', '1995-10-14', 'webblori@hotmail.com', 'Certainly while beautiful military policy into.', '131', 'FDoAOBBJYZsDSh');
INSERT INTO ACCOUNTANT VALUES ('Savannah Avila', 'johnbenjamin@gmail.com', 'mnEqrdwcrv');
INSERT INTO PATIENT VALUES ('Savannah Avila', '8 036 632 8716', '2018-06-16', 'johnbenjamin@gmail.com', 'Defense contain month. Most scene happy decision.', '472', 'mnEqrdwcrv');
INSERT INTO ACCOUNTANT VALUES ('Karen Taylor', 'annettepineda@yahoo.com', 'jioIDhFPkvOHopPifDY');
INSERT INTO PATIENT VALUES ('Karen Taylor', '+76210382813', '1922-11-10', 'annettepineda@yahoo.com', 'Many activity space friend.', '361', 'jioIDhFPkvOHopPifDY');
INSERT INTO ACCOUNTANT VALUES ('Theodore Thomas', 'david13@hotmail.com', 'cevvwUtiBZYwGo');
INSERT INTO PATIENT VALUES ('Theodore Thomas', '83419043209', '1943-02-18', 'david13@hotmail.com', 'Cell physical grow.', '124', 'cevvwUtiBZYwGo');
INSERT INTO ACCOUNTANT VALUES ('Linda Caldwell', 'anne02@gmail.com', 'hbHwjHGyJagEFZhR');
INSERT INTO PATIENT VALUES ('Linda Caldwell', '8 (058) 741-90-07', '1906-12-27', 'anne02@gmail.com', 'Analysis relate catch black big fear.', '207', 'hbHwjHGyJagEFZhR');
INSERT INTO ACCOUNTANT VALUES ('Sean Henderson', 'moyererica@hotmail.com', 'vvwCwUcd');
INSERT INTO PATIENT VALUES ('Sean Henderson', '86469904506', '1937-10-21', 'moyererica@hotmail.com', 'Reality Congress coach difference statement.', '388', 'vvwCwUcd');
INSERT INTO ACCOUNTANT VALUES ('Elizabeth Pham', 'tonya29@gmail.com', 'KZfmHSVcMQdldhRXYi');
INSERT INTO PATIENT VALUES ('Elizabeth Pham', '+7 (026) 076-27-56', '1942-11-25', 'tonya29@gmail.com', 'Student agency test run travel card good.', '340', 'KZfmHSVcMQdldhRXYi');
INSERT INTO ACCOUNTANT VALUES ('Samantha Young', 'carlos01@hotmail.com', 'KAUDxhnpRtLtGdsvsz');
INSERT INTO PATIENT VALUES ('Samantha Young', '85826729066', '2002-07-19', 'carlos01@hotmail.com', 'Campaign age however remember.', '264', 'KAUDxhnpRtLtGdsvsz');
INSERT INTO ACCOUNTANT VALUES ('Tara Suarez', 'iskinner@yahoo.com', 'VXhwBzseUPPYOcfCGxiG');
INSERT INTO PATIENT VALUES ('Tara Suarez', '+7 (614) 451-85-25', '1932-12-28', 'iskinner@yahoo.com', 'Trial quite writer test democratic professional.', '182', 'VXhwBzseUPPYOcfCGxiG');
INSERT INTO ACCOUNTANT VALUES ('Bobby Gonzalez', 'christopher61@hotmail.com', 'iZPPIbgPcVfdUSNT');
INSERT INTO PATIENT VALUES ('Bobby Gonzalez', '+7 878 726 41 50', '1915-04-04', 'christopher61@hotmail.com', 'International case see give billion anyone.', '24', 'iZPPIbgPcVfdUSNT');
INSERT INTO ACCOUNTANT VALUES ('Patricia Garrett', 'qlopez@yahoo.com', 'cgJwCnIbLEfwZOdmdD');
INSERT INTO PATIENT VALUES ('Patricia Garrett', '+7 842 685 3906', '1990-12-30', 'qlopez@yahoo.com', 'Majority table share always because improve.', '57', 'cgJwCnIbLEfwZOdmdD');
INSERT INTO ACCOUNTANT VALUES ('Julie Mathis', 'owalters@yahoo.com', 'cpWmISFmU');
INSERT INTO PATIENT VALUES ('Julie Mathis', '82562765806', '2014-02-18', 'owalters@yahoo.com', 'Parent television artist fund agreement call.', '256', 'cpWmISFmU');
INSERT INTO ACCOUNTANT VALUES ('Melissa Burke', 'garrettkelsey@gmail.com', 'IFdqTAUTL');
INSERT INTO PATIENT VALUES ('Melissa Burke', '8 (205) 204-5790', '1948-06-28', 'garrettkelsey@gmail.com', 'Policy human claim even.', '27', 'IFdqTAUTL');
INSERT INTO ACCOUNTANT VALUES ('Jesse Gibson', 'matthew93@gmail.com', 'BirzkCjn');
INSERT INTO PATIENT VALUES ('Jesse Gibson', '8 397 102 73 15', '1931-02-09', 'matthew93@gmail.com', 'And plant recent top check friend century drop.', '284', 'BirzkCjn');
INSERT INTO ACCOUNTANT VALUES ('Rebecca Powell', 'coxtimothy@hotmail.com', 'oRNAXwHuyTHuM');
INSERT INTO PATIENT VALUES ('Rebecca Powell', '81677820671', '1950-10-16', 'coxtimothy@hotmail.com', 'Right far order city.', '54', 'oRNAXwHuyTHuM');
INSERT INTO ACCOUNTANT VALUES ('Dan Morgan', 'rachel99@hotmail.com', 'plwhxziC');
INSERT INTO PATIENT VALUES ('Dan Morgan', '8 (390) 997-40-04', '2004-09-18', 'rachel99@hotmail.com', 'Energy better one quite Mr conference understand.', '422', 'plwhxziC');
INSERT INTO ACCOUNTANT VALUES ('Richard Gill', 'sandersderek@gmail.com', 'MflNMcUqNgVz');
INSERT INTO PATIENT VALUES ('Richard Gill', '+7 171 589 0524', '1921-08-26', 'sandersderek@gmail.com', 'Hear involve standard hit.', '399', 'MflNMcUqNgVz');
INSERT INTO ACCOUNTANT VALUES ('Matthew Ortiz', 'marcmeyers@hotmail.com', 'glGCEAtLgby');
INSERT INTO PATIENT VALUES ('Matthew Ortiz', '+7 328 882 56 59', '1936-07-21', 'marcmeyers@hotmail.com', 'Want find win set hope house.', '191', 'glGCEAtLgby');
INSERT INTO ACCOUNTANT VALUES ('James Malone', 'francisbrandy@hotmail.com', 'BSADoVJasYspRAlejf');
INSERT INTO PATIENT VALUES ('James Malone', '+7 (243) 063-26-24', '1926-03-29', 'francisbrandy@hotmail.com', 'Whatever black standard admit adult put.', '355', 'BSADoVJasYspRAlejf');
INSERT INTO ACCOUNTANT VALUES ('Joseph Thompson MD', 'ernestdavis@yahoo.com', 'mKmtamAD');
INSERT INTO PATIENT VALUES ('Joseph Thompson MD', '83846753103', '1905-02-28', 'ernestdavis@yahoo.com', 'Behavior home time add.', '238', 'mKmtamAD');
INSERT INTO ACCOUNTANT VALUES ('Ashley Bradley', 'hansenstanley@yahoo.com', 'kwSkZPRmS');
INSERT INTO PATIENT VALUES ('Ashley Bradley', '+7 (956) 892-23-84', '2007-09-24', 'hansenstanley@yahoo.com', 'Major before will return tend leave require.', '338', 'kwSkZPRmS');
INSERT INTO ACCOUNTANT VALUES ('Gina Mata', 'michael91@yahoo.com', 'lJdYVZYRgqgidFc');
INSERT INTO PATIENT VALUES ('Gina Mata', '+7 (608) 414-8767', '2012-01-09', 'michael91@yahoo.com', 'Line quite provide player.', '359', 'lJdYVZYRgqgidFc');
INSERT INTO ACCOUNTANT VALUES ('Mark Schultz', 'fmiller@gmail.com', 'cPiXtnsTyBRyRzJn');
INSERT INTO PATIENT VALUES ('Mark Schultz', '8 (678) 022-50-69', '1909-05-03', 'fmiller@gmail.com', 'Its professor never half thing media we.', '110', 'cPiXtnsTyBRyRzJn');
INSERT INTO ACCOUNTANT VALUES ('Jill Marshall', 'armstrongjohn@hotmail.com', 'UWvkDDHahZyE');
INSERT INTO PATIENT VALUES ('Jill Marshall', '8 (712) 089-01-90', '1989-04-09', 'armstrongjohn@hotmail.com', 'College evening low lay lead.', '199', 'UWvkDDHahZyE');
INSERT INTO ACCOUNTANT VALUES ('Allen Pineda', 'rholloway@gmail.com', 'MNsrXCGwQoIzTlYuOJ');
INSERT INTO PATIENT VALUES ('Allen Pineda', '8 850 080 3412', '1975-01-13', 'rholloway@gmail.com', 'Fall partner charge chair often.', '401', 'MNsrXCGwQoIzTlYuOJ');
INSERT INTO ACCOUNTANT VALUES ('Wesley Ayala', 'orobinson@yahoo.com', 'egjricMBWr');
INSERT INTO HOSPITAL_ADMINISTRATOR VALUES ('Wesley Ayala', 'orobinson@yahoo.com', 'egjricMBWr');
INSERT INTO ACCOUNTANT VALUES ('Teresa Gonzales', 'ysimmons@gmail.com', 'QrVnumXMYYbmBuLe');
INSERT INTO HOSPITAL_ADMINISTRATOR VALUES ('Teresa Gonzales', 'ysimmons@gmail.com', 'QrVnumXMYYbmBuLe');
INSERT INTO ACCOUNTANT VALUES ('Alex Brown', 'veronicalopez@hotmail.com', 'aHSqqkCdLlajgeRlXIf');
INSERT INTO HOSPITAL_ADMINISTRATOR VALUES ('Alex Brown', 'veronicalopez@hotmail.com', 'aHSqqkCdLlajgeRlXIf');
INSERT INTO ACCOUNTANT VALUES ('Casey Faulkner', 'gilbertshawn@yahoo.com', 'iaaXFVqDjTRGUmgJuhZT');
INSERT INTO LABORATORY_ASSISTANT VALUES ('Casey Faulkner', 'gilbertshawn@yahoo.com', 'iaaXFVqDjTRGUmgJuhZT');
INSERT INTO ACCOUNTANT VALUES ('Barbara Roberts', 'robyn58@hotmail.com', 'klygoJocDFWwwdpv');
INSERT INTO LABORATORY_ASSISTANT VALUES ('Barbara Roberts', 'robyn58@hotmail.com', 'klygoJocDFWwwdpv');
INSERT INTO ACCOUNTANT VALUES ('Tracy Long', 'qmiller@hotmail.com', 'IKYOEUFATChIZZJwCWf');
INSERT INTO LABORATORY_ASSISTANT VALUES ('Tracy Long', 'qmiller@hotmail.com', 'IKYOEUFATChIZZJwCWf');
INSERT INTO ACCOUNTANT VALUES ('Raymond Sanchez', 'tdickerson@gmail.com', 'IThTrtweCTi');
INSERT INTO LABORATORY_ASSISTANT VALUES ('Raymond Sanchez', 'tdickerson@gmail.com', 'IThTrtweCTi');
INSERT INTO ACCOUNTANT VALUES ('Kathryn Morgan', 'rachelpitts@yahoo.com', 'NsxiEmkUHdFppscOw');
INSERT INTO LABORATORY_ASSISTANT VALUES ('Kathryn Morgan', 'rachelpitts@yahoo.com', 'NsxiEmkUHdFppscOw');
INSERT INTO ACCOUNTANT VALUES ('Brandy James', 'sholland@hotmail.com', 'oNVTriIXxRLc');
INSERT INTO SYSTEM_ADMINISTRATOR VALUES ('Brandy James', 'sholland@hotmail.com', 'oNVTriIXxRLc');
INSERT INTO ACCOUNTANT VALUES ('Wendy Martinez', 'gmclaughlin@gmail.com', 'lMveMPdX');
INSERT INTO SYSTEM_ADMINISTRATOR VALUES ('Wendy Martinez', 'gmclaughlin@gmail.com', 'lMveMPdX');
INSERT INTO ACCOUNTANT VALUES ('Mr. Gene Hughes PhD', 'jeffrey47@yahoo.com', 'nsCqBZEyqHsZrsaidz');
INSERT INTO SYSTEM_ADMINISTRATOR VALUES ('Mr. Gene Hughes PhD', 'jeffrey47@yahoo.com', 'nsCqBZEyqHsZrsaidz');
INSERT INTO ACCOUNTANT VALUES ('John Estrada', 'brittanyjones@hotmail.com', 'DzrtEMnFbSjrnBkSbH');
INSERT INTO SYSTEM_ADMINISTRATOR VALUES ('John Estrada', 'brittanyjones@hotmail.com', 'DzrtEMnFbSjrnBkSbH');
INSERT INTO ACCOUNTANT VALUES ('Melissa Garcia', 'kara23@hotmail.com', 'hWDXKAzHwODpckGXd');
INSERT INTO DOCTOR VALUES ('Melissa Garcia', 'kara23@hotmail.com', 'hWDXKAzHwODpckGXd', 'diagnostic radiology');
INSERT INTO ACCOUNTANT VALUES ('Jennifer Smith', 'mcguiresarah@hotmail.com', 'idPmImuckeXNtMepPF');
INSERT INTO DOCTOR VALUES ('Jennifer Smith', 'mcguiresarah@hotmail.com', 'idPmImuckeXNtMepPF', 'emergency medicine');
INSERT INTO ACCOUNTANT VALUES ('Jennifer Ramirez', 'mcdonaldgabriel@gmail.com', 'IHqNaFng');
INSERT INTO DOCTOR VALUES ('Jennifer Ramirez', 'mcdonaldgabriel@gmail.com', 'IHqNaFng', 'emergency medicine');
INSERT INTO ACCOUNTANT VALUES ('Miss Shirley Holland', 'williamskatherine@yahoo.com', 'UfeZuaeTfqokk');
INSERT INTO DOCTOR VALUES ('Miss Shirley Holland', 'williamskatherine@yahoo.com', 'UfeZuaeTfqokk', 'emergency medicine');
INSERT INTO ACCOUNTANT VALUES ('Lindsey Williams', 'hpena@gmail.com', 'LDpatTOZuxFlyEZcu');
INSERT INTO DOCTOR VALUES ('Lindsey Williams', 'hpena@gmail.com', 'LDpatTOZuxFlyEZcu', 'diagnostic radiology');
INSERT INTO ACCOUNTANT VALUES ('Ronald Williams', 'rosemontgomery@hotmail.com', 'wYZxvXnTzWQqce');
INSERT INTO DOCTOR VALUES ('Ronald Williams', 'rosemontgomery@hotmail.com', 'wYZxvXnTzWQqce', 'diagnostic radiology');
INSERT INTO ACCOUNTANT VALUES ('Sarah Ingram', 'bbarron@hotmail.com', 'AleJHCkSMlpfqB');
INSERT INTO DOCTOR VALUES ('Sarah Ingram', 'bbarron@hotmail.com', 'AleJHCkSMlpfqB', 'emergency medicine');
INSERT INTO ACCOUNTANT VALUES ('Brandon Smith', 'brian91@gmail.com', 'midezrvZkEZGMEjz');
INSERT INTO DOCTOR VALUES ('Brandon Smith', 'brian91@gmail.com', 'midezrvZkEZGMEjz', 'anesthesiology');
INSERT INTO ACCOUNTANT VALUES ('Shannon Fowler', 'jonesbrandi@hotmail.com', 'vzANMVLgzfeBTPTlGDR');
INSERT INTO DOCTOR VALUES ('Shannon Fowler', 'jonesbrandi@hotmail.com', 'vzANMVLgzfeBTPTlGDR', 'diagnostic radiology');
INSERT INTO ACCOUNTANT VALUES ('Beth Phillips', 'cbaxter@gmail.com', 'jCUqVVMQVQItevIgHpPw');
INSERT INTO DOCTOR VALUES ('Beth Phillips', 'cbaxter@gmail.com', 'jCUqVVMQVQItevIgHpPw', 'diagnostic radiology');
INSERT INTO ACCOUNTANT VALUES ('Kelly Davis', 'ulucas@yahoo.com', 'zdOtZVlUqMffMGntRN');
INSERT INTO NURSE VALUES ('Kelly Davis', 'ulucas@yahoo.com', 'zdOtZVlUqMffMGntRN');
INSERT INTO ACCOUNTANT VALUES ('William James', 'leejeffrey@gmail.com', 'pYDooqFiQhnxaIwc');
INSERT INTO NURSE VALUES ('William James', 'leejeffrey@gmail.com', 'pYDooqFiQhnxaIwc');
INSERT INTO ACCOUNTANT VALUES ('Lauren Solis', 'bradley64@hotmail.com', 'HVkXuZms');
INSERT INTO NURSE VALUES ('Lauren Solis', 'bradley64@hotmail.com', 'HVkXuZms');
INSERT INTO ACCOUNTANT VALUES ('Yvonne Wilkinson', 'miguel85@yahoo.com', 'chqkbhSNQ');
INSERT INTO NURSE VALUES ('Yvonne Wilkinson', 'miguel85@yahoo.com', 'chqkbhSNQ');
INSERT INTO ACCOUNTANT VALUES ('Jeffery Leonard', 'ebond@yahoo.com', 'wJLzLPOqJxsDZV');
INSERT INTO NURSE VALUES ('Jeffery Leonard', 'ebond@yahoo.com', 'wJLzLPOqJxsDZV');
INSERT INTO ACCOUNTANT VALUES ('Samantha Bright', 'patrick06@hotmail.com', 'TJFePBIoJuBKE');
INSERT INTO NURSE VALUES ('Samantha Bright', 'patrick06@hotmail.com', 'TJFePBIoJuBKE');
INSERT INTO ACCOUNTANT VALUES ('Julie Sanford', 'leecarl@gmail.com', 'MAzhDalKDpTfEnEm');
INSERT INTO NURSE VALUES ('Julie Sanford', 'leecarl@gmail.com', 'MAzhDalKDpTfEnEm');
INSERT INTO ACCOUNTANT VALUES ('Susan Barnes', 'moorejames@hotmail.com', 'hLmusNTSTSwhcEIsBsgb');
INSERT INTO NURSE VALUES ('Susan Barnes', 'moorejames@hotmail.com', 'hLmusNTSTSwhcEIsBsgb');
INSERT INTO ACCOUNTANT VALUES ('Darren Martin', 'vanessa15@hotmail.com', 'EeqRYadgCIt');
INSERT INTO NURSE VALUES ('Darren Martin', 'vanessa15@hotmail.com', 'EeqRYadgCIt');
INSERT INTO ACCOUNTANT VALUES ('Jonathan Jones', 'jacobhayden@gmail.com', 'vjNxZAPxErLKY');
INSERT INTO NURSE VALUES ('Jonathan Jones', 'jacobhayden@gmail.com', 'vjNxZAPxErLKY');
INSERT INTO ACCOUNTANT VALUES ('Sierra Williams', 'coreywall@yahoo.com', 'ljDIdnNRTRkRIZeX');
INSERT INTO NURSE VALUES ('Sierra Williams', 'coreywall@yahoo.com', 'ljDIdnNRTRkRIZeX');
INSERT INTO ACCOUNTANT VALUES ('Alyssa Landry', 'lopezryan@gmail.com', 'RibTgEaMnKVENCDBVY');
INSERT INTO NURSE VALUES ('Alyssa Landry', 'lopezryan@gmail.com', 'RibTgEaMnKVENCDBVY');
INSERT INTO ACCOUNTANT VALUES ('Laurie Jones', 'mooneyrichard@hotmail.com', 'HOIeabfEXfR');
INSERT INTO NURSE VALUES ('Laurie Jones', 'mooneyrichard@hotmail.com', 'HOIeabfEXfR');
INSERT INTO ACCOUNTANT VALUES ('Edward Rodriguez', 'udennis@yahoo.com', 'qJZoqXnBqouhBwBp');
INSERT INTO NURSE VALUES ('Edward Rodriguez', 'udennis@yahoo.com', 'qJZoqXnBqouhBwBp');
INSERT INTO ACCOUNTANT VALUES ('Kelsey Hunter', 'kreynolds@hotmail.com', 'DQrJVtLOdM');
INSERT INTO NURSE VALUES ('Kelsey Hunter', 'kreynolds@hotmail.com', 'DQrJVtLOdM');
