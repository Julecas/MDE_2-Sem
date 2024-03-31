
/*1 - table student creation and structure visualization*/

use mde_test;


create or replace table student(
	st_number 		integer,
    st_name 		varchar(127),
    address 		varchar(255),
    postal_code 	varchar(10),
    city 			varchar(64),
    st_email 		varchar(64)
);

-- see table structure

-- describe student;
    
/*2 inset some students in the student table*/
insert into student( st_number, st_name   		    , city     		 )    
values			   ( 8001     , 'Rodrigo Agostinho' , 'Leiboa' 		 );        

insert into student( st_number, st_name   		    , city    		 ) 
values			   ( 8002     , 'Martim Simões' 	, 'Lisiria' 	 );   

insert into student( st_number, st_name   		    , city     		 ) 
values			   ( 8003     , 'Júlio Duarte' 		, 'Ponte de lis' );   

insert into student( st_number, st_name   		    , city     		 ) 
values			   ( 8004     , 'Rodrigo Lopes' 	, 'Porto' 		 );   

insert into student( st_number, st_name   		    , city     		 ) 
values			   ( 8005     , 'Martim Catapirra' 	, 'Broa'		 );   

-- 3 visualize the inserted students

-- all attributes (columns) of all students 
-- select * from student;

-- some atributes (ex: 'st_number' , 'city') of all students 
-- select st_number, city
-- from student;

-- 4 Update students data 
update student
set postal_code='12314', address='Rua das fontainhas', st_email='regeton@sapo.pt'
where st_number='8001';

update student
set postal_code='12334', address='Rua do malhadal'	 , st_email='rego@hotmail.pt'
where st_number='8002';

update student
set postal_code='52614', address='Praça do coral'	 , st_email='memes@sapo.pt'
where st_number='8003';

update student
set postal_code='12222', address='Av Infarto Santo'	 , st_email='zaza@gmail.com'
where st_number='8004';

-- visualize result
-- select * from student;

-- 5 Delete student number 8005 from the table

delete from student where st_number='8005';

-- visualize result
-- select * from student;

-- 6 - inserting a student without number and visualize

insert into student(st_name, city) values('Macas', 'Chelas');
delete from student where st_name='Macas'; -- deleted for now

-- select * from student;

/* CONSTRAINS
7- ALTER the student table, creating a constraint associated to the st_number attribute.
In this way we guarantee that the student has always a associated number. 
*/

-- Case there is in the DB students with st_nuber=null (which is the case)
-- it will trigger an error-
-- In this situation we should first make the necessary amendments
alter table student 
	add constraint st_number_null_ctrl check (st_number is not null);
    
    -- insert into student(st_name, city) values('Macas', 'Chelas'); -- cant add this student now
    
-- 8 insert new student with the same number of exisiting student in the DB

insert into student( st_number, st_name		  , city  )
values			   ('8003'    , 'Júlio salada', 'Agua');	

/*
9 - As julio salada has the same number has julio duarte first we delete julio salada
from the table. Then we add a constraint in order to guarantee this situation doesnt occur again
*/

-- delete all records whose name begins with Julio: % <=> '*' (some variations)
-- delete from student where st_name like 'Júlio%';
delete from student where st_name like '%salada';
delete from student where st_name='Júlio salada';
-- delete from student where st_number='8003';

-- select * from student;

alter table student
	add constraint st_number_unique unique(st_number);
    
-- cant add this student now    
/*
insert into student( st_number, st_name		  , city  )
values			   ('8003'    , 'Júlio salada', 'Agua');	
*/

-- 11 - Add new attributes to existing table 

alter table student
	add annual_fee decimal(5,2);
    
-- change the defalut value of annual_fee to 750.00

alter table student
	modify annual_fee decimal(5,2) default 750.00;
    
-- describe student;


-- CREATION OF DEPARTMENT TABLE

-- drop previous tables
drop table student;
 -- drop table student_unit;
 -- drop table students;
 -- drop table  course;
 -- drop table units;
-- drop table department;


-- creation of table department

create or replace table department(
	id int auto_increment primary key,
    name varchar(128),
    dep_code varchar(64) unique,
    creation_date date not null
);

-- inserting some departments
insert into department(name  , dep_code, creation_date)
values				  ('DEEC','123ABC' ,'1998-01-01'  );

insert into department(name  , dep_code, creation_date)
values				  ('DEI'  ,'123FGD' ,'1992-01-01'  );

insert into department(name  , dep_code, creation_date)
values				  ('DEM'  ,'123UZX' ,'1990-01-01'  );

insert into department(name  , dep_code, creation_date)
values				  ('DEC'  ,'123HHZ' ,'1991-01-01'  );

