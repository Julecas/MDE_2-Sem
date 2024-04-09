
-- RF1 implementar operações CRUD da BD em termos de entidades identificadas para a BD obtida

use smart_buildingsdb;

-- CLEAR ALL TABLES FIRST
 SET FOREIGN_KEY_CHECKS = 0; -- Disable foreign key checks

DELETE FROM Clients;
DELETE FROM ServiceDesc;
DELETE FROM Installation;
DELETE FROM Contract;
DELETE FROM Suppliers;
DELETE FROM Devices;
DELETE FROM Invoice;


ALTER TABLE `Clients` AUTO_INCREMENT = 0;
ALTER TABLE `ServiceDesc` AUTO_INCREMENT = 0;
ALTER TABLE `Installation` AUTO_INCREMENT = 0;
ALTER TABLE `Contract` AUTO_INCREMENT = 0;
ALTER TABLE `Suppliers` AUTO_INCREMENT = 0;

SET FOREIGN_KEY_CHECKS = 1; -- Enable foreign key checks


--  aqui temos 5 clientes distintos
INSERT IGNORE INTO Clients( name	, main_address	 ,	contact	 , NIF  	)
VALUES 	
( "Arnaldo"	, "O Quinto Crlh" ,	923144123, 123456789),
( "Armindo"	, "Picho"		  ,	923155123, 223456789),
( "Joel"	, "Mirandela"	  ,	923166123, 323456789),
( "Martim"	, "Pombal Leiria" ,	923999123, 553456789),
( "Rodrigo"	, "Benfica Lisboa",	999966123, 323456111),
( "Júlio"	, "Ajuda Lisboa"  ,	919999999, 626337181);

-- Aqui o joel e o rodrigo tem duas instalações enquanto os restantes tem apenas uma
INSERT IGNORE INTO Installation (address, Client_idClient, Type)   
VALUES 
("Rua das fontralhinhas Nº 130",1,"Home"),
("Praceta da Certa  Nº 140",2,"Home"),
("Avenida do Buçal Nº 130",3,"Office"),
("Calçada da tapadinha Nº 130",3,"Apartment"),
("Rua quintal de cima Nº 100",4,"Store"),
("Alheira de mirandela Nº 14",5,"Apartment"),
("Avenida das alheiras Nº 1",5,"Office"),
("Rua do bucetildes",2,"Home"); -- esta instalação não tem contrato, estamos a testar para o ponto RF8

-- tabela de desrição de serviço (custo é valor mensal e Max devices é tipos de dispositivos)
INSERT IGNORE INTO ServiceDesc (name, Cost, MaxDevices)
VALUES
("Lowcost", 10, 2),
("Normal", 20, 4),
("Professional", 30, NULL);

-- CONTRACTS

INSERT IGNORE INTO Contract (StartDate, ServiceDuration, ServiceDesc_Type, Installation_code)
VALUES 
('2023-12-10', '2025-12-10', 2, 1),
('2023-12-12', '2026-06-10', 1, 2),
('2023-10-10', '2024-10-10', 3, 3),
('2023-12-10', '2025-11-10', 2, 4),
('2023-12-29', '2027-12-29', 1, 5),
('2023-12-10', '2025-12-10', 2, 6),
('2023-12-10', '2025-12-10', 1, 7);

-- RF9 Proponha um requisito relevante e ainda por identificar que implique a especificação de uma ou mais entidades. Implemente.

INSERT INTO Suppliers (name , main_address,contact)
VALUES
("BOBOTECH", "38043 My Wells, North Celinaburgh, OH 35513-7729","+14028867850"),
("StayFreshINC", "5708 O'Keefe Vista, Port Israelmouth, AL 31806","+18175445111"),
("SAMSUNG","Everland-ro, Pogok-eup, Cheoin-gu, Yongin-si, Gyeonggi-do, Korea","82-31-320-5000"),
("Apple","One Apple Park Way, Cupertino, CA 95014, EUA","1 408-996-1010");


-- DEVICES 

INSERT IGNORE INTO Devices (MakerReference, Model, Type, InstallationDate, State, PowerConsumption, Eficiency, Installation_code,Suppliers_idSupplier)
VALUES 
("AHAH1908", "KONA", "Audio Device", '2019-12-11', "Active", NULL, NULL, 1,3),
("BHAH1908", "KONA", "Audio Device", '2019-12-11', "Active", NULL, NULL, 1,3),
("BLLPA134", "BLEU", "light Source", '2023-12-11', "Active", NULL, NULL, 1,2),
("BLLP2234", "BLEU", "light Source", '2023-12-11', "Active", NULL, NULL, 1,2),

("AHAH1908", "TERMOMO", "Thermostat", '2019-01-01', "Inactive", NULL, NULL, 2,4),
("LLLPA134", "BLEUV2", "light Source", '2019-01-01', "Active", "8 W", "50%", 2,2),
("PLLP2234", "BLEUV2", "light Source", '2019-01-01', "Active", "8 W", "50%", 2,2),

