connect homer/tiger;
SET PAGESIZE 500;
SET LINESIZE 500;

DROP TABLE Skill      CASCADE CONSTRAINT;
DROP TABLE Training   CASCADE CONSTRAINT;
DROP TABLE Department CASCADE CONSTRAINT;
DROP TABLE Employee   CASCADE CONSTRAINT;
DROP TABLE Client     CASCADE CONSTRAINT;
DROP TABLE Project    CASCADE CONSTRAINT;
DROP TABLE Assignment CASCADE CONSTRAINT;

CREATE TABLE Skill
(Code NUMBER(4) CONSTRAINT Skill_Code_PK PRIMARY KEY,
 Name VARCHAR2(15),
 Category VARCHAR2(15),
 CONSTRAINT Skill_Code_CK CHECK(Code >= 0),
 CONSTRAINT Skill_Category_CK CHECK 
            (Category IN ('Communication','Programming',
             'Management')),
 CONSTRAINT SKill_Name_CK CHECK (Name IN ('Speaking','Java','C++', 'Python', 
                           'Leadership','Writing','Decision Making')));

CREATE TABLE Department
(Dept_Code  NUMBER(2) CONSTRAINT Department_Dept_Code_PK PRIMARY KEY,
 Name       VARCHAR2(15),
 Location   VARCHAR2(15),
 Phone      VARCHAR2(12),
 Manager_ID NUMBER(4),
 CONSTRAINT Department_Manager_ID_CK CHECK (Manager_ID > 0));

CREATE TABLE Employee
(Emp_Num    NUMBER(4) CONSTRAINT Employee_Emp_Num_PK PRIMARY KEY,
 LNAME      VARCHAR2(10),
 FNAME      VARCHAR2(10),
 DOB        DATE,
 Hire_Date  DATE DEFAULT SYSDATE,
 Super_ID   NUMBER(4),
 Dept_Code  NUMBER(4),
 CONSTRAINT Employee_Dept_Code_FK FOREIGN KEY(Dept_Code) REFERENCES Department(Dept_Code),
 CONSTRAINT Employee_Super_ID_FK  FOREIGN KEY(Super_ID)  REFERENCES Employee (Emp_Num));

CREATE TABLE Training
(Train_Num     NUMBER(4) CONSTRAINT Training_Train_Num_PK PRIMARY KEY,
 Code          NUMBER(4),
 Emp_Num       NUMBER(4),
 Name          VARCHAR2(30),
 Date_Acquired DATE,
 Comments      VARCHAR2(70),
 CONSTRAINT Training_Code_FK    FOREIGN KEY (Code)    REFERENCES Skill (Code),
 CONSTRAINT Training_Emp_Num_FK FOREIGN KEY (Emp_Num) REFERENCES Employee (Emp_NUM));

CREATE TABLE Client
(Client_ID       NUMBER(4)           CONSTRAINT CLIENT_CLIENT_ID_PK PRIMARY KEY, 
 Name            VARCHAR2(12),
 Street          VARCHAR2(20),
 City            VARCHAR2(12),
 State           VARCHAR2(2)        CONSTRAINT CLIENT_STATE_NN NOT NULL
    CONSTRAINT CLIENT_STATE_CK
     CHECK (STATE IN ('AL', 'AK','AZ','AR','CA','CO','CT',
    'DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD',
    'MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM',
    'NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN',
    'TN','TX','UT','VT','VA','WA','WV','WI','WY')),
 Zip_Code        VARCHAR2(5),
 Industry        VARCHAR2(11)     CONSTRAINT CLIENT_INDUSTRY_CK
     CHECK (INDUSTRY IN ('Internet', 'E-Commerce', 'Banking', 'Investment')) , 
 Web_Address     VARCHAR2(20), 
 Phone           VARCHAR2(12), 
 Contact_LName   VARCHAR2(10), 
 Contact_Fname   VARCHAR2(10));


CREATE TABLE Project
(Proj_Number   NUMBER(4)          CONSTRAINT Project_PROJ_NUMBER_PK PRIMARY KEY,
 NAME          VARCHAR2(30),
 Start_Date    DATE               DEFAULT SYSDATE, 
 Total_Cost    NUMBER(6,2)          CONSTRAINT PROJECT_TOTAL_COST_CK
			    CHECK (TOTAL_COST > 0),								
 Dept_Code    NUMBER(4)           CONSTRAINT PROJECT_DEPT_CODE_FK			 
			    REFERENCES DEPARTMENT (DEPT_CODE),   
 Client_ID     NUMBER(4)               CONSTRAINT PROJECT_CLIENT_ID_FK
			    REFERENCES CLIENT (CLIENT_ID),    
 Code          NUMBER(4)              CONSTRAINT PROJECT_CODE_FK
			    REFERENCES SKILL (CODE));   