insert into department(name  , dep_code, creation_date)
values				  ('DF'  ,'123UKK' ,'1989-01-01'  );

select * from department;

-- creation of course table

create or replace table course(
	id int auto_increment primary key,
	id_department int,
	name varchar(128),
	course_code varchar(64),
	creation_date date,
	foreign key(id_department) references department(id)
);

-- inserting some courses
insert into course (id_department, name, course_code, creation_date)
values(1, "Licenciatura em Eletro","qwerty","1998-01-01");

insert into course (id_department, name, course_code, creation_date)
values(1, "Licenciatura em energias renovaveis","jhbew","1995-01-01");

insert into course (id_department, name, course_code, creation_date)
values(2, "Licenciatura em Engenharia informatica","alfka","1992-01-01");

insert into course (id_department, name, course_code, creation_date)
values(2, "Mestrado em Engenharia de Big Data","hhjjak","2000-01-01");

insert into course (id_department, name, course_code, creation_date)
values(3, "Licenciatura em Engenharia mecanica","llodoa","1990-01-01");

insert into course (id_department, name, course_code, creation_date)
values(3, "Mestrado em engenharia mecanica","allpss","1990-01-01");

insert into course (id_department, name, course_code, creation_date)
values(4, "Licenciatura em engenharia civil","hahahs","1981-01-01");

insert into course (id_department, name, course_code, creation_date)
values(4, "Mestrado em engenharia civil","zazah","1981-01-01");

insert into course (id_department, name, course_code, creation_date)
values(5, "Licenciatura em Fisica","bbban","1998-01-01");

insert into course (id_department, name, course_code, creation_date)
values(5, "Mestrado em Fisica","iioao","1998-01-01");


select * from course;

-- create student table

create or replace table students(
	id int auto_increment primary key,
    id_course int,
    name varchar(128),
    number int unique,
    address varchar(255),
    city varchar(64),
    enroll_date date,
    constraint FK_student_id_course foreign key (id_course) references course(id)
);

insert into students (id_course, name, number, address, city, enroll_date)
values(1,'Maria Almeida', '12','Rua A',"Cidade 1", '2020-09-15');
insert into students (id_course, name, number, address, city, enroll_date)
values(1,'João Bolota', '24','Rua B',"Cidade 2", '2020-09-15');

insert into students (id_course, name, number, address, city, enroll_date)
values(2,'Maria Ana', '21','Rua C',"Cidade 3", '2020-09-15');
insert into students (id_course, name, number, address, city, enroll_date)
values(2,'João Marmita', '51232','Rua D',"Cidade 4", '2020-09-15');

insert into students (id_course, name, number, address, city, enroll_date)
values(3,'Almeida Lara', '62222','Rua A',"Cidade 1", '2020-09-15');
insert into students (id_course, name, number, address, city, enroll_date)
values(3,'Aquino Outro rego', '31200','Rua B',"Cidade 2", '2020-09-15');

insert into students (id_course, name, number, address, city, enroll_date)
values(4,'Eva Gina', '61111','Rua A',"Cidade 1", '2020-09-15');
insert into students (id_course, name, number, address, city, enroll_date)
values(4,'Jacinto Leite', '31232','Rua B',"Cidade 2", '2020-09-15');

insert into students (id_course, name, number, address, city, enroll_date)
values(5,'Aquino Rego', '62964','Rua A',"Cidade 1", '2020-09-15');
insert into students (id_course, name, number, address, city, enroll_date)
values(5,'Bobo Pele', '45555','Rua B',"Cidade 2", '2020-09-15');

insert into students (id_course, name, number, address, city, enroll_date)
values(6,'Normando Mando', '55555','Rua A',"Cidade 1", '2020-09-15');
insert into students (id_course, name, number, address, city, enroll_date)
values(6,'Maracas Flertante', '66666','Rua B',"Cidade 2", '2020-09-15');

insert into students (id_course, name, number, address, city, enroll_date)
values(7,'Ideia Malvista', '62323','Rua A',"Cidade 1", '2020-09-15');
insert into students (id_course, name, number, address, city, enroll_date)
values(7,'Ernacio Enucuo', '62424','Rua B',"Cidade 2", '2020-09-15');

insert into students (id_course, name, number, address, city, enroll_date)
values(8,'Lariça Salpicão', '69999','Rua A',"Cidade 1", '2020-09-15');
insert into students (id_course, name, number, address, city, enroll_date)
values(8,'Batata Enorme', '41232','Rua B',"Cidade 2", '2020-09-15');

