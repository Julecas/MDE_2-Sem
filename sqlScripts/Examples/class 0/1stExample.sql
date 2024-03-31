
show databases;
use mysql;
show tables;
describe user;
select user, host, password from user;

use test;
create table custumers(
	id 			integer,
	name 		varchar(128),
    address		varchar(256),
    city		varchar(32),
    postal_code	varchar(32),
    email		varchar(32)
);

/* do queries like these */

INSERT INTO `test`.`custumers`(`id`,`name`,`address`,`city`,`postal_code`,`email`)
VALUES(1,'Antonio','Rua de cima, 32, 2Esq','Almada','2000-001','antonio@gmail.com');

select id, name, city from custumers;
select * from custumers where id =1;

update custumers
set email='antonio@sapo.pt'
where id =1;