CREATE TABLE Assignment
(Assign_Num     NUMBER(4)   CONSTRAINT Assignment_Assign_Num_PK PRIMARY KEY, 
 Proj_Number    NUMBER(4)  CONSTRAINT Assignment_Proj_Number_FK
			REFERENCES PROJECT (PROJ_NUMBER),
 Emp_Num        NUMBER(4)    CONSTRAINT Assignment_Emp_Numb_FK
			REFERENCES EMPLOYEE (Emp_Num), 
 Date_Assigned  DATE           DEFAULT SYSDATE,
 Date_Ended     DATE,
 Hours_Used     NUMBER(4)   CONSTRAINT Assignment_Hours_Used_CK CHECK (Hours_Used >= 0),
 CONSTRAINT Assignment_Date_Ended_CK CHECK (Date_Ended >= Date_Assigned));  


INSERT INTO SKILL
VALUES(01, 'Speaking', 'Communication');
INSERT INTO SKILL
VALUES(02, 'Java', 'Programming');
INSERT INTO SKILL
VALUES(03, 'C++', 'Programming');
INSERT INTO SKILL
VALUES(04, 'Python', 'Programming');
INSERT INTO SKILL
VALUES(05,'Leadership', 'Management');
INSERT INTO SKILL
Values(06,'Writing', 'Communication');
INSERT INTO SKILL
VALUES(07, 'Decision Making', 'Management');

INSERT INTO DEPARTMENT
VALUES (01, 'Marketing', 'A100', '800-111-1111', '1003');
INSERT INTO DEPARTMENT
VALUES (02, 'Finance', 'B101', '800-111-2222', '1004');
INSERT INTO DEPARTMENT
VALUES (03, 'Human Resources', 'A201', '800-111-1234', '1005');
INSERT INTO DEPARTMENT
VALUES (04, 'IT', 'B103', '800-111-5555', '1006');
INSERT INTO DEPARTMENT
VALUES (05, 'Strategy', 'C303', '800-111-5678', '1007');
INSERT INTO DEPARTMENT
VALUES (06, 'Executive', 'D101', '912-411-5228', '1000');

INSERT INTO EMPLOYEE
VALUES(1000,'King','Steve','19-DEC-74','19-JUN-2010',NULL,06);
INSERT INTO EMPLOYEE
VALUES(1001,'Jordan','Mike','12-FEB-74','1-AUG-2011',1000,06);
INSERT INTO EMPLOYEE
VALUES(1002,'Magic','John','23-AUG-78','1-AUG-2011',1000,06);
INSERT INTO EMPLOYEE
VALUES(1003,'Bryant','Koby','14-AUG-59','1-AUG-2012',1001,01);
INSERT INTO EMPLOYEE
VALUES(1004,'Jason','Lebron','30-DEC-84','1-JUN-2021',1001,02);
INSERT INTO EMPLOYEE
VALUES(1005,'Wade','Derek','30-JAN-84','1-DEC-2012',1001,03);
INSERT INTO EMPLOYEE
VALUES(1006,'Curry','Lawrence','6-JAN-77','14-JAN-2015',1002,04);
INSERT INTO EMPLOYEE
VALUES(1007,'Harden','Paris','22-JAN-78','12-NOV-2011',1002,05);
INSERT INTO EMPLOYEE
VALUES(1008,'Tatum','Ray','19-MAR-80','13-JUN-2011',1003,01);
INSERT INTO EMPLOYEE
VALUES(1009,'Book','Stephen','6-AUG-90','1-NOV-2021',1003,01);
INSERT INTO EMPLOYEE
VALUES(1010,'Durant','Klay','22-JAN-88','1-MAY-2011',1004,02);
INSERT INTO EMPLOYEE
VALUES(1011,'Davis','David','9-APR-83','1-NOV-2021',1004,02);	
INSERT INTO EMPLOYEE
VALUES(1012,'Bosh','Chris','21-AUG-85','1-APR-2011',1005,03);
INSERT INTO EMPLOYEE
VALUES(1013,'Paul','Kris','23-JAN-78','11-AUG-2011',1005,03);
INSERT INTO EMPLOYEE
VALUES(1014,'Thompson','Kevin','9-APR-90','1-MAY-2021',1006,04);
INSERT INTO EMPLOYEE
VALUES(1015,'Lee','Frank','2-JUN-95','14-JUN-2021',1006,04);
INSERT INTO EMPLOYEE
VALUES(1016,'Lopez','Matt','23-JAN-78','14-JUN-2012',1007,05);
INSERT INTO EMPLOYEE
VALUES(1017,'Anderson','Kyle','19-NOV-89','1-JUL-2021',1007,05);

