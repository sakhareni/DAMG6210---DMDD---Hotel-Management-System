-- Inserting data into Customer table
INSERT INTO Customer VALUES 
(1, 'John Doe', '123-456-7890', '123-45-6789', 'johndoe@email.com'),
(2, 'Jane Smith', '234-567-8901', '987-65-4321', 'janesmith@email.com'),
(3, 'Emily White', '345-678-9012', '212-33-4455', 'emilywhite@email.com'),
(4, 'David Brown', '456-789-0123', '323-44-5566', 'davidbrown@email.com'),
(5, 'Olivia Green', '567-890-1234', '434-55-6677', 'oliviagreen@email.com'),
(6, 'Michael Scott', '678-901-2345', '545-66-7788', 'michaelscott@email.com'),
(7, 'Linda Black', '789-012-3456', '656-77-8899', 'lindablack@email.com'),
(8, 'Robert Grey', '890-123-4567', '767-88-9900', 'robertgrey@email.com'),
(9, 'Patricia Silver', '901-234-5678', '878-99-0011', 'patriciasilver@email.com'),
(10, 'James Gold', '012-345-6789', '989-00-1122', 'jamesgold@email.com');

-- Inserting data into Reservation table
INSERT INTO Reservation VALUES 
(1, '2023-01-10', '2023-01-15', '2022-12-20', 1, 101, 1001),
(2, '2023-02-20', '2023-02-25', '2023-01-18', 2, 102, 1002),
(3, '2023-03-01', '2023-03-05', '2023-02-15', 3, 103, 1003),
(4, '2023-04-10', '2023-04-15', '2023-03-20', 4, 104, 1004),
(5, '2023-05-20', '2023-05-25', '2023-04-30', 5, 105, 1005),
(6, '2023-06-15', '2023-06-20', '2023-05-25', 6, 106, 1006),
(7, '2023-07-10', '2023-07-15', '2023-06-20', 7, 107, 1007),
(8, '2023-08-05', '2023-08-10', '2023-07-25', 8, 108, 1008),
(9, '2023-09-01', '2023-09-06', '2023-08-20', 9, 109, 1009),
(10, '2023-10-10', '2023-10-15', '2023-09-30', 10, 110, 1010);

-- Inserting data into Transaction table
INSERT INTO [Transaction] VALUES 
(1001, 'Payment', '2023-01-10', 200.00),
(1002, 'Payment', '2023-02-20', 250.00),
(1003, 'Payment', '2023-03-01', 300.00),
(1004, 'Payment', '2023-04-10', 350.00),
(1005, 'Payment', '2023-05-20', 400.00),
(1006, 'Payment', '2023-06-15', 450.00),
(1007, 'Payment', '2023-07-10', 500.00),
(1008, 'Payment', '2023-08-05', 550.00),
(1009, 'Payment', '2023-09-01', 600.00),
(1010, 'Payment', '2023-10-10', 650.00);

-- Inserting data into Employee table
INSERT INTO Employee VALUES 
(1, 'Alice Johnson', 'alice@email.com', '345-678-9012', 'Receptionist', '123 Main St', '2021-05-01'),
(2, 'Bob Williams', 'bob@email.com', '456-789-0123', 'Manager', '456 Elm St', '2020-04-15'),
(3, 'Chris Red', 'chrisred@email.com', '789-012-3456', 'Housekeeping', '789 Pine St', '2019-08-15'),
(4, 'Laura Blue', 'laurablue@email.com', '890-123-4567', 'Chef', '234 Oak St', '2018-07-10'),
(5, 'Ethan Black', 'ethanblack@email.com', '901-234-5678', 'Manager', '345 Maple St', '2017-06-05'),
(6, 'Mia White', 'miawhite@email.com', '012-345-6789', 'Receptionist', '456 Birch St', '2020-09-20'),
(7, 'Noah Brown', 'noahbrown@email.com', '123-456-7890', 'Maintenance', '567 Cedar St', '2021-10-25'),
(8, 'Isabella Green', 'isabellagreen@email.com', '234-567-8901', 'Spa Manager', '678 Spruce St', '2019-11-30'),
(9, 'William Purple', 'williampurple@email.com', '345-678-9012', 'Concierge', '789 Redwood St', '2018-12-15'),
(10, 'Sophia Yellow', 'sophiayellow@email.com', '456-789-0123', 'Housekeeping Supervisor', '890 Palm St', '2020-01-20');

