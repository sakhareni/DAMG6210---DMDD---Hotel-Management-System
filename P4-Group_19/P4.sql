-- Employee Table
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(255),
    Designation VARCHAR(255),
    Address TEXT,
    Hiring_Date DATE
);

-- Customer Table
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(255),
    Customer_Phone VARCHAR(255),
    Ssn VARCHAR(255),
    Customer_Email VARCHAR(255),
    Hotel_ID INT
);

-- Reservation Table
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY,
    Check_In DATE,
    Check_Out DATE,
    Duration INT,
    Reservation_date DATE,
    Customer_ID INT,
    Room_ID INT,
    Transaction_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(RoomID),
    FOREIGN KEY (Transaction_ID) REFERENCES Transaction(Transaction_ID)
);

-- Transaction Table
CREATE TABLE Transaction (
    Transaction_ID INT PRIMARY KEY,
    Transaction_Type VARCHAR(255),
    Transaction_date DATE,
    Amount DECIMAL(10, 2)
);

-- Room Table
CREATE TABLE Room (
    RoomID INT PRIMARY KEY,
    Room_no VARCHAR(255),
    Room_Type VARCHAR(255)
);

-- Room Service Table
CREATE TABLE Room_Service (
    RS_ID INT PRIMARY KEY,
    Employee_ID INT,
    Customer_ID INT,
    Room_ID INT,
    Service_Type VARCHAR(255),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(RoomID)
);

-- InHouse Guest Table
CREATE TABLE InHouse_Guest (
    Guest_ID INT PRIMARY KEY,
    Customer_ID INT,
    Room_ID INT,
    Hotel_Phone_no VARCHAR(255),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(RoomID)
);

-- Restaurant Guest Table
CREATE TABLE Restaurant_Guest (
    Guest_ID INT PRIMARY KEY,
    Order_ID INT,
    Customer_ID INT,
    FOREIGN KEY (Order_ID) REFERENCES Order(Order_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

-- Order Table
CREATE TABLE Order (
    Order_ID INT PRIMARY KEY,
    Table_ID INT,
    Seating_Capacity INT,
    Server_ID INT
);

-- Restaurant Table
CREATE TABLE Restaurant (
    Order_ID INT PRIMARY KEY,
    Restaurant_Name VARCHAR(255),
    Table_Number INT,
    Amount DECIMAL(10, 2),
    Customer_Name VARCHAR(255),
    Transaction_id INT,
    Server_name VARCHAR(255),
    FOREIGN KEY (Transaction_id) REFERENCES Transaction(Transaction_ID)
);

-- Table Table
CREATE TABLE TableEntity (
    Table_ID INT PRIMARY KEY,
    Table_Number VARCHAR(255),
    Seating_Capacity INT
);

-- Parking Table
CREATE TABLE Parking (
    Parking_ID INT PRIMARY KEY,
    Phone_Number VARCHAR(255),
    Parking_Spot_number VARCHAR(255),
    Customer_ID INT,
    Employee_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

-- Adding Reservation Made By Relationship
ALTER TABLE Reservation
ADD CONSTRAINT FK_Reservation_Employee
FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID);