INSERT INTO TRAINING
VALUES (1001, 01, 1001, 'Speaking Course', '01-JAN-15', 'practical instruction for delivering professional presentations');
INSERT INTO TRAINING
VALUES (1002, 02, 1002, 'Java Programming Bootcamp', '01-FEB-12', 'intro to baisc data structures using Java' );
INSERT INTO TRAINING
VALUES (1003, 03, 1003, 'C++ Programming Bootcamp', '01-OCT-12', 'intro to C++ language');
INSERT INTO TRAINING
VALUES (1004, 04, 1004, 'Python Programming Bootcamp', '01-NOV-21', 'intro to Python');
INSERT INTO TRAINING
VALUES (1005, 05, 1005, 'Leadership Skills Workshop', '01-MAY-19', 'study of organizational behavior and management');
INSERT INTO TRAINING
VALUES (1006, 06, 1006, 'Writing Course', '01-JUN-20', 'instruction for effective writing in the workplace');
INSERT INTO TRAINING
VALUES (1007, 07, 1007, 'Leadership Summer School', '01-JUL-20', 'intro to modeling methods used by policymakers');
INSERT INTO TRAINING
VALUES (1008, 02, 1008, 'Java Progamming Bootcamp', '01-AUG-19', 'basic instuction for distributed systems using Java');
INSERT INTO TRAINING
VALUES (1009, 04, 1009, 'Python Programming Bootcamp', '01-DEC-21', 'data cleansing using the pandas library');
INSERT INTO TRAINING
VALUES (1010, 03, 1010, 'C++ Programming Bootcamp', '01-DEC-21', 'fundamental topics of programming in Java');
INSERT INTO TRAINING
VALUES (1011, 07, 1011, 'Leadership Summer School', '01-DEC-21', 'intro to modeling methods used by policymakers');
INSERT INTO TRAINING
VALUES (1012, 07, 1012, 'Leadership Summer School', '01-JUL-21', 'intro to modeling methods used by policymakers');
INSERT INTO TRAINING
VALUES (1013, 02, 1013, 'Java Progamming Bootcamp', '01-DEC-21', 'basic instuction for distributed systems using Java');
INSERT INTO TRAINING
VALUES (1014, 02, 1014, 'Java Progamming Bootcamp', '01-DEC-21', 'basic instuction for distributed systems using Java');
INSERT INTO TRAINING
VALUES (1015, 02, 1015, 'Java Progamming Bootcamp', '01-DEC-21', 'basic instuction for distributed systems using Java');
INSERT INTO TRAINING
VALUES (1016, 01, 1016, 'Speaking Course', '01-DEC-21', 'practical instruction for delivering professional presentations');
INSERT INTO TRAINING
VALUES (1017, 01, 1017, 'Speaking Course', '01-DEC-21', 'practical instruction for delivering professional presentations');
INSERT INTO TRAINING
VALUES (1018, 02, 1013, 'Java Progamming Bootcamp', '01-DEC-20', 'basic instuction for distributed systems using Java');



INSERT INTO CLIENT
VALUES(1001,'Gaogle', '9123 Main St','San Diego','CA','22400','Internet','gaogle.com',
       '626-303-8321','Adams','Sam');
INSERT INTO CLIENT
VALUES(1002,'Meta', '13 Forbe Ave','San Jose','CA','12421','Internet','meta.com',
       '212-403-2220','Johnson','Morry');
INSERT INTO CLIENT
VALUES(1003,'Fusen', '321 Fifth St','Pittsburgh','PA','15921','Internet','fusen.com',
       '112-423-1111','Lawrence','Terry');
INSERT INTO CLIENT
VALUES(1004,'Alicoco', '124 Sixth St','Miami','FL','22922','E-Commerce','alicc.com',
       '728-423-1321','James','Coby');
