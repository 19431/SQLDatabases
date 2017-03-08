/*create database UMD;*/
select * from UMD_event;

use UMD;
/*use master;*/

/*drop database UMD;*/

create table Departments(
Dep_name varchar(40) not null primary key,
Degree_title text,
College text
);

alter table departments drop column College;


insert into Departments (Dep_name, Degree_title, reputation) 
values ('Astronomy', 'Bachelor of Science', 'highly ranked');

update Departments set reputation = 'Top 25th percentile' where Dep_name = 'Computer Science';
update Departments set Degree_title = 'BSc' where Dep_name = 'Computer Science';


delete from Departments where Dep_name = 'psychology'; 

select * from Departments order by Dep_name;

/*students unofficial transcript*/
create table Academic_Records(
Student int not null foreign key references Students(Std_id),
No_Of_Credits int,
Student_Level varchar(40), /*sophmore*/
Student_Standing text, /*good or bad*/
GPA float default 0.0,
Major text, 
Minor text default null,
Student_Blocks text
);

insert into Academic_Records(student, No_Of_Credits, Student_Level,  GPA, Student_Standing, Major, Minor, Student_Blocks)
values(113, 57,  'Sophmore', 2.89, 'Good standing', 'Computer Science', 'Astronomy', 'None');

delete from Academic_Records where student = 113;

insert into Academic_Records(student, No_Of_Credits, Student_Level,  GPA, Student_Standing, Major, Minor, Student_Blocks)
values(112, 57,  'Sophmore', 2.89, 'Good standing', 'Computer Science', 'Astronomy', 'None');

insert into Academic_Records(student, No_Of_Credits, Student_Level,  GPA, Student_Standing, Major, Minor, Student_Blocks)
values(113, 79,  'Junior', 3.0, 'Good standing', 'Computer Science', 'Business Analytics', 'None');

insert into Academic_Records(student, No_Of_Credits, Student_Level,  GPA, Student_Standing, Major, Minor, Student_Blocks)
values(114, 60,  'Junior', 3.5, 'Good standing', 'Computer Science', 'General Business', 'None');


select * from Students inner join Academic_Records on Students.Std_id = Academic_Records.Student order by Student;
select Std_Fname, Std_lname, Student_Level  from Students inner join Academic_Records on Academic_Records.Student = Students.Std_id;
select Std_Fname, Std_lname, Student_Level, Club  from Students left  join Academic_Records on Academic_Records.Student = Students.Std_id;
select Std_Fname, Std_lname, Student_Level, Club  from Students right  join Academic_Records on Academic_Records.Student = Students.Std_id;
select Std_Fname, Std_lname, Student_Level, Club  from Students right outer join Academic_Records on Academic_Records.Student = Students.Std_id;
select Std_Fname, Std_lname, Student_Level, Club  from Students left outer join Academic_Records on Academic_Records.Student = Students.Std_id;

select * from Academic_Records;



/*schools within the univeristy*/
create table Colleges(
College_name varchar(200) not null primary key, 
created_on date,
reputation text
);

insert into Colleges(College_name, created_on, reputation)
values ('COLLEGE OF COMPUTER, MATHEMATICAL AND NATURAL SCIENCES', '03-23-1965', 'Nationally Ranked');

 delete from Colleges where college_name = 'SMITH BUSINESS';

insert into Colleges(College_name, created_on, reputation)
values ('SMITH SCHOOL OF BUSINESS', '03-23-1895', 'Nationally Ranked');

insert into Colleges(College_name, created_on, reputation)
values ('SCHOOL OF PUBLIC HEALTH', '03-23-1895', 'Nationally Ranked');

insert into Colleges(College_name, created_on, reputation)
values ('SCHOOL OF PUBLIC POLICY', '03-23-1885', 'Ranked in the World');

insert into Colleges(College_name, created_on, reputation)
values ('JAMES CLARK SCHOOL OF ENGINEERING', '03-23-1905', 'Nationally Ranked');

insert into Colleges(College_name, created_on, reputation)
values ('PHILLIP MERRIL COLLEGE OF JOURNALISM', '03-23-1895', 'ACCREDITED');

