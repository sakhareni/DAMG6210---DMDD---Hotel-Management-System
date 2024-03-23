-- Table `Hotel`
CREATE TABLE Hotel (
    Hotel_ID INT AUTO_INCREMENT PRIMARY KEY,
    Hotel_Name VARCHAR(255) NOT NULL,
    Hotel_Address VARCHAR(255) NOT NULL,
    Hotel_Phone_no VARCHAR(50) NOT NULL
);

-- Table `Events`
CREATE TABLE Events (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    EventName VARCHAR(255) NOT NULL,
    EventDescription TEXT,
    EventStartDate DATE NOT NULL,
    Hotel_ID INT,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID)
);

-- Table `Customer`
CREATE TABLE Customer (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_Name VARCHAR(255) NOT NULL,
    Customer_Phone VARCHAR(50),
    Ssn VARCHAR(50),
    Customer_Email VARCHAR(255),
    Hotel_ID INT,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID)
);

-- Table `Amenities`
CREATE TABLE Amenities (
    Amenity_ID INT AUTO_INCREMENT PRIMARY KEY,
    Amenity_Name VARCHAR(255) NOT NULL,
    Amenity_Location VARCHAR(255)
);

-- Table `Amenity_Usage`
CREATE TABLE Amenity_Usage (
    Customer_ID INT,
    Amenity_ID INT,
    PRIMARY KEY (Customer_ID, Amenity_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Amenity_ID) REFERENCES Amenities(Amenity_ID)
);

-- Table `Room`
CREATE TABLE Room (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    Room_no VARCHAR(50) NOT NULL,
    Room_Type VARCHAR(50) NOT NULL,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID)
);

-- Table `Reservation`
CREATE TABLE Reservation (
    ReservationID INT AUTO_INCREMENT PRIMARY KEY,
    Check_In DATE NOT NULL,
    Check_Out DATE NOT NULL,
    Duration INT NOT NULL,
    Reservation_date DATE NOT NULL,
    Customer_ID INT,
    Room_ID INT,
    Transaction_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(RoomID),
    FOREIGN KEY (Transaction_ID) REFERENCES Finance(Transaction_ID)
);

-- Table `Finance`
CREATE TABLE Finance (
    Transaction_ID INT AUTO_INCREMENT PRIMARY KEY,
    Transaction_Type VARCHAR(50) NOT NULL,
    Transaction_date DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL
);

-- Table `Employee`
CREATE TABLE Employee (
    Employee_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phone VARCHAR(50) NOT NULL,
    Designation VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Hiring_Date DATE NOT NULL
);

-- Table `Room_Service`
CREATE TABLE Room_Service (
    RS_ID INT AUTO_INCREMENT PRIMARY KEY,
    Employee_ID INT,
    Food_Item VARCHAR(255) NOT NULL,
    Customer_ID INT,
    Room_ID INT,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(RoomID)
);

-- Table `Restaurant`
CREATE TABLE Restaurant (
    Order_Id INT AUTO_INCREMENT PRIMARY KEY,
    Table_ID INT,
    Seating_Capacity INT,
    Server_ID INT,
    FOREIGN KEY (Server_ID) REFERENCES Employee(Employee_ID)
);

-- Table `Parking`
CREATE TABLE Parking (
    Parking_ID INT AUTO_INCREMENT PRIMARY KEY,
    Phone_Number VARCHAR(50) NOT NULL,
    Parking_Spot_number VARCHAR(50) NOT NULL,
    Customer_ID INT,
    Employee_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

-- Table `Working_Schedule`
CREATE TABLE Working_Schedule (
    AmenityID INT,
    EmployeeID INT,
    Shift_Time VARCHAR(50) NOT NULL,
    PRIMARY KEY (AmenityID, EmployeeID),
    FOREIGN KEY (AmenityID) REFERENCES Amenities(Amenity_ID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(Employee_ID)
);

-- Additional tables based on your ERD

-- Table `Table`
CREATE TABLE Table (
    Table_ID INT AUTO_INCREMENT PRIMARY KEY,
    Table_Number INT NOT NULL,
    Seating_Capacity INT NOT NULL
);

-- Table `Restaurant_Reservation`
CREATE TABLE Restaurant_Reservation (
    Room_Reservation_ID INT AUTO_INCREMENT PRIMARY KEY,
    Reservation_ID INT,
    Table_ID INT,
    FOREIGN KEY (Reservation_ID) REFERENCES Reservation(ReservationID),
    FOREIGN KEY (Table_ID) REFERENCES Table(Table_ID)
);

-- Table `Room_Reservation`
CREATE TABLE Room_Reservation (
    Room_Reservation_ID INT AUTO_INCREMENT PRIMARY KEY,
    Reservation_ID INT,
    Room_ID INT,
    FOREIGN KEY (Reservation_ID) REFERENCES Reservation(ReservationID),
    FOREIGN KEY (Room_ID) REFERENCES Room(RoomID)
);

-- Table `Guest`
CREATE TABLE Guest (
    Guest_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

-- Table `Order`
CREATE TABLE `Order` (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Table_ID INT,
    Seating_Capacity INT,
    Server_ID INT,
    FOREIGN KEY (Table_ID) REFERENCES Table(Table_ID),
    FOREIGN KEY (Server_ID) REFERENCES Employee(Employee_ID)
);