INSERT INTO CLIENT
VALUES(1005,'Shoppy', '447 Glitter St.','Atlanta','GA','21242','E-Commerce','shoppy.com',
       '728-423-1321','Birdy','Km');
INSERT INTO CLIENT
VALUES(1006,'tMao', '347 Quicker Rd','Riverside','CA','21299','E-Commerce','tmao.com',
       '128-323-1921','Curry','Tim');
INSERT INTO CLIENT
VALUES(1007,'SilverBank', '1 Main St','Irvine','CA','11325','Banking','silverbank.com',
       '333-222-2974','Ted','Leman');
INSERT INTO CLIENT
VALUES(1008,'Jason Mason', '323 Jump St','Boston','MA','11325','Banking','jasonmason.com',
       '789-122-2424','Jason','Jack');
INSERT INTO CLIENT
VALUES(1009,'Capital Ace', '678 Lebon Rd','New York','NY','11254','Banking','capitalace.com',
       '233-122-1252','Morant','Kevin');
INSERT INTO CLIENT
VALUES(1010,'Sequaio', '456 Lynn Ave','Trenton','NJ','08608','Investment','sequaio.com',
       '102-152-1022','Leeman','Justin');
INSERT INTO CLIENT
VALUES(1011,'Netflip', '777 Kevin Ave','Urbana','IL','11021','Investment','netflip.com',
       '122-653-7892','Kai','Toby');
INSERT INTO CLIENT
VALUES(1012,'Aminio', '333 Take Dr','Walnut','CA','12421','Investment','aminio.com',
       '122-132-1892','Johnson','Katy');

INSERT INTO PROJECT
VALUES(1001,'Gaogle System Update', '4-APR-18', 4500.00, 04,1001,04);
INSERT INTO PROJECT
VALUES(1002,'Meta System Update','9-APR-19' , 4992.00, 04,1002,03);
INSERT INTO PROJECT
VALUES(1003,'Fusen Solution', '9-MAY-20', 5432.00, 04,1003,03);
INSERT INTO PROJECT
VALUES(1004,'Alicoco Strategy', '10-AUG-19', 5112.32, 05,1004,05);
INSERT INTO PROJECT
VALUES(1005,'Shoppy Market Ad', '21-JUN-18', 5032.00, 01,1005,06);
INSERT INTO PROJECT
VALUES(1006,'tMao Merge', '9-JAN-21', 7890.22, 01,1006,07);
INSERT INTO PROJECT
VALUES(1007,'SilverBank Acquisition', '2-MAR-19', 7280.22, 04,1007,05);
INSERT INTO PROJECT
VALUES(1008,'SilverBank Merge', '9-MAY-21', 3280.99, 02,1007,07);
INSERT INTO PROJECT
VALUES(1009,'JM Solution', '8-APR-19', 4312.99, 04,1008,05);
INSERT INTO PROJECT
VALUES(1010,'Ace Solution', '12-OCT-21', Null, 04,1009,02);
INSERT INTO PROJECT
VALUES(1011,'Sequaio Merge', '2-MAY-21', 8900, 05,1010,05);
INSERT INTO PROJECT
VALUES(1012,'Netflip Merge', '8-JUN-19', 7792.78, 04,1012,05);
INSERT INTO PROJECT
VALUES(1013,'Netflip Hiring', '8-AUG-21', 5600, 03,1012,01);
INSERT INTO PROJECT
VALUES(1014,'Netflip Hiring', '11-NOV-21',5600,03,1012,01);


