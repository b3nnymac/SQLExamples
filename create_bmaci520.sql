CREATE TABLE MUSICIAN (
SIN int(9) NOT NULL PRIMARY KEY, 
first varchar(10),
last varchar(10),
dob date,
age int(3));

CREATE TABLE PROFMUSC (
SIN int(9) PRIMARY KEY, 
lastPlaceWorked varchar(20));

CREATE TABLE SONG (
songid int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (songid), 
descp varchar(50));

CREATE TABLE INSTRUMENT  (
instrid int NOT NULL AUTO_INCREMENT,
PRIMARY KEY (instrid), 
name varchar(50));

CREATE TABLE RECORDING  (
recnum int NOT NULL,
PRIMARY KEY (recnum), 
location varchar(50),
URL varchar(50),
recordingDate date);

CREATE TABLE ROLE   (
SIN int NOT NULL,
instrid int NOT NULL,
songid int NOT NULL,
recnum int NOT NULL,
FOREIGN KEY (SIN) REFERENCES MUSICIAN(SIN),
FOREIGN KEY (instrid) REFERENCES INSTRUMENT(instrid),
FOREIGN KEY (songid) REFERENCES SONG(songid), 
FOREIGN KEY (recnum) REFERENCES RECORDING(recnum),
PRIMARY KEY (SIN, instrid, songid, recnum));

INSERT INTO MUSICIAN (SIN, first, last, dob)
VALUES (927456221, "Isaac", "Brock", '1975-07-09'); 

INSERT INTO MUSICIAN (SIN, first, last, dob)
VALUES (484315467, "Jeremiah", "Green", '1977-03-04'); 

INSERT INTO MUSICIAN (SIN, first, last, dob)
VALUES (465878789, "Tom", "Peloso", '1979-05-02'); 

INSERT INTO MUSICIAN (SIN, first, last, dob)
VALUES (632589654, "Johnny", "Marr", '1963-10-31'); 

INSERT INTO MUSICIAN (SIN, first, last, dob)
VALUES (845213065, "Lisa", "Molinaro", '1980-12-14'); 

INSERT INTO INSTRUMENT (name)
VALUES ("banjo"); 

INSERT INTO INSTRUMENT (name)
VALUES ("drums"); 

INSERT INTO INSTRUMENT (name)
VALUES ("electric guitar"); 

INSERT INTO INSTRUMENT (name)
VALUES ("upright bass"); 

INSERT INTO INSTRUMENT (name)
VALUES ("viola"); 

INSERT INTO SONG (descp)
VALUES ("Out of Gas"); 

INSERT INTO SONG (descp)
VALUES ("Teeth like God's Shoeshine"); 

INSERT INTO SONG (descp)
VALUES ("Truckers Atlas");

INSERT INTO SONG (descp)
VALUES ("Bankrupt on Selling");

INSERT INTO SONG (descp)
VALUES ("Polar Opposites");

UPDATE MUSICIAN
SET age =((DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(`dob`, '%Y')) - 
    (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(`dob`, '00-%m-%d')));
	
DROP FUNCTION getAge;
DELIMITER $$
CREATE FUNCTION getAge ( birthDate DATE )
 RETURNS INT
BEGIN
DECLARE age INT;
DECLARE currentDate DATE;
SET age = YEAR(CURDATE()) - YEAR(birthDate);
RETURN age;
END$$
delimiter;

DROP PROCEDURE ADD_PROF_MUSICIAN;
DELIMITER $$
CREATE PROCEDURE ADD_PROF_MUSICIAN( 
IN SIN_local int(9), 
IN first_local varchar(10),
IN last_local varchar(10),
IN dob_local date, 
IN lastPlaceWorked_local varchar(20))
BEGIN
INSERT INTO MUSICIAN (SIN, first, last, dob)
VALUES (SIN_local, first_local, last_local, dob_local);
INSERT INTO  PROFMUSC (SIN, lastPlaceWorked )
VALUES(SIN_local, lastPlaceWorked_local);
END$$
delimiter ;

DROP PROCEDURE MOD_MUSC_DOB;
DELIMITER $$
CREATE PROCEDURE MOD_MUSC_DOB( 	
IN SIN_local int(9), 
IN dob_local date)
BEGIN
IF (Select DOB from MUSICIAN WHERE SIN=SIN_local) IS NOT NULL THEN 
UPDATE MUSICIAN SET DOB = dob_local where SIN_local = SIN;
END IF;
END$$
delimiter ;

DROP PROCEDURE ADD_PERFORMANCE;
DELIMITER $$
CREATE PROCEDURE ADD_PERFORMANCE (
IN recordingNum INT, 
IN musicSIN INT(9), 
IN songDesc varchar(50), 
IN instruName varchar(50),
IN recLocation varchar(50))
BEGIN
INSERT INTO RECORDING(recnum, location)
VALUES(recordingNum, recLocation);
INSERT INTO ROLE(SIN, instrid, songid, recnum)
VALUES(musicSIN,  
(SELECT instrid FROM INSTRUMENT WHERE instruName=name),
(SELECT songid FROM SONG WHERE songDesc=descp),
recordingNum);
END$$
delimiter ;

DROP TRIGGER update_age_on_insert;
delimiter $$
CREATE TRIGGER update_age_on_insert
BEFORE INSERT ON MUSICIAN
FOR EACH ROW
BEGIN
Set new.age = getAge(new.dob);
END $$
delimiter ;

DROP TRIGGER update_age_on_musician_update;
delimiter $$
CREATE TRIGGER update_age_on_musician_update
BEFORE UPDATE ON MUSICIAN
FOR EACH ROW
BEGIN
Set new.age = getAge(new.dob);
END $$
delimiter ;

CREATE TABLE RECORDING_AUDIT(
recording_audit_number int NOT NULL AUTO_INCREMENT,
recnum int NOT NULL,
location varchar(50) NOT NULL,
change_date date,
FOREIGN KEY (recnum) REFERENCES RECORDING(recnum),
FOREIGN KEY (location) REFERENCES RECORDING(location),
PRIMARY KEY (recording_audit_number));

DROP TRIGGER record_audit_trigger
delimiter $$
CREATE TRIGGER record_audit_trigger
AFTER UPDATE ON RECORDING FOR EACH ROW BEGIN
   INSERT INTO RECORDING_AUDIT (recnum, location, change_date)
	VALUES (NEW.recnum, NEW.location, NOW());
END$$
delimiter ;












