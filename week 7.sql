CREATE DATABASE week7;
USE week7;

-- 1️⃣ Create Tables
CREATE TABLE Supplier(
  sid INT PRIMARY KEY,
  sname VARCHAR(30),
  address VARCHAR(50)
);
CREATE TABLE Part(
  pid INT PRIMARY KEY,
  pname VARCHAR(30),
  color VARCHAR(10)
);
CREATE TABLE Catalog(
  sid INT,
  pid INT,
  cost DECIMAL(10,2),
  PRIMARY KEY(sid,pid),
  FOREIGN KEY(sid) REFERENCES Supplier(sid),
  FOREIGN KEY(pid) REFERENCES Part(pid)
);

-- 2️⃣ Insert Records
INSERT INTO Supplier VALUES
(10001,'Acme Widget','Delhi'),
(10002,'Johns','Bangalore'),
(10003,'Global Parts','Mumbai'),
(10004,'Reliance','Hyderabad');

INSERT INTO Part VALUES
(20001,'Book','Red'),
(20002,'Charger','Red'),
(20003,'Mobile','Blue'),
(20004,'Pen','Black'),
(20005,'Pencil','Red');

INSERT INTO Catalog VALUES
(10001,20001,500),(10001,20002,700),(10001,20003,900),(10001,20004,650),(10001,20005,800),
(10002,20001,550),(10002,20002,600),(10002,20003,850),(10002,20005,750),
(10003,20001,520),(10003,20003,870),(10003,20004,700),
(10004,20001,700),(10004,20002,800),(10004,20003,950),(10004,20004,720),(10004,20005,850);

-- 3️⃣ Pnames of parts having some supplier
SELECT DISTINCT p.pname
FROM Part p JOIN Catalog c ON p.pid=c.pid;

-- 4️⃣ Snames of suppliers who supply every part
SELECT s.sname
FROM Supplier s
WHERE NOT EXISTS (
  SELECT pid FROM Part
  WHERE pid NOT IN (
    SELECT c.pid FROM Catalog c WHERE c.sid=s.sid
  )
);

-- 5️⃣ Snames of suppliers who supply every red part
SELECT s.sname
FROM Supplier s
WHERE NOT EXISTS (
  SELECT pid FROM Part WHERE color='Red'
  AND pid NOT IN (
    SELECT c.pid FROM Catalog c WHERE c.sid=s.sid
  )
);

-- 6️⃣ Pnames of parts supplied by Acme Widget only
SELECT p.pname
FROM Part p
WHERE p.pid IN (
  SELECT c.pid FROM Catalog c JOIN Supplier s ON c.sid=s.sid
  WHERE s.sname='Acme Widget'
)
AND p.pid NOT IN (
  SELECT c.pid FROM Catalog c JOIN Supplier s ON c.sid=s.sid
  WHERE s.sname!='Acme Widget'
);

-- 7️⃣ Sids of suppliers charging > avg cost for some part
SELECT DISTINCT c1.sid
FROM Catalog c1
WHERE c1.cost > (
  SELECT AVG(c2.cost) FROM Catalog c2
  WHERE c2.pid=c1.pid
);

-- 8️⃣ For each part, sname of supplier charging most for that part
SELECT p.pid,s.sname
FROM Catalog c
JOIN Supplier s ON c.sid=s.sid
JOIN Part p ON c.pid=p.pid
WHERE c.cost = (
  SELECT MAX(cost) FROM Catalog WHERE pid=p.pid
);