INSERT INTO ASSIGNMENT
VALUES(2000, 1001, 1001, '4-APR-18', '15-APR-18', 40);
INSERT INTO ASSIGNMENT
VALUES(2100, 1001, 1002, '5-APR-18', '12-APR-18', 35);
INSERT INTO ASSIGNMENT
VALUES(2200, 1002, 1003, '9-APR-19', '20-APR-19', 30);
INSERT INTO ASSIGNMENT
VALUES(2300, 1002, 1008, '9-APR-19', '30-APR-19', 50);
INSERT INTO ASSIGNMENT
VALUES(2400, 1003, 1005, '9-MAY-20', '19-MAY-20', 25);
INSERT INTO ASSIGNMENT
VALUES(2500, 1003, 1012, '10-MAY-20', '25-MAY-20', 48);
INSERT INTO ASSIGNMENT
VALUES(2600, 1004, 1007, '10-AUG-19', '31-AUG-19', 45);
INSERT INTO ASSIGNMENT
VALUES(2700, 1004, 1007, '1-SEP-19', '15-SEP-19', 40);
INSERT INTO ASSIGNMENT
VALUES(2800, 1005, 1000, '21-JUN-18', '15-JUL-18', 50);
INSERT INTO ASSIGNMENT
VALUES(2900, 1005, 1005, '21-JUN-18', '5-JUL-18', 30);
INSERT INTO ASSIGNMENT
VALUES(3000, 1006, 1003, '9-JAN-21', '31-JAN-21', 100);
INSERT INTO ASSIGNMENT
VALUES(3100, 1006, 1008, '12-JAN-21', '31-JAN-21', 100);
INSERT INTO ASSIGNMENT
VALUES(3400, 1006, 1008, '8-FEB-21', '22-FEB-21', 50);
INSERT INTO ASSIGNMENT
VALUES(3500, 1007, 1001, '8-MAR-19', '31-MAR-19', 50);
INSERT INTO ASSIGNMENT
VALUES(3600, 1007, 1001, '1-APR-19', '16-APR-19', 20);
INSERT INTO ASSIGNMENT
VALUES(3700, 1007, 1002, '1-APR-19', '16-APR-19', 20);
INSERT INTO ASSIGNMENT
VALUES(3800, 1008, 1001, '9-MAY-21', '26-MAY-21', 30);
INSERT INTO ASSIGNMENT
VALUES(3900, 1008, 1002, '9-MAY-21', '26-MAY-21', 30);
INSERT INTO ASSIGNMENT
VALUES(4000, 1009, 1006, '8-APR-19', '26-APR-19', 20);
INSERT INTO ASSIGNMENT
VALUES(4100, 1009, 1002, '8-APR-19', '26-APR-19', 20);
INSERT INTO ASSIGNMENT
VALUES(4200, 1010, 1000, '12-OCT-21', '31-OCT-21', 50);
INSERT INTO ASSIGNMENT
VALUES(4300, 1010, 1000, '1-NOV-21', '15-NOV-21', 20);
INSERT INTO ASSIGNMENT
VALUES(4400, 1010, 1001, '1-NOV-21', '15-NOV-21', 20);
INSERT INTO ASSIGNMENT
VALUES(4500, 1010, 1002, '20-OCT-21', '31-OCT-21', 20);
INSERT INTO ASSIGNMENT
VALUES(5400, 1010, 1000, '1-DEC-21', NULL, NULL);
INSERT INTO ASSIGNMENT
VALUES(6200, 1010, 1004, '1-OCT-21', '30-OCT-21', 50);
INSERT INTO ASSIGNMENT
VALUES(6100, 1010, 1014, '1-NOV-21', '30-NOV-21', 50);
INSERT INTO ASSIGNMENT
VALUES(4600, 1011, 1002, '2-MAY-21', '31-MAY-21', 50);
INSERT INTO ASSIGNMENT
VALUES(4700, 1011, 1006, '2-MAY-21', '31-MAY-21', 50);
INSERT INTO ASSIGNMENT
VALUES(4800, 1011, 1006, '1-JUN-21', '13-JUN-21', 20);
INSERT INTO ASSIGNMENT
VALUES(4900, 1012, 1006, '8-JUN-19', '30-JUN-19', 50);
INSERT INTO ASSIGNMENT
VALUES(5000, 1012, 1007, '8-JUN-19', '30-JUN-19', 50);

INSERT INTO ASSIGNMENT
VALUES(5100, 1013, 1005, '8-AUG-21', '31-AUG-21', 50);
INSERT INTO ASSIGNMENT
VALUES(5200, 1013, 1012, '8-AUG-21', '31-AUG-21', 50);
INSERT INTO ASSIGNMENT
VALUES(5300, 1013, 1013, '8-AUG-21', '31-AUG-21', 50);

INSERT INTO ASSIGNMENT
VALUES(5800, 1013, 1005, '1-OCT-21', '31-OCT-21', 40);
INSERT INTO ASSIGNMENT
VALUES(5900, 1013, 1004, '1-NOV-21', '30-NOV-21', 50);

ALTER TABLE Department
ADD CONSTRAINT Department_Manager_ID_FK FOREIGN KEY (Manager_ID) REFERENCES Employee (Emp_Num);
