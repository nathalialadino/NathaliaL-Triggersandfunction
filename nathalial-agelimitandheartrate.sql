use ahi
use synthea

CREATE TABLE nathalialpatients1 (
id INT AUTO_INCREMENT PRIMARY KEY,
patientUID INT NOT NULL,
lastname VARCHAR(50) NOT NULL,
age INT NOT NULL,
CONSTRAINT id UNIQUE (patientUID)
);

### Create a trigger code

delimiter $$
CREATE TRIGGER agelimit1 BEFORE INSERT ON nathalialpatients1
FOR EACH ROW
BEGIN
IF NEW.age <= 18 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: Patient age must exceed 18 yrs old!';
END IF;
END; $$
delimiter ;

INSERT INTO nathalialpatients1 (patientUID, lastname, age) 
VALUES (123156, 'Ortiz', 8);

INSERT INTO nathalialpatients1 (patientUID, lastname, age) 
VALUES (239450, 'Smith', 45);

SELECT * FROM synthea.nathalialpatients1;

### Create a function code

use synthea
SET SESSION sql_mode = ''

delimiter $$
CREATE FUNCTION heartrateclass(VALUE DECIMAL(10,2)) 
RETURNS VARCHAR(20) 
BEGIN
DECLARE HeartRate VARCHAR(20);
	IF VALUE > 89.0 THEN
		SET HeartRate = "high";
	ELSEIF VALUE BETWEEN 60.0 AND 89.0 THEN
		SET HeartRate = "normal";
END IF;
-- return the heart rate category
RETURN (HeartRate);
END; $$
delimiter ; 

SELECT
DESCRIPTION,
VALUE,
heartrateclass(VALUE)
FROM observations
WHERE CODE='8867-4'; 