insert into students (id_course, name, number, address, city, enroll_date)
values(9,'Jarir Bolsonado', '62525','Rua A',"Cidade 1", '2020-09-15');
insert into students (id_course, name, number, address, city, enroll_date)
values(9,'Brad Petit', '62727','Rua B',"Cidade 2", '2020-09-15');

insert into students (id_course, name, number, address, city, enroll_date)
values(10,'Lulas Frescas', '62828','Rua A',"Cidade 1", '2020-09-15');
insert into students (id_course, name, number, address, city, enroll_date)
values(10,'Ermando Lamego', '62929','Rua B',"Cidade 2", '2020-09-15');

select * from students;

create or replace table units(
	id int auto_increment primary key,
	department_id  int,
	name varchar(128),
	credits integer,
	foreign key(department_id ) references department(id)
);

insert into units( department_id , name , credits)    
values			 ( 1   	, 'ET' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 1   	, 'TC' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 1   	, 'CEE' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 1   	, 'SL1' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 1   	, 'SL2' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 1   	, 'PRd' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 1   	, 'HDA' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 1   	, 'JSJ' , 6		);  

insert into units( department_id , name , credits)    
values			 ( 2  	, 'KD' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 2   	, 'LP' , 6		); 
insert into units( department_id , name , credits)    
values			 ( 2  	, 'AA' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 2   	, 'BG' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 2  	, 'HJ' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 2   	, 'PA' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 2  	, 'HH' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 2   	, 'HY' , 6		);   
    
insert into units( department_id , name , credits)    
values			 ( 3  	, 'LL' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 3   	, 'PP' , 6		); 
insert into units( department_id , name , credits)    
values			 ( 3  	, 'MM' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 3   	, 'NN' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 3  	, 'BB' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 3   	, 'VV' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 3  	, 'II' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 3   	, 'TT' , 6		);   

insert into units( department_id , name , credits)    
values			 ( 4  	, 'QW' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 4   	, 'ER' , 6		); 
insert into units( department_id , name , credits)    
values			 ( 4  	, 'YT' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 4   	, 'UI' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 4  	, 'OP' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 4   	, 'ZX' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 4  	, 'CV' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 4   	, 'BN' , 6		);   

insert into units( department_id , name , credits)    
values			 ( 5  	, 'LAP' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 5   	, 'JKA' , 6		); 
insert into units( department_id , name , credits)    
values			 ( 5  	, 'LKA' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 5   	, 'POI' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 5  	, 'YTR' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 5   	, 'MNB' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 5  	, 'AFD' , 6		);  
insert into units( department_id , name , credits)    
values			 ( 5   	, 'TYU' , 6		);   
    
select * from units;
    
-- table intermedia que liga muitos para muitos

create or replace table student_unit(
	student_id  int,
    unit_id int,
	start_date date not null,
    end_date date,
	grade integer, 
	foreign key(student_id) references students(id),
    foreign key(unit_id) references units(id)
);

alter table student_unit
	add constraint grede_ctrl check (grade>=0 and grade<=20);

-- 1 unit with 3 diferent students 
insert into student_unit( student_id, unit_id, start_date, end_date, grade)    
values			 ( 2   	, '1' , '2020-09-15', '2021-09-15', 13		);  
insert into student_unit( student_id, unit_id, start_date, end_date, grade)    
values			 ( 4   	, '1' , '2020-09-15', '2021-09-15', 16		);  
insert into student_unit( student_id, unit_id, start_date, end_date, grade)    
values			 ( 7   	, '1' , '2020-09-15', '2021-09-15', 14		);  

-- 1 student int 3 diferent units

insert into student_unit( student_id, unit_id, start_date, end_date, grade)    
values			 ( 10   	, '15' , '2020-09-15', '2021-09-15', 10		);  
insert into student_unit( student_id, unit_id, start_date, end_date, grade)    
values			 ( 10   	, '16' , '2020-09-15', '2021-09-15', 11		);  

-- select * from student_unit;

-- show all students grades and units

SELECT 
	s.number , s.name , u.name, su.grade
 FROM
	student_unit su, 
	units u, 
	students s
WHERE
	s.id = su.student_id and
    u.id = su.unit_id;
    
    
 -- show results for student id 10
 
    SELECT 
	s.number , s.name , u.name
 FROM
	student_unit su, 
	units u, 
	students s
WHERE
	su.student_id = 10 and
	s.id = su.student_id and
    u.id = su.unit_id;

 
 -- sum all unit credits from a specific student DUV
 
 
 
SELECT 
	s.number , s.name , SUM(u.credits)
 FROM
	student_unit su, 
	units u, 
	students s
WHERE
	su.student_id=10 and
	s.id = su.student_id  and
    u.id = su.unit_id;

    
    
    
 
 
    

    
    
 