insert into Colleges(College_name, created_on, reputation)
values ('COLLEGE OF INFORMATION STUDIES', '03-23-1855', 'Ranked in the World');

insert into Colleges(College_name, created_on, reputation)
values ('COLLEGE OF ARTS AND HUMANITIES', '03-23-1898', 'Ranked in the World');

insert into Colleges(College_name, created_on, reputation)
values ('COLLEGE OF EDUCATION', '03-23-1853', 'Ranked in the World');

insert into Colleges(College_name, created_on, reputation)
values ('COLLEGE OF ARCHITECTURE PLANNING AND PRESERVATION', '03-23-1855', 'Nationaly ranked');

insert into Colleges(College_name, created_on, reputation)
values ('COLLEGE OF AGRICULTURE AND NATURAL RESOURCES', '03-23-1835', 'Nationally Ranked');

select * from Colleges;


/**/
create table UMD_overview(
Department varchar(40) foreign key references Departments(Dep_name),
College varchar(200) foreign key references Colleges(College_name),
);



select * from UMD_overview;


/**/
create table UMD_event(
Event_Date date,
Event_Type text, /*sports academic*/
Participants text,
Event_Period datetime,
Event_Reputation varchar(90),
Event_Duration int, /*in hours*/
Event_Name text,
Hosting_Body text
);

alter table UMD_event add Event_Start_Time time;


insert into UMD_event(event_name, event_type, participants, Event_Period,
					 Event_Reputation, Event_Duration, Hosting_Body)
values ('Spring Career Fair', 'Academic', 'students and recruiting Companies', '2017-02-23 3:45', /*find out how to input time*/
		 'High', 2, 'University Of Maryland');

select * from UMD_event;


/**/
create table Academic_Staff(
 Faculty_id int not null primary key,
 Faculty_fname text,
 Faculty_lname text,
 Faculty_title varchar(20),/*professsor doctor engineer etc*/
 Years_of_Exp int,
 Faculty_role text,
 Employment_date date,
 Research_interest text,
 Faculty_category text,/*full time, adjunct*/
 Department text
 );
 
 alter table Academic_Staff drop column Course_Teaching;
 
 insert into Academic_Staff(Faculty_id, Faculty_fname, Faculty_lname, Faculty_title, Faculty_role, Department,
							Faculty_category, Employment_date, Research_interest, Years_of_Exp)
 values (11389, 'Jones', 'Mclurkin', 'Dr', 'Instructor', 'Computer Science', 
		 'high rank', '01/23/1994', 'Artificial Intelligence', 25);
 
 insert into Academic_Staff(Faculty_id, Faculty_fname, Faculty_lname, Faculty_title, Faculty_role, Department,
							Faculty_category, Employment_date, Research_interest, Years_of_Exp)
 values (11390, 'John', 'Mckeson', 'Dr', 'Instructor', 'Biology', 
		 'High Ranked', '01/23/2010', 'Stem Cells', 3);

insert into Academic_Staff(Faculty_id, Faculty_fname, Faculty_lname, Faculty_title, Faculty_role, Department,
							Faculty_category, Employment_date, Research_interest, Years_of_Exp)
 values (11391, 'John', 'Wick', 'Prof', 'Instructor', 'Psycology', 
		 'World Reknown', '01/23/2015', 'Cognition', 10);
		 
 select * from Academic_Staff;
 select * from Departments;

 /**/
 create table Non_Academic_Department(Dep_id int primary key not null, Dep_name text);

 insert into Non_Academic_Department(Dep_id, Dep_name)
 values(890, 'Cleaning');

 select * from Non_Academic_Department;


 /**/
 create table Non_Academic_Staff(
 Staff_Id int not null primary key,
 Staff_Fname text,
 Staff_Lname text,
 Staff_Role varchar(30), /*maintainance etc etc*/
 Years_Of_Exp int, 
 Employment_Date date,
 Job_class text /*contract, full time, apprenticeship etc*/
 ); 


alter table Non_Academic_Staff add Department_Id int not null foreign key references Non_Academic_Department(Dep_id);

 insert into Non_Academic_Staff (Staff_Id, Staff_Fname, Staff_Lname, Staff_Role, Years_Of_Exp, Employment_Date,
								Job_class, Department_Id)
