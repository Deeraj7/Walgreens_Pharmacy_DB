ALTER TABLE employee
ADD gender CHAR(1) constraint invalid_employee_gender check (gender IN ('M', 'F', 'O'));

CREATE TABLE SSN (
  ssn CHAR(9) PRIMARY KEY,
  first_name VARCHAR2(100) NOT NULL,
  last_name VARCHAR2(100) NOT NULL,
  d_o_b TIMESTAMP NOT NULL,
  gender VARCHAR2(10) NOT NULL,
  phone_number VARCHAR2(20) NOT NULL CONSTRAINT invalid_ssn_phone_number CHECK (REGEXP_LIKE(phone_number, '^\(\d{3}\) \d{3}-\d{4}$'))
);

INSERT INTO SSN (ssn, first_name, last_name, d_o_b, gender, phone_number)
SELECT ssn, first_name, last_name, d_o_b, gender, phone_number FROM Employee;

ALTER TABLE Employee
DROP COLUMN first_name;

ALTER TABLE Employee
DROP COLUMN last_name;

ALTER TABLE Employee
DROP COLUMN d_o_b;

ALTER TABLE Employee
DROP COLUMN gender;

ALTER TABLE Employee
DROP COLUMN phone_number;

ALTER TABLE Employee
ADD CONSTRAINT fk_employee_ssn
FOREIGN KEY (SSN) REFERENCES SSN (ssn);

ALTER TABLE doctor
ADD d_o_b TIMESTAMP;

Update doctor set d_o_b = TO_TIMESTAMP('1985-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS');

INSERT INTO SSN (ssn, first_name, last_name, d_o_b, gender, phone_number)
SELECT ssn, first_name, last_name, d_o_b, gender, phone_number FROM doctor;

ALTER TABLE Doctor
DROP COLUMN first_name;

ALTER TABLE Doctor
DROP COLUMN last_name;

ALTER TABLE Doctor
DROP COLUMN d_o_b;

ALTER TABLE Doctor
DROP COLUMN gender;

ALTER TABLE Doctor
DROP COLUMN phone_number;


CREATE TABLE national_identification (
  national_identification_number VARCHAR2(9) PRIMARY KEY,
  first_name VARCHAR2(100) NOT NULL,
  last_name VARCHAR2(100) NOT NULL,
  age NUMBER NOT NULL constraint invalid_ni_age CHECK (age > 0),
  phone_number VARCHAR2(20) NOT NULL UNIQUE  constraint invalid_ni_phone_number CHECK (REGEXP_LIKE(phone_number, '^\(\d{3}\) \d{3}-\d{4}$')),
  gender CHAR(1) NOT NULL constraint invalid_patient_gender CHECK  (gender IN ('M', 'F', 'O'))
);

INSERT INTO national_identification (national_identification_number, first_name, last_name, age, phone_number, gender)
SELECT national_identification_number, first_name, last_name, age, phone_number, gender
FROM Patient

ALTER TABLE Patient
DROP COLUMN first_name;

ALTER TABLE Patient
DROP COLUMN last_name;

ALTER TABLE Patient
DROP COLUMN age;

ALTER TABLE Patient
DROP COLUMN phone_number;

ALTER TABLE Patient
DROP COLUMN gender;

