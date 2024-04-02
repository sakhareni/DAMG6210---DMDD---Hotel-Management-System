USE Hotel_Management_System

--1st Stored Procedure 
CREATE PROCEDURE GetCustomerReservationDetails
    @Customer_ID INT,
    @CustomerName VARCHAR(255) OUTPUT,
    @ReservationDetails NVARCHAR(MAX) OUTPUT,
    @RoomDetails NVARCHAR(MAX) OUTPUT,
    @ParkingDetails NVARCHAR(MAX) OUTPUT,
    @TransactionDetails NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SELECT 
        @CustomerName = c.Customer_Name,
        @ReservationDetails = 'Check-in: ' + CONVERT(VARCHAR, r.Check_in) + 
                              ', Check-out: ' + CONVERT(VARCHAR, r.Check_out),
        @RoomDetails = 'Room ID: ' + CONVERT(VARCHAR, rm.Room_ID) + 
                       ', Room Type: ' + rm.Room_Type, 
        @ParkingDetails = 'Parking Spot: ' + CONVERT(VARCHAR, p.Parking_Spot_number) + 
                          ', Phone Number: ' + p.Phone_Number,
        @TransactionDetails = 'Transaction ID: ' + CONVERT(VARCHAR, t.Transaction_ID) + 
                              ', Amount: ' + CONVERT(VARCHAR, t.Amount)
    FROM 
        Customer c
    INNER JOIN 
        Reservation r ON c.Customer_ID = r.Customer_ID
    INNER JOIN 
        Room rm ON r.Room_ID = rm.Room_ID
    LEFT JOIN 
        Parking p ON c.Customer_ID = p.Customer_ID
    LEFT JOIN 
        [Transaction] t ON r.Transaction_ID = t.Transaction_ID
    WHERE 
        c.Customer_ID = @Customer_ID;
END;



-- Execution of stores procedure 

DECLARE @CustomerName VARCHAR(255),
        @ReservationDetails NVARCHAR(MAX),
        @RoomDetails NVARCHAR(MAX),
        @ParkingDetails NVARCHAR(MAX),
        @TransactionDetails NVARCHAR(MAX);

EXEC GetCustomerReservationDetails
    @Customer_ID = 1, 
    @ReservationDetails = @ReservationDetails OUTPUT,
    @RoomDetails = @RoomDetails OUTPUT,
    @ParkingDetails = @ParkingDetails OUTPUT,
    @TransactionDetails = @TransactionDetails OUTPUT;

SELECT @CustomerName AS CustomerName,
       @ReservationDetails AS ReservationDetails,
       @RoomDetails AS RoomDetails,
       @ParkingDetails AS ParkingDetails,
       @TransactionDetails AS TransactionDetails;




-- 2nd Store Procedure 
CREATE PROCEDURE GetEmployeeParkingInfo
    @Employee_ID INT,
    @EmployeeDetails NVARCHAR(MAX) OUTPUT,
    @TotalParkingSlots INT OUTPUT
AS
BEGIN
    -- Retrieve employee details
    SELECT 
        @EmployeeDetails = 'Name: ' + e.Name + ', Email: ' + e.Email + ', Designation: ' + e.Designation
    FROM 
        Employee e
    WHERE 
        e.Employee_ID = @Employee_ID;

    -- Get the total number of parking slots assigned to the employee
    SELECT 
        @TotalParkingSlots = COUNT(*)
    FROM 
        Parking p
    WHERE 
        p.Employee_ID = @Employee_ID;
END;


DECLARE @EmployeeDetails NVARCHAR(MAX), @TotalParkingSlots INT;

EXEC GetEmployeeParkingInfo
    @Employee_ID = 1,  
    @EmployeeDetails = @EmployeeDetails OUTPUT,
    @TotalParkingSlots = @TotalParkingSlots OUTPUT;

SELECT @EmployeeDetails AS EmployeeDetails, @TotalParkingSlots AS TotalParkingSlots;



-- 3rd Stored Procedure 

CREATE PROCEDURE GetRestaurantDetails 
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        r.Restaurant_Name,
        ro.OrderID,
        c.Customer_Name,
        c.Customer_Phone,
        o.Transaction_ID,
        e.Name AS Employee_Name,
        e.Designation,
        t.Table_Number,
        t.Seating_Capacity
    FROM Restaurant_Order ro
    INNER JOIN [Order] o ON ro.OrderID = o.Order_ID
    INNER JOIN Customer c ON o.Customer_ID = c.Customer_ID
    INNER JOIN Employee e ON o.Employee_ID = e.Employee_ID
    INNER JOIN [Table] t ON ro.Table_ID = t.Table_ID
    INNER JOIN Restaurant r ON ro.Restaurant_ID = r.Restaurant_ID;
END;
GO



EXEC GetRestaurantDetails;

