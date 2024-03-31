
-- RF1 implementar operações CRUD da BD em termos de entidades identificadas para a BD obtida

use smart_buildingsdb;

-- CLEAR ALL TABLES FIRST
-- SET FOREIGN_KEY_CHECKS = 0; -- Disable foreign key checks

DELETE FROM Clients;
DELETE FROM ServiceDesc;
DELETE FROM Installation;
DELETE FROM Contract;
DELETE FROM Devices;
DELETE FROM Invoice;

-- SET FOREIGN_KEY_CHECKS = 1; -- Enable foreign key checks


--  aqui temos 5 clientes distintos
INSERT IGNORE INTO Clients ( name	, main_address	 ,	contact	 , NIF  	)
VALUES 	
( "Arnaldo"	, "O Quinto Crlh" ,	923144123, 123456789),
( "Armindo"	, "Picha"		  ,	923155123, 223456789),
( "Joel"	, "Mirandela"	  ,	923166123, 323456789),
( "Martim"	, "Pombal Leiria" ,	923999123, 553456789),
( "Rodrigo"	, "Benfica Lisboa",	999966123, 323456111);

-- Aqui o joel e o rodrigo tem duas instalações enquanto os restantes tem apenas uma
INSERT IGNORE INTO Installation (address, Client_idClient)   
VALUES 
("Rua das fontralhinhas Nº 130",1),
("Praceta da Certa  Nº 140",2),
("Avenida do Buçal Nº 130",3),
("Calçada da tapadinha Nº 130",3),
("Rua quintal de cima Nº 100",4),
("Alheira de mirandela Nº 14",5),
("Avenida das alheiras Nº 1",5);

-- tabela de desrição de serviço (custo é valor mensal e Max devices é tipos de dispositivos)
INSERT IGNORE INTO ServiceDesc (name, Cost, MaxDevices)
VALUES
("lowcost", 10, 2),
("Medium", 30, 4),
("Pro", 30, NULL);

-- CONTRACTS

INSERT IGNORE INTO Contract (StartDate, ServiceDuration, ServiceDesc_Type, Installation_code)
VALUES 
('2023-12-10', '3 years', 2, 1),
('2023-12-12', '2 years', 1, 2),
('2023-10-10', '1 year', 3, 3),
('2023-12-10', '1 year', 3, 4),
('2023-12-29', '3 years', 1, 5),
('2023-12-10', '2 years', 2, 6),
('2023-12-10', '2 years', 2, 7);


-- DEVICES 

INSERT IGNORE INTO Devices (MakerReference, Model, Type, InstalationDate, State, PowerConsumption, Eficiency, Installation_code)
VALUES 
("AHAH1908", "KONA", "Audio Device", '2023-12-11', "Active", NULL, NULL, 1),
("BHAH1908", "KONA", "Audio Device", '2023-12-11', "Active", NULL, NULL, 1),
("BLLPA134", "BLEU", "light Source", '2023-12-11', "Active", NULL, NULL, 1),
("BLLP2234", "BLEU", "light Source", '2023-12-11', "Active", NULL, NULL, 1),

("AHAH1908", "TERMOMO", "Thermostat", '2024-01-01', "Inactive", NULL, NULL, 2),
("LLLPA134", "BLEUV2", "light Source", '2024-01-01', "Active", "8 W", "50%", 2),
("PLLP2234", "BLEUV2", "light Source", '2024-01-01', "Active", "8 W", "50%", 2),

("BHBH1B08", "KALINKA", "Audio Device", '2023-10-11', "Inactive", NULL, NULL, 3),
("BAAA1A08", "KALINKA", "Audio Device", '2023-10-11', "Active", NULL, NULL, 3),
("BZAZA134", "BLEU", "light Source", '2023-10-11', "Active", NULL, NULL, 3),
("FLLPZAR4", "BLEU", "light Source", '2023-10-11', "Active", NULL, NULL, 3),
("FLLOLOPA", "SECUR", "Security Camera", '2023-10-12', "Active", NULL, NULL, 3),
("123OLOPA", "SECUR", "Security Camera", '2023-10-12', "Active", NULL, NULL, 3),

("JQ1RYKVQ", "KALINKA", "Audio Device", '2023-10-11', "Inactive", NULL, NULL, 4),
("CFJVIVZY", "KALINKA", "Audio Device", '2023-10-11', "Active", NULL, NULL, 4),
("PNDL5DUP", "BLEU", "light Source", '2023-10-11', "Active", NULL, NULL, 4),
("GHGKK1TW", "BLEU", "light Source", '2023-10-11', "Active", NULL, NULL, 4),
("BZAZA134", "BLEU", "light Source", '2023-10-11', "Active", NULL, NULL, 4),
("X4P623MC", "BLEU", "light Source", '2023-10-11', "Inactive", NULL, NULL, 4),
("VNL6FIUX", "SECUR", "Security Camera", '2023-10-12', "Active", NULL, NULL, 4),
("CTPOVY7M", "SECUR", "Security Camera", '2023-10-12', "Active", NULL, NULL, 4);

-- etc 

-- INVOICE 

INSERT IGNORE INTO Invoice (InvoiceNumber, Date, ServicePackage, State, Contract_idContract)
VALUES
(822547, '2023-12-11', 2, "Paid", 1),
(801770, '2024-01-01', 1, "Paid", 2),
(951156, '2023-12-10', 3, "Paid", 3),
(852691, '2023-12-11', 3, "Paid", 4),
(169529, '2024-01-01', 1, "Pending", 5),
(416611, '2023-12-11', 2, "Pending", 6),
(106329, '2023-12-11', 2, "Pending", 7);

SELECT * FROM Clients;
SELECT * FROM Installation;
SELECT * FROM Contract;
SELECT * FROM Devices;
SELECT * FROM ServiceDesc;
SELECT * FROM Invoice;

