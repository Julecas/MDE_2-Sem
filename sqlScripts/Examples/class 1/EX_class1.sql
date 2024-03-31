-- Exercicio 1ª aula

use mde_test;
create or replace table Unit_student(
	st_number 		integer,
    unit_name 		varchar(127),
    grade 			integer
);

alter table Unit_student
	add constraint st_number_null_ctrl check (st_number is not null);
alter table Unit_student
	add constraint unit_name_null_ctrl check (unit_name  is not null);
alter table Unit_student
	add constraint grede_null_ctrl check (grade is null or (grade>=0 and grade<=20));
    
insert into Unit_student( st_number	, unit_name  	, grade       )    
values			  		( 8001      , 'F1'	 		,  null		  );  
    
insert into Unit_student( st_number	, unit_name  	, grade       )    
values			  		( 8001      , 'AM4' 		,  null		  );    

insert into Unit_student( st_number	, unit_name    	, grade      )    
values			  	 	( 8002     , 'AM3' 		, null		 );    

insert into Unit_student( st_number, unit_name  	, grade       )    
values			   		( 8003      , 'STR' 		, 16		 );    

insert into Unit_student( st_number , unit_name    	, grade      )    
values			   		( 8004      , 'MDE' 		, 18 		 );    

/*
select us.st_number, s.st_name, us.unit_name, us.grade
	from 
		student s ,
        Unit_student us
	where s.st_number = 8001 and us.st_number = 8001;
*/    
	
  -- alter table student
	 -- add  average_grade decimal(4,2);
    
update student
set annual_fee=750.00;

update student
set average_grade=13.50;

update student
set average_grade=18.50
where st_name='Júlio Duarte';

update student
set annual_fee = 0.5*annual_fee
where average_grade >= 18;

update  Unit_student
set grade=15
where st_number=8001 and  unit_name='F1';

    
-- FORMATs WE WANT FOR THIS EXERCICE

select * from student;

SELECT 
    us.st_number, s.st_name, us.unit_name, us.grade
FROM
    student s,
    Unit_student us
WHERE
    s.st_number = us.st_number;
    

    


