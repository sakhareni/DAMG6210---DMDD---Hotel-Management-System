--Stored procedures --

--Q1 at least 3 stored procedures containing input and output parameters--


-- 1st Stored Procedure to Check in the customer
CREATE PROCEDURE CheckInGuest
   @ReservationID INT,
   @RoomNumber INT OUTPUT,
   @CustomerName VARCHAR(255) OUTPUT
AS
BEGIN
   SELECT
       @RoomNumber = r.Room_no,
       @CustomerName = c.Customer_Name
   FROM
       Reservation res
       JOIN Room r ON res.Room_ID = r.Room_ID
       JOIN Customer c ON res.Customer_ID = c.Customer_ID
   WHERE
       res.ReservationID = @ReservationID;
END;


DECLARE @RoomNumber INT, @CustomerName VARCHAR(255);
EXEC CheckInGuest
   @ReservationID = 1,
   @RoomNumber = @RoomNumber OUTPUT,
   @CustomerName = @CustomerName OUTPUT;


SELECT @RoomNumber AS RoomNumber, @CustomerName AS CustomerName;




-- 2nd stored procedure


CREATE PROCEDURE GetCustomerInfo
    @Customer_ID INT,
    @Customer_Name VARCHAR(255) OUTPUT,
    @Customer_Phone VARCHAR(20) OUTPUT,
    @Customer_Email VARCHAR(255) OUTPUT
AS
BEGIN
    SELECT
        @Customer_Name = Customer_Name,
        @Customer_Phone = Customer_Phone,
        @Customer_Email = Customer_Email
    FROM Customer
    WHERE Customer_ID = @Customer_ID;
END;
GO

-- Declare variables to hold the output data
DECLARE @Name VARCHAR(255);
DECLARE @Phone VARCHAR(20);
DECLARE @Email VARCHAR(255);

-- Execute the stored procedure
EXEC GetCustomerInfo
    @Customer_ID = 1, -- Assume you want to get details for customer ID 1
    @Customer_Name = @Name OUTPUT,
    @Customer_Phone = @Phone OUTPUT,
    @Customer_Email = @Email OUTPUT;

-- Select the output variables to view the results
SELECT
    @Name AS CustomerName,
    @Phone AS CustomerPhone,
    @Email AS CustomerEmail;

-- 3rd Procedure


CREATE PROCEDURE CalculateRoomOccupancyPercentage
   @OccupancyRate FLOAT OUTPUT
AS
BEGIN
   DECLARE @TotalRooms INT, @ReservedRooms INT;


   -- Count the total number of rooms
   SELECT @TotalRooms = COUNT(*) FROM Room;


   -- Count the number of distinct room IDs in the Reservation table
   SELECT @ReservedRooms = COUNT(DISTINCT Room_ID) FROM Reservation;


   -- Calculate the occupancy rate
   SET @OccupancyRate = (@ReservedRooms * 100.0) / @TotalRooms;


END;




DECLARE @OccupancyRate FLOAT;


EXEC CalculateRoomOccupancyPercentage @OccupancyRate OUTPUT;


SELECT @OccupancyRate AS 'Occupancy Rate (%)';


-- Q2. at least 3 views (often used for reporting purposes).--

i) View to calculate number of orders serviced by employees
CREATE VIEW EmployeeOrders AS
SELECT e.Name, e.Designation, COUNT(o.Order_ID) AS OrderCount
FROM Employee e
JOIN [Order] o ON e.Employee_ID = o.Employee_ID
GROUP BY e.Name, e.Designation;
SELECT Name, OrderCount FROM EmployeeOrders;


