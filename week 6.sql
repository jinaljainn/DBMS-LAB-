CREATE DATABASE emp74;
USE emp74;

CREATE TABLE dept(
  deptno DECIMAL(2,0) PRIMARY KEY,
  dname VARCHAR(14),
  loc VARCHAR(13)
);

CREATE TABLE emp(
  empno DECIMAL(4,0) PRIMARY KEY,
  ename VARCHAR(10),
  mgr_no DECIMAL(4,0),
  hiredate DATE,
  sal DECIMAL(9,2),
  deptno DECIMAL(2,0),
  FOREIGN KEY(deptno) REFERENCES dept(deptno)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE incentives(
  empno DECIMAL(4,0),
  incentive_date DATE,
  incentive_amount DECIMAL(10,2),
  PRIMARY KEY(empno,incentive_date),
  FOREIGN KEY(empno) REFERENCES emp(empno)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE project(
  pno INT PRIMARY KEY,
  pname VARCHAR(30),
  ploc VARCHAR(30)
);

CREATE TABLE assigned_to(
  empno DECIMAL(4,0),
  pno INT,
  job_role VARCHAR(30),
  PRIMARY KEY(empno,pno),
  FOREIGN KEY(empno) REFERENCES emp(empno)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(pno) REFERENCES project(pno)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO dept VALUES
(10,'ACCOUNTING','MUMBAI'),
(20,'RESEARCH','BENGALURU'),
(30,'SALES','DELHI'),
(40,'OPERATIONS','CHENNAI'),
(50,'HR','PUNE'),
(60,'MARKETING','KOLKATA');

INSERT INTO emp VALUES
(7369,'ADARSH',7902,'2012-12-17',80000,20),
(7499,'SHRUTHI',7698,'2013-02-20',16000,30),
(7521,'ANVITHA',7698,'2015-02-22',12500,30),
(7566,'TANVIR',7839,'2008-04-02',29750,20),
(7654,'RAMESH',7698,'2014-09-28',12500,30),
(7698,'KUMAR',7839,'2015-05-01',28500,30),
(7782,'CLARK',7839,'2017-06-09',24500,10),
(7788,'SCOTT',7566,'2010-12-09',30000,20),
(7839,'KING',NULL,'2009-11-17',500000,10),
(7900,'JAMES',7698,'2017-12-03',9500,30),
(7902,'FORD',7566,'2010-12-03',30000,20),
(7934,'MILLER',7782,'2019-03-05',13000,10);

INSERT INTO incentives VALUES
(7499,'2019-01-01',5000),(7521,'2019-01-02',2500),
(7566,'2019-01-03',5070),(7654,'2019-01-04',2000),
(7698,'2019-01-05',9000),(7698,'2019-02-01',4500),
(7566,'2019-02-01',3000),(7839,'2019-01-01',12000),
(7900,'2019-01-02',1500);

INSERT INTO project VALUES
(101,'AI PROJECT','BENGALURU'),
(102,'IOT','HYDERABAD'),
(103,'BLOCKCHAIN','DELHI'),
(104,'DATA SCIENCE','MYSURU'),
(105,'AUTONOMOUS SYSTEMS','PUNE'),
(106,'ROBOTICS','CHENNAI');

INSERT INTO assigned_to VALUES
(7499,101,'Software Engineer'),
(7521,101,'Software Architect'),
(7566,101,'Project Manager'),
(7654,102,'Sales'),
(7521,102,'Software Engineer'),
(7499,102,'Software Engineer'),
(7654,103,'Cyber Security'),
(7698,104,'Software Engineer'),
(7900,105,'Software Engineer'),
(7839,104,'General Manager'),
(7788,106,'Analyst'),
(7934,101,'Intern');

SELECT m.ename AS Manager_Name, COUNT(*) AS No_of_Employees
FROM emp e JOIN emp m ON e.mgr_no = m.empno
GROUP BY m.ename
HAVING COUNT(*) = (
  SELECT MAX(mycount)
  FROM (SELECT COUNT(*) mycount FROM emp GROUP BY mgr_no) t
);

SELECT m.ename AS Manager_Name, m.sal AS Manager_Salary
FROM emp m
WHERE m.empno IN (SELECT mgr_no FROM emp)
AND m.sal > (
  SELECT AVG(e.sal)
  FROM emp e
  WHERE e.mgr_no = m.empno
);

SELECT DISTINCT d.dname, e.ename AS Second_Top_Manager
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.mgr_no IN (
  SELECT empno FROM emp WHERE mgr_no IS NULL
)
AND e.empno NOT IN (
  SELECT empno FROM emp WHERE mgr_no IS NULL
);

SELECT e.*
FROM emp e
JOIN incentives i ON e.empno = i.empno
WHERE MONTH(i.incentive_date) = 1 AND YEAR(i.incentive_date) = 2019
AND i.incentive_amount = (
  SELECT MAX(incentive_amount)
  FROM incentives
  WHERE incentive_amount < (
    SELECT MAX(incentive_amount)
    FROM incentives
    WHERE MONTH(incentive_date) = 1 AND YEAR(incentive_date) = 2019
  )
);

SELECT e.ename, e.empno, e.deptno
FROM emp e
WHERE e.deptno = (
  SELECT m.deptno FROM emp m WHERE m.empno = e.mgr_no
);
