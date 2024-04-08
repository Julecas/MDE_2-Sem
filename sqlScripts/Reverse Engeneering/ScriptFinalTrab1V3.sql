use smart_buildingsdb;
SET FOREIGN_KEY_CHECKS = 0; 

DELETE FROM Clients;
DELETE FROM Contract;
DELETE FROM DevicesInput;
DELETE FROM DevicesOutput;
DELETE FROM DeviceStateDesc;
DELETE FROM DeviceTypeDesc;
DELETE FROM DeviceDesc;
DELETE FROM Installation;
DELETE FROM InstallationTypeDesc;
DELETE FROM ServiceDesc;
DELETE FROM Invoice;
DELETE FROM InvoiceStateDesc;
DELETE FROM Suppliers;

ALTER TABLE `Clients`               AUTO_INCREMENT = 0;
ALTER TABLE `Contract`              AUTO_INCREMENT = 0;
ALTER TABLE `DevicesInput`          AUTO_INCREMENT = 0;
ALTER TABLE `DevicesOutput`         AUTO_INCREMENT = 0;
ALTER TABLE `DeviceStateDesc`       AUTO_INCREMENT = 0;
ALTER TABLE `DeviceTypeDesc`        AUTO_INCREMENT = 0;
ALTER TABLE `DeviceDesc`            AUTO_INCREMENT = 0;
ALTER TABLE `Installation`          AUTO_INCREMENT = 0;
ALTER TABLE `InstallationTypeDesc`  AUTO_INCREMENT = 0;
ALTER TABLE `ServiceDesc`           AUTO_INCREMENT = 0;
ALTER TABLE `Invoice`               AUTO_INCREMENT = 0;
ALTER TABLE `InvoiceStateDesc`      AUTO_INCREMENT = 0;
ALTER TABLE `Suppliers`             AUTO_INCREMENT = 0;

INSERT IGNORE INTO ServiceDesc (name, Cost, MaxDevices)
VALUES	("Lowcost", 10, 2),
		("Normal", 20, 4),
		("Professional", 30, NULL);
INSERT IGNORE INTO 
InvoiceStateDesc (StateID, Description)
		  VALUES (0		 , "Pending"  ),
				 (1		 , "Paid" 	  );
INSERT IGNORE INTO 
InstallationTypeDesc (TypeID, Name)
			  VALUES ( 1	, "House" 		),
					 ( 2	, "Office" 		),
					 ( 3	, "Apartment" 	),
                     ( 4	, "Store"	 	);
INSERT INTO Suppliers (name , main_address,contact)
VALUES
("BOBOTECH", "38043 My Wells, North Celinaburgh, OH 35513-7729","+14028867850"),
("StayFreshINC", "5708 O'Keefe Vista, Port Israelmouth, AL 31806","+18175445111"),
("SAMSUNG","Everland-ro, Pogok-eup, Cheoin-gu, Yongin-si, Gyeonggi-do, Korea","82-31-320-5000");
INSERT IGNORE INTO 
DeviceTypeDesc 	( Description )
		Values 	( "Input"  ),
				( "Output" ),
                ( "Input/Output" );
INSERT INTO 
DeviceDesc 	( Model 			, SupplierID 	, TypeID)
	Values 	( "Bleu"			, 1 			, 2		),
			( "Fridge"			, 1 			, 2		),
			( "Smart Plug"		, 3 			, 3		),
            ( "Washing Machine"	, 2				, 2		),
            ( "Termomo"			, 2				, 1		),
			( "AC"				, 2 			, 2		);
INSERT IGNORE INTO 
DeviceStateDesc ( Description )
		 Values ( "Active" ),
				( "Inactive" );
                
Select * from Clients;
Select * from Contract;
Select * from DevicesInput;
Select * from DevicesOutput;
Select * from DeviceStateDesc;
Select * from DeviceTypeDesc;
Select * from DeviceDesc;
Select * from Installation;
Select * from InstallationTypeDesc;
Select * from ServiceDesc;
Select * from Invoice;
Select * from InvoiceStateDesc;
Select * from Suppliers;                