-- Inserting data into Parking table
INSERT INTO Parking VALUES 
(1, '567-890-1234', 101, 1, null),
(2, '678-901-2345', 102, null, 1),
(3, '234-567-8901', 103, 3, 3),
(4, '345-678-9012', 104, 4, 4),
(5, '456-789-0123', 105, 5, 5),
(6, '567-890-1234', 106, 6, 6),
(7, '678-901-2345', 107, 7, 7),
(8, '789-012-3456', 108, 8, 8),
(9, '890-123-4567', 109, 9, 9),
(10, '901-234-5678', 110, 10, 10);

-- Inserting data into Order table
INSERT INTO [Order] VALUES 
(1, 1, 1, 1001),
(2, 2, 2, 1002),
(3, 3, 3, 1003),
(4, 4, 4, 1004),
(5, 5, 5, 1005),
(6, 6, 6, 1006),
(7, 7, 7, 1007),
(8, 8, 8, 1008),
(9, 9, 9, 1009),
(10, 10, 10, 1010);

-- Inserting data into Room table
INSERT INTO Room VALUES 
(101, 'Single'),
(102, 'Double'),
(103, 'Suite'),
(104, 'Single'),
(105, 'Double'),
(106, 'Suite'),
(107, 'Single'),
(108, 'Double'),
(109, 'Suite'),
(110, 'Single'); 

-- Inserting data into Room_Type table
INSERT INTO Room_Type VALUES 
(1, 100.00, 'Single Bed Room'),
(2, 150.00, 'Double Bed Room'),
(3, 200.00, 'Deluxe Single Room'),
(4, 250.00, 'Deluxe Double Room'),
(5, 300.00, 'Executive Suite'),
(6, 350.00, 'Presidential Suite'),
(7, 400.00, 'Honeymoon Suite'),
(8, 450.00, 'Penthouse Suite'),
(9, 500.00, 'SkyVilla'),
(10, 550.00, 'SkyVillaUltra');

-- Inserting data into Amenities table
INSERT INTO Amenities VALUES 
(1, 'WiFi'),
(2, 'TV'),
(3, 'Pool'),
(4, 'Spa'),
(5, 'Gym'),
(6, 'Bar'),
(7, 'Restaurant'),
(8, 'Conference Room'),
(9, 'Parking'),
(10, 'Laundry Service');

-- Inserting data into Room_Amenities table
INSERT INTO Room_Amenities VALUES 
(1, 1, 1, 'Active'),
(2, 2, 2, 'Active'),
(3, 3, 3, 'Active'),
(4, 4, 4, 'Active'),
(5, 5, 5, 'Active'),
(6, 6, 6, 'Active'),
(7, 7, 7, 'Active'),
(8, 8, 8, 'Active'),
(9, 9, 9, 'Active'),
(10, 10, 10, 'Active');

-- Inserting data into Restaurant table
INSERT INTO Restaurant VALUES 
(1, 'The Great Eatery'),
(2, 'The Coffee Corner'),
(3, 'Italian Bistro'),
(4, 'Chinese Garden'),
(5, 'Mexican Grill'),
(6, 'Japanese Sushi'),
(7, 'French Cafe'),
(8, 'Indian Curry House'),
(9, 'Thai Street Food'),
(10, 'American Diner');

-- Inserting data into Table table
INSERT INTO [Table] VALUES 
(1, 1, 4),
(2, 2, 2),
(3, 3, 4),
(4, 4, 2),
(5, 5, 6),
(6, 6, 8),
(7, 7, 10),
(8, 8, 3),
(9, 9, 5),
(10, 10, 4);


-- Inserting data into Room_Service table
INSERT INTO Room_Service VALUES 
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105),
(6, 106),
(7, 107),
(8, 108),
(9, 109),
(10, 110);

-- Inserting data into Restaurant_Order table
INSERT INTO Restaurant_Order VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);

-- Inserting data into Inhouse_Guest table
INSERT INTO Inhouse_Guest (Customer_ID, Hotel_Phone_No) VALUES 
(1, '800-123-4567'),
(2, '800-123-4568'),
(3, '800-123-4569'),
(4, '800-123-4570'),
(5, '800-123-4571'),
(6, '800-123-4567'),
(7, '800-123-4568'),
(8, '800-123-4569'),
(9, '800-123-4570'),
(10, '800-123-4571');

-- Inserting data into Restaurant_Guest table
INSERT INTO Restaurant_Guest (Customer_ID) VALUES 
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);


Use Hotel_Management_System