("BHBH1B08", "KALINKA", "Audio Device", '2023-10-11', "Inactive", NULL, NULL, 3,1),
("BAAA1A08", "KALINKA", "Audio Device", '2023-10-11', "Active", NULL, NULL, 3,1),
("BZAZA134", "BLEU", "light Source", '2023-10-11', "Active", NULL, NULL, 3,2),
("FLLPZAR4", "BLEU", "light Source", '2023-10-11', "Active", NULL, NULL, 3,2),
("FLLOLOPA", "SECUR", "Security Camera", '2023-10-12', "Active", NULL, NULL, 3,1),
("123OLOPA", "SECUR", "Security Camera", '2023-10-12', "Active", NULL, NULL, 3,1),

("JQ1RYKVQ", "KALINKA", "Audio Device", '2023-10-11', "Inactive", NULL, NULL, 4,1),
("CFJVIVZY", "KALINKA", "Audio Device", '2023-10-11', "Active", NULL, NULL, 4,1),
("PNDL5DUP", "BLEU", "light Source", '2023-10-11', "Active", NULL, NULL, 4,2),
("GHGKK1TW", "BLEU", "light Source", '2023-10-11', "Active", NULL, NULL, 4,2),
("BZAZA134", "BLEU", "light Source", '2023-10-11', "Active", NULL, NULL, 4,2),
("X4P623MC", "BLEU", "light Source", '2023-10-11', "Inactive", NULL, NULL, 4,2),
("VNL6FIUX", "SECUR", "Security Camera", '2023-10-12', "Active", NULL, NULL, 4,1),
("CTPOVY7M", "SECUR", "Security Camera", '2023-10-12', "Active", NULL, NULL, 4,1);

-- etc os restantes clientes teriam mais dispositivos

-- INVOICE 

-- Aqui vamos criar um trigger par podermos inserir a data do invoice baseada na data corrente 

INSERT INTO Invoice (InvoiceNumber, Date, ServicePackage, State, Contract_idContract)
VALUES
(822547, '2023-12-11', 2, "Paid", 1),
(801770, '2024-01-01', 1, "Paid", 2),
(951156, '2020-12-10', 3, "Paid", 3),
(852691, '2023-12-11', 2, "Paid", 4),
(169529, '2024-01-01', 1, "Pending", 5),
(416611, '2023-12-11', 2, "Pending", 6),
(106329, '2023-12-11', 1, "Pending", 7);



-- SELECT * FROM Clients;
-- SELECT * FROM Installation;
-- SELECT * FROM Contract;
-- SELECT * FROM Devices;
-- SELECT * FROM ServiceDesc;
-- SELECT * FROM Invoice;
-- SELECT * FROM suppliers;

-- RF4
call clients_by_installation_type("Home");
-- RF5
call clients_by_package_type(1); -- digit service package type (-- 1 lowcost , 2 normal, 3 professional)
-- RF6
call installation_devices('2020-01-01','2024-3-31',1); -- last digit installation code
-- RF7 
 call client_invoice_average('2019-01-01','2024-3-31',3); -- last digit is clientId
-- RF8 
 call installations_with_automations('2020-01-01','2024-03-31');
-- RF10
call total_clients_InvoiceState("Pending"); -- or "Paid"
-- RF 11
call total_Invoice_value_all_clients();
-- RF12
 select get_num_installations_client(3); -- digit is clientId

-- TODO 3, 12, (13, 14 martim) e falta mudar os procedimentos anonimos para não anonimos e falta dividir a tabela dos devices.
-- mudar o 8 e o 6