values (116, 'Adele', 'Winters', 'cleaner', 8, '12-07-2006', 'full time', 890);

 select * from Non_Academic_Staff;

 
 /**/
 create table courses(
 Course_id nvarchar(14) not null primary key,
 Course_description text,
 Course_prereq varchar(14),
 Course_corequisite varchar(14),/*professsor doctor engineer etc*/
 Final_Exam date, 
 Course_time time, 
 Course_date date,
 Course_Credit int,
 Course_category varchar(14),/*core, gen ed dssp*/ 
 Course_Restriction text,
 Department varchar(40) foreign key references Departments(Dep_name),
 Faculty int foreign key references Academic_Staff(Faculty_id)
 );

 alter table courses add Course_location text default 'TBA';

 select * from courses;

 /**/
 create table Alumni(
 Person_id int not null primary key,
 Person_Fname text,
 Person_Lname text,
 Almuni_reputation varchar(10), /*status in terms of reputation*/
 Donation money
 );

 select * from Alumni;

 /*donations received*/
 create table Sponsors(
 id int not null primary key,
 sponsor_name text,
 class varchar(20),/*VIP, regular, basic*/
 sponsor_type varchar(20),/*govt, private*/
 Donation money
 );

 select * from Sponsors;

 /**/
 create table Revenue(
 id int not null primary key,
 revenue_category text, /*school fees, donations*/
 Amount money,
 Date_received date
 );

 select * from Revenue;


 /**/
 create table Contacts(
 University_Id int not null primary key,
 House_Address text,
 Person_role text not null,
 Mobile_No int,
 Telephone_No int,
 University_Email text,
 Personal_Email text,
 Person_level varchar(30), /*vip, lower level, etc*/
 Person_status varchar(30), /*active or inactive*/
 First_Encounter_Date date
 );

 alter table Contacts drop constraint FK__Contacts__Depart__59FA5E80;

 alter table Contacts add Person_type varchar(40);

 select * from Contacts;

 /**/
 create table Clubs(
 Club_name varchar(100) primary key not null,
 Club_category text /*academic, political etc*/
 );

 select * from contacts;

 /**/
 create table Students(
 Std_id int not null primary key,
 Std_Fname text, 
 Std_lname text not null,
 Credits int,
 Classes text,
 Std_level text,
 Club varchar(100) foreign key references Clubs(Club_name),
 Std_major varchar(40) foreign key references Departments(Dep_name),
 Stud_type text, /*full time or part time*/
 Student_Blocks text, /*advising, financial etc*/
 Stud_GPA float
 );

 alter table Students drop column Std_Level, Classes, Student_Blocks, Stud_GPA;
 alter table students drop constraint FK__Students__Std_ma__398D8EEE;
 alter table Students drop column Std_major;


 alter table students add DOB date, SSN char(11), Std_Height char(10), Std_Weight char(8), Std_Address text, 
Mobile_No char(16), Next_of_Kin nvarchar(100);

alter table students add Gender char(14), Race char(50), Nationality char(50), Veteran_Status char(20), Disability char(50);

