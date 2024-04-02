Create Database Hotel_Management_System 
Use Hotel_Management_System

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(255),
    Customer_Phone VARCHAR(20),
    SSN VARCHAR(20),
    Customer_Email VARCHAR(255)
);

CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY,
    Check_in DATE,
    Check_out DATE,
    Reservation_date DATE,
    Customer_ID INT,
    Room_ID INT,
    Transaction_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
    
);

CREATE TABLE [Transaction] (
    Transaction_ID INT PRIMARY KEY,
    Transaction_Type VARCHAR(50),
    Transaction_date DATE,
    Amount DECIMAL(10, 2)
);

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20),
    Designation VARCHAR(255),
    Address TEXT,
    Hiring_Date DATE
);

CREATE TABLE Parking (
    Parking_ID INT PRIMARY KEY,
    Phone_Number VARCHAR(20),
    Parking_Spot_number INT,
    Customer_ID INT,
    Employee_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

CREATE TABLE [Order] (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Employee_ID INT,
    Transaction_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Transaction_ID) REFERENCES [Transaction](Transaction_ID)
    -- You may need additional information to differentiate between Room Service Orders and Restaurant Orders.
);

CREATE TABLE Room (
    Room_ID INT PRIMARY KEY,
    Room_Type VARCHAR(50)
    
);

CREATE TABLE Room_Type (
    RoomTypeID INT PRIMARY KEY,
    Price DECIMAL(10, 2),
    Description TEXT
);

CREATE TABLE Amenities (
    AmenityID INT PRIMARY KEY,
    AmenityName VARCHAR(255)
);

CREATE TABLE Room_Amenities (
    RoomAmenitiesID INT PRIMARY KEY,
    RoomTypeID INT,
    AmenityID INT,
    Status VARCHAR(50),
    FOREIGN KEY (RoomTypeID) REFERENCES Room_Type(RoomTypeID),
    FOREIGN KEY (AmenityID) REFERENCES Amenities(AmenityID)
);

CREATE TABLE Restaurant (
    Restaurant_ID INT PRIMARY KEY,
    Restaurant_Name VARCHAR(255)
);

CREATE TABLE [Table] (
    Table_ID INT PRIMARY KEY,
    Table_Number INT,
    Seating_Capacity INT
);

CREATE TABLE Room_Service (
    OrderID INT,
    Room_ID INT,
    FOREIGN KEY (OrderID) REFERENCES [Order](Order_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

CREATE TABLE Restaurant_Order (
    OrderID INT,
    Restaurant_ID INT,
    Table_ID INT,
    FOREIGN KEY (OrderID) REFERENCES [Order](Order_ID),
    FOREIGN KEY (Restaurant_ID) REFERENCES Restaurant(Restaurant_ID),
    FOREIGN KEY (Table_ID) REFERENCES [Table](Table_ID)
);

CREATE TABLE Inhouse_Guest (
    Customer_ID INT,
    Hotel_Phone_No VARCHAR(20),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Restaurant_Guest (
    Customer_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);