ii)/*View to show top spending customers*/
CREATE VIEW TopSpendingCustomers AS
SELECT TOP 10 c.Customer_ID, c.Customer_Name, SUM(t.Amount) AS TotalSpent
FROM [HotelCalifornia].[dbo].[Transaction] t
INNER JOIN (
    SELECT Transaction_ID, Customer_ID FROM [HotelCalifornia].[dbo].[Order]
    UNION ALL
    SELECT Transaction_ID, Customer_ID FROM [HotelCalifornia].[dbo].[Reservation]
) AS o ON t.Transaction_ID = o.Transaction_ID
INNER JOIN [HotelCalifornia].[dbo].[Customer] c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY TotalSpent DESC;


iii)/*View to show total revenue per month for inhouse guests booking rooms*//

GO
CREATE VIEW Room_Reservation_Revenue_By_Month AS
SELECT 
    YEAR(Reservation.Check_in) AS Year,
    MONTH(Reservation.Check_in) AS Month,
    SUM([Transaction].Amount) AS Total_Revenue
FROM 
    Reservation
INNER JOIN 
    [Transaction] ON Reservation.Transaction_ID = [Transaction].Transaction_ID
GROUP BY 
    YEAR(Reservation.Check_in),
    MONTH(Reservation.Check_in);



-- Q3 At least 1 DML trigger --

DML trigger 
CREATE TRIGGER Room_Reservation_Check
ON Reservation
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @RoomID INT, @CheckIn DATE, @CheckOut DATE;
    
    SELECT @RoomID = Room_ID, @CheckIn = Check_in, @CheckOut = Check_out
    FROM inserted;


    IF EXISTS (
        SELECT 1
        FROM Reservation
        WHERE Room_ID = @RoomID
          AND NOT (Check_out <= @CheckIn OR Check_in >= @CheckOut)
    )
    BEGIN
        RAISERROR ('Room is already reserved for the selected period.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;


-- This reservation conflicts with existing reservations
INSERT INTO Reservation (ReservationID, Check_in, Check_out, Reservation_date, Customer_ID, Room_ID, Transaction_ID)
VALUES
    (21, '2023-03-09', '2023-03-10', '2023-03-01', 21, 1, 78);

-- Q4  at least 3 Table-level CHECK Constraints

i) Constraints to check  if employee designation is ‘Valet’ in the parking table
GO
CREATE TRIGGER ValidateEmployeeRoleOnParking
ON Parking
AFTER INSERT, UPDATE
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Employee e ON i.Employee_ID = e.Employee_ID
        WHERE e.Designation = 'Valet'
    )
    BEGIN
        RAISERROR ('Only employees with Valet designation can be entered in Parking table.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


SELECT * FROM Parking

-- Checks if the Employee_ID is of designation is Valet Employee_ID is not valet

INSERT INTO Parking (Parking_ID, Phone_Number, Parking_Spot_number, Customer_ID, Employee_ID) VALUES
(22, '9876543210', 101, 1, 11);




ii) Constraint to verify Check-in, Reservation and Check-out Date
ALTER TABLE Reservation
ADD CONSTRAINT CHK_Reservation_ValidDates
CHECK (
    Check_in > Reservation_date AND
    Check_out > Check_in
);

-- Checks if the Check-in, Reservation and Check-out Date should fail

INSERT INTO Reservation 
    (ReservationID, Check_in, Check_out, Reservation_date, Customer_ID, Room_ID, Transaction_ID) 
VALUES 
    (23, '2022-05-01', '2023-05-10', '2023-04-20', 20, 20, 77);


iii) Employee Hiring date for current employee tables cannot be in the future
ALTER TABLE Employee
ADD CONSTRAINT CHK_Employee_Hiring_Date CHECK (Hiring_Date <= CAST(GETDATE() AS DATE));


INSERT INTO Employee (Name, Email, Phone, Designation, [Address], Hiring_Date)
VALUES ('John Doe', 'johndoe@example.com', '555-1234', 'Manager', '1234 Main St', '2025-04-01');
iv)  Transaction type is of a particular type ‘Payment’ and ‘Refund’ 
ALTER TABLE [Transaction]
ADD CONSTRAINT CHK_Transaction_Type CHECK (Transaction_Type IN ('Payment', 'Refund'));
INSERT INTO [Transaction] (Transaction_ID, Transaction_Type, Transaction_date, Amount)
VALUES (222, 'Charge', '2024-04-01', 200.00);
v) Making sure that Room Type and Room Number are of a particular type


