INSERT into Users
	(Username, Password, Firstname, Lastname, Phone, Email, IsReviewer, IsAdmin)
		VALUES
			('FredFredders', 'fred', 'Fred', 'Fredders', 123-123-1234, 'FredFredders@gmail.com', 1, 1), /*admin & review*/
			('ScottScotters', 'scott', 'Scott', 'Scotters', 123-123-1234, 'ScottScotters@gmail.com', 1, 0), /*admin*/
			('ToddTodders', 'todd', 'Todd', 'Todders', 123-123-1234, 'ToddTodders@gmail.com', 0, 0) /*review*/
; 
go
Insert into Vendors
	(Code, Name, Address, City, State, Zip, Phone, Email)
		Values
			('Dell', 'Dell', '1 Dell Way', 'Round Rock', 'TX', 78682, 877-717-3355,'Dell@gmail.com'),
			('Uline', 'Uline', '12575 Uline Drive', 'Pleasant Prairie', 'WI', 53158, 800-295-5510,'Uline@gmail.com'),
			('Micro', 'Micro Center', '11755 Mosteller Rd', 'Sharonville', 'OH', 45241, 513-782-8500, 'MicroCenter@gmail.com'),
			('Cost', 'Costco', '9691 Waterstone Blvd', 'Cincinnati', 'OH', 45249, 513-774-0024, 'Costco@gmail.com')
; 
go
INSERT into Products
	(PartNbr, Name, Price, Unit, VendorId)
		VALUES
			('DL14LAT', 'Laptop 14', 650.00, 'each', (SELECT Id From Vendors where Code = 'Dell')),
			('DL15LAT', 'Laptop 15', 750.00, 'each', (SELECT Id From Vendors where Code = 'Dell')),
			('DM24OLED', 'Monitor 24', 320.00, 'each', (SELECT Id From Vendors where Code = 'Dell')),
			('UP12', 'Pencils', 3.99, 'each', (SELECT Id From Vendors where Code = 'Uline')),
			('UDO', 'Desk Organizer', 12.50, 'each', (SELECT Id From Vendors where Code = 'Uline')),
			('UNP', 'Note Pad', 0.99, 'each', (SELECT Id From Vendors where Code = 'Uline')),
			('UBP12', 'Black Pens', 4.99, 'each', (SELECT Id From Vendors where Code = 'Uline')),
			('MMP', 'Mouse Pad', 12.99, 'each', (SELECT Id From Vendors where Code = 'Micro')),
			('MMO', 'Mouse', 12.99, 'each', (SELECT Id From Vendors where Code = 'Micro')),
			('MUSB32', '32 GB USB', 9.99, 'each', (SELECT Id From Vendors where Code = 'Micro')),
			('MUSB64', '64 GB USB', 27.99, 'each', (SELECT Id From Vendors where Code = 'Micro')),
			('CSC', 'Chips', 0.99, 'each', (SELECT Id From Vendors where Code = 'Cost')),
			('CSA', 'Apple', 0.50, 'each', (SELECT Id From Vendors where Code = 'Cost')),
			('CSB', 'Beef Jerky', 12.99, 'each', (SELECT Id From Vendors where Code = 'Cost'))
			
; 
go
Insert into Requests
	(Description, Justification, DeliveryMode, Status, Total, UserId)
		Values
			('Desk Supplies','Productivity', 'PickUp', 'NEW', 0.0, (select Id from Users where Username = 'FredFredders')),
			('Snacks', 'Hungry', 'PickUp', 'NEW', 0.0, (select Id from Users where Username = 'ScottScotters')),
			('Storage', 'Current Project', 'PickUp', 'NEW', 0.0, (select Id from Users where Username = 'ToddTodders')),
			('Pens and Pencils', 'Need to take notes', 'PickUp', 'NEW', 0.0, (select Id from Users where Username = 'ScottScotters')),
			('Some Pens and Pencils', 'For my hellokitty note pad', 'PickUp', 'NEW', 0.0, (select Id from Users where Username = 'FredFredders'))
; 

go
Insert into RequestLines
	(Quantity, RequestId, ProductId)
		Values
			(3,(select Id from Requests where Description = 'Desk Supplies'),(select Id from Products where PartNbr = 'DL15LAT')),
			(10,(select Id from Requests where Description = 'Snacks'),(select Id from Products where PartNbr = 'CSC')),
			(1,(select Id from Requests where Description = 'Storage'),(select Id from Products where PartNbr = 'MUSB64')),
			(2,(select Id from Requests where Description = 'Pens and Pencils'),(select Id from Products where PartNbr = 'UP12')),
			(2,(select Id from Requests where Description = 'Pens and Pencils'),(select Id from Products where PartNbr = 'UBP12')),
			(2,(select Id from Requests where Description = 'Some Pens and Pencils'),(select Id from Products where PartNbr = 'UP12')),
			(1,(select Id from Requests where Description = 'Some Pens and Pencils'),(select Id from Products where PartNbr = 'UBP12')),
			(1,(select Id from Requests where Description = 'Desk Supplies'),(select Id from Products where PartNbr = 'DM24OLED')),
			(1,(select Id from Requests where Description = 'Desk Supplies'),(select Id from Products where PartNbr = 'MMP')),
			(1,(select Id from Requests where Description = 'Desk Supplies'),(select Id from Products where PartNbr = 'MMO'))
; 
go