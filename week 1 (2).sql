show databases;

create database IF NOT exists newdatabase25;

show databases;

use newdatabase25;

CREATE TABLE PERSON (
driver_id VARCHAR(10) PRIMARY KEY,
name VARCHAR(50),
address VARCHAR(100)
);

CREATE TABLE CAR (
reg_num VARCHAR(10) PRIMARY KEY,
model VARCHAR(30),
year INT,
address VARCHAR(100)
);

CREATE TABLE ACCIDENT (
report_num INT PRIMARY KEY,
accident_date DATE,
location VARCHAR(100)
);

CREATE TABLE OWNS (
driver_id VARCHAR(10),
reg_num VARCHAR(10),
PRIMARY KEY(driver_id, reg_num),
FOREIGN KEY(driver_id) REFERENCES PERSON(driver_id),
FOREIGN KEY(reg_num) REFERENCES CAR(reg_num)
);

CREATE TABLE PARTICIPATED (
driver_id VARCHAR(10),
reg_num VARCHAR(10),
report_num INT,
damage_amount INT,
PRIMARY KEY(driver_id, reg_num, report_num),
FOREIGN KEY(driver_id) REFERENCES PERSON(driver_id),
FOREIGN KEY(reg_num) REFERENCES CAR(reg_num),
FOREIGN KEY(report_num) REFERENCES ACCIDENT(report_num)
);
INSERT INTO PERSON VALUES
('D1','Ravi Kumar','Bengaluru'),
('D2','Anita Sharma','Mysuru'),
('D3','John Mathew','Hubli'),
('D4','Priya Singh','Belagavi'),
('D5','Arun Das','Mangaluru');

INSERT INTO CAR VALUES
('KA01AB1234','Hyundai i20',2020,'Bengaluru'),
('KA02CD5678','Maruti Swift',2019,'Mysuru'),
('KA03EF9012','Tata Nexon',2021,'Hubli'),
('KA04GH3456','Honda City',2018,'Belagavi'),
('KA05IJ7890','Ford EcoSport',2020,'Mangaluru');

INSERT INTO ACCIDENT VALUES
(101,'2023-01-10','MG Road'),
(102,'2023-02-14','Ring Road'),
(103,'2023-03-20','Airport Road'),
(104,'2023-04-05','NH 48'),
(105,'2023-05-12','Brigade Road');

INSERT INTO OWNS VALUES
('D1','KA01AB1234'),
('D2','KA02CD5678'),
('D3','KA03EF9012'),
('D4','KA04GH3456'),
('D5','KA05IJ7890');

INSERT INTO PARTICIPATED VALUES
('D1','KA01AB1234',101,15000),
('D2','KA02CD5678',102,30000),
('D3','KA03EF9012',103,25000),
('D4','KA04GH3456',104,5000),
('D5','KA05IJ7890',105,40000);

SELECT accident_date, location
FROM ACCIDENT;

SELECT DISTINCT driver_id
FROM PARTICIPATED
WHERE damage_amount >= 25000;

SELECT P.driver_id, P.name, Pa.damage_amount
FROM PERSON P
JOIN PARTICIPATED Pa ON P.driver_id = Pa.driver_id
WHERE Pa.damage_amount >= 25000;

SELECT * FROM PARTICIPATED ORDER BY damage_amount DESC;

SELECT AVG(damage_amount) FROM PARTICIPATED;

SELECT NAME FROM PERSON A, PARTICIPATED B WHERE A.DRIVER_ID = B.DRIVER_ID AND damage_amount>(SELECT AVG(damage_amount) FROM PARTICIPATED);

SELECT MAX(damage_amount) FROM PARTICIPATED;

