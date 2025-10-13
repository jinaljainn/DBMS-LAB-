show databases;
create database IF NOT exists newdatabase174;
show databases;
use newdatabase174;

CREATE TABLE Branch (
  branch_name VARCHAR(30) PRIMARY KEY,
  branch_city VARCHAR(25),
  assets REAL
);

CREATE TABLE BankAccount (
  accno INT PRIMARY KEY,
  branch_name VARCHAR(30),
  balance REAL,
  FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE BankCustomer (
  customer_name VARCHAR(30) PRIMARY KEY,
  customer_street VARCHAR(40),
  customer_city VARCHAR(30)
);

CREATE TABLE Depositer (
  customer_name VARCHAR(30),
  accno INT,
  PRIMARY KEY (customer_name, accno),
  FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
  FOREIGN KEY (accno) REFERENCES BankAccount(accno)
);

CREATE TABLE Loan (
  loan_number INT PRIMARY KEY,
  branch_name VARCHAR(30),
  amount REAL,
  FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

INSERT INTO Branch VALUES
('SBI_Chamrajpet', 'Bangalore', 5000000),
('SBI_ResidencyRoad', 'Bangalore', 1000000),
('SBI_ShivajiRoad', 'Bombay', 2000000),
('SBI_ParliamentRoad', 'Delhi', 1500000),
('SBI_Jantarmantar', 'Delhi', 2500000);

INSERT INTO BankAccount VALUES
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParliamentRoad', 9000),
(5, 'SBI_Jantarmantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),
(8, 'SBI_ResidencyRoad', 4000),
(9, 'SBI_ParliamentRoad', 3000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);

INSERT INTO BankCustomer VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannergatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');

INSERT INTO Depositer VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikil', 9),
('Dinesh', 10),
('Nikil', 11);

INSERT INTO Loan VALUES
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParliamentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000);

COMMIT;

SELECT * FROM Branch;
SELECT * FROM BankAccount;
SELECT * FROM BankCustomer;
SELECT * FROM Depositer;
SELECT * FROM Loan;

SELECT branch_name, (assets / 100000) AS 'assets in lakhs'
FROM Branch;

SELECT d.customer_name
FROM Depositer d
JOIN BankAccount b ON d.accno = b.accno
WHERE b.branch_name = 'SBI_ResidencyRoad'
GROUP BY d.customer_name
HAVING COUNT(d.accno) >= 2;

SELECT d.customer_name
FROM Depositer d
JOIN BankAccount b ON d.accno = b.accno
JOIN Branch br ON b.branch_name = br.branch_name
WHERE br.branch_city = 'Delhi'
GROUP BY d.customer_name
HAVING COUNT(DISTINCT br.branch_name) = (
  SELECT COUNT(*) FROM Branch WHERE branch_city = 'Delhi'
);

DELETE FROM BankAccount
WHERE branch_name IN (
  SELECT branch_name FROM Branch WHERE branch_city = 'Bombay'
);

SELECT * FROM Loan ORDER BY amount DESC;

SELECT customer_name FROM Depositer
UNION
SELECT DISTINCT d.customer_name
FROM Depositer d
JOIN Loan l ON l.branch_name IN (SELECT branch_name FROM Branch);

CREATE VIEW Branch_Total_Loan AS
SELECT branch_name, SUM(amount) AS total_loan
FROM Loan
GROUP BY branch_name;

SELECT * FROM Branch_Total_Loan;

UPDATE BankAccount
SET balance = balance * 1.05;

SELECT * FROM BankAccount;
