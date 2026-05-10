CREATE DATABASE IF NOT EXISTS Outdoor_Adventure;
USE Outdoor_Adventure;

-- drop tables if they are present
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS EquipmentSale;
DROP TABLE IF EXISTS EquipmentRental;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS TripSupply;
DROP TABLE IF EXISTS Supply;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS TripGuide;
DROP TABLE IF EXISTS Trip;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS `Role`;


-- ============================
-- ROLE
-- ============================
CREATE TABLE Role (
    RoleID INT PRIMARY KEY auto_increment,
    RoleName VARCHAR(100) NOT NULL
);

-- ============================
-- EMPLOYEE
-- ============================
CREATE TABLE Employee (
    EmployeeID INT auto_increment KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    RoleID INT,
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID)
);

-- ============================
-- LOCATION
-- ============================
CREATE TABLE Location (
    LocationID INT auto_increment KEY,
    RegionName VARCHAR(100),
    Destination VARCHAR(100)
);

-- ============================
-- TRIP
-- ============================
CREATE TABLE Trip (
    TripID INT auto_increment KEY,
    LocationID INT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    MaxParticipants INT,
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

-- ============================
-- TRIP GUIDE (bridge table)
-- ============================
CREATE TABLE TripGuide (
    TripID INT,
    EmployeeID INT,
    PRIMARY KEY (TripID, EmployeeID),
    FOREIGN KEY (TripID) REFERENCES Trip(TripID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- ============================
-- SUPPLIER
-- ============================
CREATE TABLE Supplier (
    SupplierID INT auto_increment KEY,
    SupplierName VARCHAR(100),
    ContactInfo VARCHAR(255)
);

-- ============================
-- SUPPLY
-- ============================
CREATE TABLE Supply (
    SupplyID INT PRIMARY KEY,
    SupplierID INT,
    Category VARCHAR(100),
    PurchaseDate DATE,
    Quantity INT,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- ============================
-- TRIP SUPPLY (bridge table)
-- ============================
CREATE TABLE TripSupply (
    TripID INT,
    SupplyID INT,
    QuantityUsed INT,
    PRIMARY KEY (TripID, SupplyID),
    FOREIGN KEY (TripID) REFERENCES Trip(TripID),
    FOREIGN KEY (SupplyID) REFERENCES Supply(SupplyID)
);

-- ============================
-- CUSTOMER
-- ============================
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    ContactInfo VARCHAR(255),
    RunningBalance DECIMAL(10,2)
);

-- ============================
-- BOOKING
-- ============================
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY,
    TripID INT,
    CustomerID INT,
    BookingDate DATE,
    FOREIGN KEY (TripID) REFERENCES Trip(TripID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- ============================
-- EQUIPMENT
-- ============================
CREATE TABLE Equipment (
    EquipmentID INT PRIMARY KEY,
    EquipmentType VARCHAR(100),
    PurchaseDate DATE,
    `Condition` VARCHAR(100),
    QuantityAvailable INT
);

-- ============================
-- EQUIPMENT RENTAL
-- ============================
CREATE TABLE EquipmentRental (
    RentalID INT PRIMARY KEY,
    CustomerID INT,
    EquipmentID INT,
    RentalStartDate DATE,
    RentalEndDate DATE,
    ConditionOnReturn VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);

-- ============================
-- EQUIPMENT SALE
-- ============================
CREATE TABLE EquipmentSale (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    EquipmentID INT,
    SaleDate DATE,
    SalePrice DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);

-- ============================
-- BILLING
-- ============================
CREATE TABLE Billing (
    BillingID INT PRIMARY KEY,
    CustomerID INT,
    EquipmentID INT,
    BillingPeriod VARCHAR(100),
    BillingMethod VARCHAR(100),
    AmountCharged DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);


INSERT INTO `Role`(RoleName)
    VALUES('Guide');
INSERT INTO `Role`(RoleName)
    VALUES('Marketing');
INSERT INTO `Role`(RoleName)
    VALUES('Inventory & Supplies');
INSERT INTO `Role`(RoleName)
    VALUES('Ecommerce');
INSERT INTO `Role`(RoleName)
    VALUES('Owners/Administration');

-- insert SupplierName and Contact Info into Supplier table
-- These are just some that I thought might sell helpful items for the adventures, feel free to change any of them
INSERT INTO Supplier(SupplierName, ContactInfo)
    VALUES('Dicks Sporting Goods', 'supplies@dicks.com');
INSERT INTO Supplier(SupplierName, ContactInfo)
    VALUES("Cabela's", 'vendor@cabelas.com');
INSERT INTO Supplier(SupplierName, ContactInfo)
    VALUES('Bass Pro Shop', 'supplies@bps.com');
INSERT INTO Supplier(SupplierName, ContactInfo)
    VALUES('Target', 'care@target.com');
INSERT INTO Supplier(SupplierName, ContactInfo)
    VALUES('United States Postal Service', 'support@USPS.com');
INSERT INTO Supplier(SupplierName, ContactInfo)
    VALUES('Shoe Carnival', 'bulk@ShoeCarnival.com');


-- insert Employee Names and Role into Employee Table
INSERT INTO Employee(FirstName, LastName, RoleID)
    VALUES('John', 'MacNell', (SELECT RoleID FROM `Role` WHERE RoleName = 'Guide'));
INSERT INTO Employee(FirstName, LastName, RoleID)
    VALUES('D.B.', 'Marland', (SELECT RoleID FROM `Role` WHERE RoleName = 'Guide'));
INSERT INTO Employee(FirstName, LastName, RoleID)
    VALUES('Anita', 'Gallegos', (Select RoleID From `Role` WHERE RoleName = 'Marketing'));
INSERT INTO Employee(FirstName, LastName, RoleID)
    VALUES('Dimitrios', 'Stravopolous', (SELECT RoleID From `Role` WHERE RoleName = 'Inventory & Supplies'));
INSERT INTO Employee(FirstName, LastName, RoleID)
    VALUES('Mei', 'Wong', (SELECT RoleID From `Role` WHERE RoleName = 'Ecommerce'));
INSERT INTO Employee(FirstName, LastName, RoleID)
    VALUES('Blythe', 'Timmerson', (SELECT RoleID FROM `Role` WHERE RoleName = 'Owners/Administration'));
INSERT INTO Employee(FirstName, LastName, RoleID)
    VALUES('Jim', 'Ford', (SELECT RoleID FROM `Role` WHERE RoleName = 'Owners/Administration'));
    
-- inserts RegionName and Destination into Location Table
-- These are just examples, feel free to change any and all
INSERT INTO Location(RegionName, Destination)
    VALUES('Africa', 'Cairo, Egypt');
INSERT INTO Location(RegionName, Destination)
    VALUES('Asia', 'Beijing, China');
INSERT INTO Location(RegionName, Destination)
    VALUES('Southern Europe', 'Venice, Italy');
INSERT INTO Location(RegionName, Destination)
    VALUES('Africa', 'Dodoma, Tanzania');
INSERT INTO Location(RegionName, Destination)
    VALUES('Asia', 'Tokyo, Japan');
INSERT INTO Location(RegionName, Destination)
    VALUES('Southern Europe', 'Madrid, Spain');

-- inserts the MaxParticipants into the Trip table
INSERT INTO Trip(LocationID, StartDate, EndDate, MaxParticipants)
    VALUES ((SELECT LocationID FROM Location WHERE RegionName = 'Africa' And Destination = 'Dodoma, Tanzania'), '2000-01-01', '2001-01-01', '10');
INSERT INTO Trip(LocationID, StartDate, EndDate,  MaxParticipants)
    VALUES ((SELECT LocationID FROM Location WHERE RegionName = 'Asia' And Destination = 'Tokyo, Japan'), '2000-01-01', '2001-01-01', '15');
INSERT INTO Trip(LocationID, StartDate, EndDate, MaxParticipants)
    VALUES ((SELECT LocationID FROM Location WHERE RegionName = 'Southern Europe' And Destination = 'Madrid, Spain'), '2000-01-01', '2001-01-01', '15');