alter table Students add Live_in_situation char(40) not null default 'Border';


 insert into Students(Std_id, Std_Fname, Std_LNAME, std_major)
 values(113, 'Oluwaseyi', 'Oni', 'Computer Science');

 update Students set Live_in_situation = 'Commuter' where Std_lname like 'Oni';

 update Students SET gender= 'Female', Race= 'African American', Nationality= 'Nigeria/US', Veteran_Status= 'None', Disability= 'None'
  where Std_id = 114;
  
 insert into Students(Std_id, Std_Fname, Std_LNAME, Club, DOB, SSN, Std_Height,Std_Weight,Std_Address,Mobile_No,Next_Of_Kin, gender, Race,
 Nationality, Veteran_Status, Disability)
 values(116, 'Laura', 'Petrovich', NULL,'1995-04-25','254-44-3335','5ft 3inch','120lb',
		'83 Apt k, Love Ave, College Park, MD', '240-923-2484','John Jillian','Female','Caucasian','Ukraine','None','None');


 select * from students order by Std_id

 /**/
 create table Health_Insurance(
 Insurance_Id int primary key not null,
 Insurance_Holder int foreign key references Students(Std_Id), 
 Expiration_Date date not null, 
 Insured_By text
 );

 alter table Health_Insurance drop column Insurance_Id

 alter table Health_Insurance add Insured_By int foreign key references InsuranceCompany(id);

 insert into Health_Insurance(Insurance_Id, Insurance_Holder, Expiration_Date, Insured_By)
 values (100, 113, '2017-07-09', 119237 );

 insert into Health_Insurance(Insurance_Id, Insurance_Holder, Expiration_Date, Insured_By)
 values (101, 112, '2017-07-11', 119277 );

 select * from Health_Insurance;
 
 create table InsuranceCompany(
 id int not null primary key,
 Company_Name text not null
 );

 insert into InsuranceCompany(id, Company_Name)
 values (119237, 'United Health');

 insert into InsuranceCompany(id, Company_Name)
 values (119277, 'Obama Care');

 insert into InsuranceCompany(id, Company_Name)
 values (119273, 'Terp Insure');

 select * from InsuranceCompany;

 /**/
 create table Student_Health_Records(
 Std_id int foreign key references Students(Std_id),
 Existing_Condition int foreign key references Diagnosis(id), 
 Insurance_Id int foreign key references Health_Insurance(Insurance_Id)
 );

 insert into Student_Health_Records(Std_id,Existing_Condition,Insurance_Id)
 values(113, 1000, 101);

 Select * from Student_Health_Records;

 /**/
 create table Diagnosis(
 id int primary key not null,
 Student int foreign key references Students(Std_id) not null,
 Condition_Name text, 
 Terminal varchar(10) not null, 
 Stage varchar(40)
 );

 insert into Diagnosis (id, Student, Condition_Name, Terminal, Stage)
 values(1000, 113, 'Pneumonia', 'NO', 'Early');

 Select * from Diagnosis;

 /**/
 create table Charges(
	Charge_id int primary key not null identity (10, 1),
	Student_Charged int foreign key references Students(Std_id)
 );

 alter table Charges add Charge_Amount money default 0;

 insert into Charges(Student_Charged)
 values(112);


 select * from Charges;


 /**/
 create table registration(
 id int primary key not null,
 Course nvarchar(14) foreign key references courses(Course_id),
 Student int foreign key references Students(Std_id)
 );

 alter table registration add Instructor int foreign key references Academic_Staff(Faculty_id);
  

 select * from registration;

 create table Bursar(
 Bursar_id int foreign key references Non_Academic_Staff(Staff_Id) 
 );


 /**/
create table Expenses(
 Expense_type text,
 Amount money,
 Date_paid date,
 Paid_to text,
 Paid_by text
 );

 alter table Expenses add Expense_Group varchar(50);
 alter table Expenses alter column Paid_to varchar(50);
 alter table Expenses alter column Paid_by int foreign key references Bursar(Bursar_Id);

 insert into Expenses(Expense_type, Amount, Date_paid, Paid_to, Paid_by)
  values('School Bus Repair', 15000.00, '2017-01-23', 'Emaliano Alvarez', '');

 select * from expenses;

 /**/
 create table Salary(
 Staff_Id int not null primary key,
 Amount money,
 );

 insert into Salary (Staff_Id, Amount)
 values(983, 30,000);
 
 select * from salary;


 /**/
 create table Career_Services(
	id int not null primary key,
	Staff int foreign key references Non_Academic_Staff(Staff_Id),
	UpComing_Activity char(60)
 ); 

 /**/
 create table UMD_Calender(
 Id int not null primary key,
 schedule char(60) null,
 Date_of_event datetime not null,
 To_Whom_It_May_Concern char(60) /*what category of people should care*/ 

 ); 

 insert into UMD_Calender (Id, schedule, Date_of_event, To_Whom_It_May_Concern)
  values (2387, 'last day to withdraw', '2017-09-12 12:00','Student');

 select * from UMD_Calender;





 SELECT TABLE_NAME FROM UMD.INFORMATION_SCHEMA.Tables;