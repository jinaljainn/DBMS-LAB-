show databases;
create database IF NOT exists newdatabase56;
show databases;
use newdatabase56;

CREATE TABLE person (
    driver_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(20),
    address VARCHAR(30)
);
DESC person;
CREATE TABLE car (
    reg_num VARCHAR(10) PRIMARY KEY,
    model VARCHAR(10),
    year INT
);
DESC car;
CREATE TABLE accident1 (
    report_num INT PRIMARY KEY,
    accident_date DATE,
    location VARCHAR(20)
);
DESC accident1;

CREATE TABLE owns (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    PRIMARY KEY(driver_id, reg_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES car(reg_num)
);
DESC owns;
CREATE TABLE participated1(
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY(driver_id, reg_num, report_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES car(reg_num),
    FOREIGN KEY (report_num) REFERENCES accident1(report_num)
);
DESC participated1;

INSERT INTO person VALUES
('A01', 'Richard', 'Srinivas nagar'),
('D002', 'Pradeep', 'Rajaji nagar'),
('D003', 'Smith', 'Ashok nagar'),
('D004', 'Venu', 'NR Colony'),
('D005', 'Jhon', 'Hanumanth Nagar');

INSERT INTO car VALUES
('C100', 'Toyota', 2018),
('C101', 'Honda', 2017),
('C102', 'Ford', 2019),
('C103', 'BMW', 2020),
('C104', 'Audi', 2021);

INSERT INTO accident VALUES
(1001, '2024-03-15', 'Downtown'),
(1002, '2024-04-20', 'Uptown'),
(1003, '2024-05-05', 'Suburbs'),
(1004, '2024-06-10', 'City Center'),
(1005, '2024-07-25', 'Airport');

INSERT INTO owns VALUES
('D001', 'C100'),
('D002', 'C101'),
('D003', 'C102'),
('D004', 'C103'),
('D005', 'C104');

INSERT INTO participated (driver_id, reg_num,report_num, damage_amount) VALUES
('D002' , 'C101', 1002 , 30000),
('D003' , 'C102', 1003 , 15000),
('D004' , 'C103', 1004 , 40000),
('D005' , 'C104', 1005 , 10000);
select * from participated;

SELECT accident_date, location FROM accident;

SELECT DISTINCT driver_id
FROM participated
WHERE damage_amount >= 25000;