ALTER TABLE Room
ADD CONSTRAINT CHK_Room_Number
CHECK (
  (Room_Type = 'Standard' AND Room_no LIKE '1%') OR
  (Room_Type = 'Deluxe' AND Room_no LIKE '2%') OR
  (Room_Type = 'Executive Suite' AND Room_no LIKE '3%') OR
  (Room_Type = 'Family Suite' AND Room_no LIKE '4%') OR
  (Room_Type = 'Presidential Suite' AND Room_no LIKE '5%') OR
  (Room_Type = 'Penthouse Suite' AND Room_no LIKE '6%')
);


-- Attempt to insert a Standard room with an invalid room number
INSERT INTO Room (Room_ID, Room_no, Room_Type, RoomTypeID) VALUES (37, 501, 'Standard', 1);


-- Q5 Computed Columns based on a user defined function (UDF)


CREATE FUNCTION dbo.CalculateStayDuration
(
   @Check_in DATE,
   @Check_out DATE
)
RETURNS INT
AS
BEGIN
   RETURN DATEDIFF(day, @Check_in, @Check_out);
END;


CREATE VIEW vw_ReservationDetails
AS
SELECT
   *,
   dbo.CalculateStayDuration(Check_in, Check_out) AS StayDuration
FROM
   Reservation;


SELECT
   ReservationID,
   Customer_ID,
   Check_in,
   Check_out,
   StayDuration
FROM
   vw_ReservationDetails;


-- Q6) Column Data Encryption
ALTER TABLE Customer
ADD SSN VARCHAR(20);


CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'California';
CREATE CERTIFICATE MyCertificate WITH SUBJECT = 'My Encryption Certificate';
CREATE SYMMETRIC KEY MySymmetricKey WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE MyCertificate;


OPEN SYMMETRIC KEY MySymmetricKey DECRYPTION BY CERTIFICATE MyCertificate;


-- INSERT STATEMENT TO CHECK

INSERT INTO Customer (Customer_ID, Customer_Name, Customer_Phone, SSN, Customer_Email)
VALUES (71, 'Nikhil Sakhare', '5554443333', EncryptByKey(Key_GUID('MySymmetricKey'), '432-10-9111'), 'nikhil.sakhare@example.com');
CLOSE SYMMETRIC KEY MySymmetricKey;


-- Q7. at least 3 non-clustered indexes

CREATE NONCLUSTERED INDEX IDX_Employee_Name ON Employee(Name);
CREATE NONCLUSTERED INDEX IDX_Employee_Designation ON Employee(Designation);
CREATE NONCLUSTERED INDEX IDX_Employee_HiringDate ON Employee(Hiring_Date);


CREATE NONCLUSTERED INDEX IDX_Transaction_Date ON [Transaction](Transaction_date);
CREATE NONCLUSTERED INDEX IDX_Transaction_Amount ON [Transaction](Amount);
CREATE NONCLUSTERED INDEX IDX_Transaction_Type ON [Transaction](Transaction_Type);


CREATE NONCLUSTERED INDEX IDX_Customer_Name ON Customer(Customer_Name);
CREATE NONCLUSTERED INDEX IDX_Customer_Email ON Customer(Customer_Email);
CREATE NONCLUSTERED INDEX IDX_Customer_Phone ON Customer(Customer_Phone);


-- The Query to verify if the index have been created or not


SELECT
    obj.name AS TableName,
    idx.name AS IndexName,
    idx.type_desc
FROM
    sys.indexes AS idx
INNER JOIN
    sys.objects AS obj ON idx.object_id = obj.object_id
WHERE
    idx.type_desc = 'NONCLUSTERED'
    AND obj.type = 'U';  -- U for User table


