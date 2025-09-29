show databases;
create database IF NOT exists newdatabase57;
show databases;
use newdatabase57;

CREATE TABLE person3 (
  driver_id VARCHAR(10) PRIMARY KEY,
  name VARCHAR(50),
  address VARCHAR(100)
);

CREATE TABLE car3 (
  reg_num VARCHAR(15) PRIMARY KEY,
  model VARCHAR(30),
  year INT
);

CREATE TABLE accident3 (
  report_num INT PRIMARY KEY,
  accident_date DATE,
  location VARCHAR(100)
);

CREATE TABLE owns3 (
  driver_id VARCHAR(10),
  reg_num VARCHAR(15),
  PRIMARY KEY (driver_id, reg_num)
);

CREATE TABLE participated3 (
  driver_id VARCHAR(10),
  reg_num VARCHAR(15),
  report_num INT,
  damage_amount INT,
  PRIMARY KEY (driver_id, reg_num, report_num)
);

INSERT INTO person3 VALUES
('A01', 'Richard', 'Srinivas Nagar'),
('A02', 'Pradeep', 'Rajajinagar'),
('A03', 'Smith', 'Ashoknagar'),
('A04', 'Venu', 'N.R.Colony'),
('A05', 'John', 'Hanumanth Nagar');

INSERT INTO car3 VALUES
('KA052250', 'Indica', 1990),
('KA031181', 'Lancer', 1957),
('KA095477', 'Toyota', 1998),
('KA053408', 'Honda', 2008),
('KA041702', 'Audi', 2005);

INSERT INTO accident3 VALUES
(11, '2003-01-01', 'Mysore Road'),
(12, '2004-02-02', 'Southend Circle'),
(13, '2003-01-21', 'Bulltemple Road'),
(14, '2008-02-17', 'Mysore Road'),
(15, '2005-03-04', 'Kanakpura Road');

INSERT INTO owns3 VALUES
('A01', 'KA052250'),
('A02', 'KA053408'),
('A04', 'KA031181'),
('A03', 'KA095477'),
('A05', 'KA041702');

INSERT INTO participated3 VALUES
('A01', 'KA052250', 11, 10000),
('A02', 'KA053408', 12, 50000),
('A03', 'KA095477', 13, 25000),
('A04', 'KA031181', 14, 3000),
('A05', 'KA041702', 15, 5000);

UPDATE participated3
SET damage_amount = 25000
WHERE reg_num = 'KA053408' AND report_num = 12;

INSERT INTO accident3 (report_num, accident_date, location)
VALUES (16, '2008-03-15', 'Domlur');

SELECT accident_date, location FROM accident3;

SELECT DISTINCT driver_id FROM participated3 WHERE damage_amount >= 25000;