/*  DESCOMENTAR PRIMEIRA VEZ PRA CRIAR PROCEDIMENTOS E FUNCOES
-- RF4 Visualizar os dados de cliente cujas instalações sejam de uma determinada tipologia.
-- isto é basicamente um inner join entre clients e installation
DELIMITER $$$
CREATE PROCEDURE clients_by_installation_type(IN installation_type VARCHAR(15))
BEGIN	
	SELECT c.name, c.main_address, code as Installation_Code, i.address as Installation_address, i.Type
	FROM Clients c
	INNER JOIN installation i on c.idClient = i.Client_idClient
	WHERE
	i.Type = installation_type
	ORDER BY
	 name ASC;
END; $$$
DELIMITER;

-- RF5 Visualizar os clientes que tenham contratado um determinado pacote/serviço.
DELIMITER $$$
CREATE  PROCEDURE clients_by_package_type(IN ServiceType INT)
BEGIN	
	SELECT cl.name, cl.main_address, i.address as Installation_Address, s.name
	FROM installation i
	INNER JOIN Clients cl ON cl.idClient = i.Client_idClient
	INNER JOIN Contract co ON i.code = co.Installation_code
	INNER JOIN ServiceDesc s ON s.Type = co.ServiceDesc_Type 
	WHERE
		co.ServiceDesc_Type = ServiceType;
	-- 1 lowcost , 2 normal, 3 professional
END; $$$
DELIMITER;

-- RF6 Visualizar todos os dispositivos instalados numa dada instalação dentro de um intervalo de tempo.
DELIMITER $$$
CREATE  PROCEDURE installation_devices(IN startDate date, IN endDate date, IN installationCode INT)
BEGIN	
	SELECT d.* , i.address as Installation_address
	FROM Devices d
	INNER JOIN Installation i ON i.code = d.Installation_code
	WHERE
		 i.code = installationCode
		 and (d.InstallationDate >= startDate and d.InstallationDate <= endDate);
END; $$$
DELIMITER;

-- RF7 Visualizar o valor médio de faturação (fatura paga) de um cliente num intervalo de tempo
DELIMITER $$$
CREATE  PROCEDURE client_invoice_average(IN startDate date, IN endDate date, IN clientId INT)
BEGIN	

	SELECT cl.name, AVG(s.cost) as Average_Invoice_Value
	FROM Invoice inv
	INNER JOIN Contract co ON idContract = inv.Contract_idContract
	INNER JOIN ServiceDesc s ON s.Type = co.ServiceDesc_Type 
	INNER JOIN Installation i ON i.code = co.Installation_code
	INNER JOIN Clients cl ON cl.idClient = i.Client_idClient
	WHERE
		cl.idClient = clientId and -- escolhemos o joel que tem duas instalações
		(inv.Date >= startDate and inv.Date <= endDate);
END; $$$
DELIMITER;
 
 
-- RF8 Visualizar as instalações com automações, dentro de um intervalo de tempo.     
DELIMITER $$$
CREATE PROCEDURE installations_with_automations(IN startDate date, IN endDate date)
BEGIN	

	SELECT i.address as addresses_with_automations
	FROM Installation i
	RIGHT JOIN Devices d ON I.code = d.Installation_code
	WHERE
	(d.InstallationDate >= startDate and d.InstallationDate <= endDate)
	GROUP BY
	i.address
	ORDER BY
	 d.installation_code ASC;
     
END; $$$
DELIMITER;


 -- RF10 Proponha um requisito relevante ainda por identificar e que requeira uma query simples para o satisfazer (Query ou View usada numa Query). Implemente.
 -- Todos os clientes que ainda não pagaram o invoice
DELIMITER $$$
CREATE  PROCEDURE total_clients_InvoiceState(IN state VARCHAR(10))
BEGIN

	SELECT cl.name, cl.main_address, i.address as Installation_Address, inv.State
	FROM installation i
	INNER JOIN Clients cl ON cl.idClient = i.Client_idClient
	INNER JOIN Contract co ON i.code = co.Installation_code
	INNER JOIN Invoice inv ON co.idContract = inv.Contract_idContract
	WHERE
		inv.State = state
	ORDER BY
		cl.name ASC;
END; $$$
DELIMITER;
    
-- RF 11 Proponha um requisito relevante ainda por identificar e que requeira uma query com funções de agregação (sum, max, min, avg, etc) para o satisfazer. Implemente.
-- total pago ou por pagar por cada cliente
DELIMITER $$$
CREATE  PROCEDURE total_Invoice_value_all_clients()
BEGIN

	SELECT cl.name, inv.state , SUM(s.cost) as Invoice_Total
	FROM Invoice inv
	INNER JOIN Contract co ON idContract = inv.Contract_idContract
	INNER JOIN ServiceDesc s ON s.Type = co.ServiceDesc_Type 
	INNER JOIN Installation i ON i.code = co.Installation_code
	INNER JOIN Clients cl ON cl.idClient = i.Client_idClient
	GROUP BY
	cl.name
	ORDER BY
		cl.name ASC;
        
END; $$$
DELIMITER ;

-- RF 12 Proponha um requisito relevante ainda por identificar e que requeira o desenvolvimento de functions / procedures para o satisfazer. Implemente.
DELIMITER $$$
CREATE FUNCTION get_num_client_installations(ClientId int)
RETURNS int
BEGIN
	DECLARE total int;
	SELECT COUNT(i.code) INTO total
	FROM installation i
	INNER JOIN Clients cl ON cl.idClient = i.Client_idClient
	WHERE
		idClient = ClientId;
        
	RETURN total;

END; $$$
DELIMITER ;

-- RF 12 Proponha um requisito relevante ainda por identificar e que requeira o desenvolvimento de functions / procedures para o satisfazer. Implemente.
DELIMITER $$$
CREATE FUNCTION get_num_installations_client(ClientId int)
RETURNS int
BEGIN
	DECLARE total int;
	SELECT COUNT(i.code) INTO total
	FROM installation i
	INNER JOIN Clients cl ON cl.idClient = i.Client_idClient
	WHERE
		idClient = ClientId;
        
	RETURN total;

END; $$$
DELIMITER ;

*/

