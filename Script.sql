CREATE TABLE Country (
    CountryId INT PRIMARY KEY,
    CountryName NVARCHAR(127),
    CountryPhoneCode INT
);

CREATE TABLE [User] (
    UserId INT PRIMARY KEY,
    Email NVARCHAR(254) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(63) NOT NULL,
    FirstName NVARCHAR(127),
    LastName NVARCHAR(127),
    Telephone NVARCHAR(127),
    IsAdmin BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Address (
    AddressId INT PRIMARY KEY,
    UserId INT FOREIGN KEY REFERENCES [User](UserId),
    CountryId INT FOREIGN KEY REFERENCES Country(CountryId),
    FirstName NVARCHAR(127),
    LastName NVARCHAR(127),
    AddressLine1 NVARCHAR(254) NOT NULL,
    AddressLine2 NVARCHAR(254),
    PostalCode NVARCHAR(63),
    Telephone NVARCHAR(127),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ShipmentCompany (
    ShipmentCompanyId INT PRIMARY KEY,
    CompanyName NVARCHAR(127),
    CompanySite NVARCHAR(127),
    CompanyLogoUrl NVARCHAR(127)
);

CREATE TABLE Product (
    ProductId INT PRIMARY KEY,
    Name NVARCHAR(127) NOT NULL,
    Description NVARCHAR(127),
    UnitPrice FLOAT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ProductStock (
    ProductId INT PRIMARY KEY FOREIGN KEY REFERENCES Product(ProductId),
    Stock INT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ProductImage (
    ProductId INT FOREIGN KEY REFERENCES Product(ProductId),
    ImagePath NVARCHAR(254),
    PRIMARY KEY (ProductId, ImagePath)
);

CREATE TABLE CartItem (
    UserId INT FOREIGN KEY REFERENCES [User](UserId),
    ProductId INT FOREIGN KEY REFERENCES Product(ProductId),
    Quantity INT NOT NULL,
    PRIMARY KEY (UserId, ProductId)
);

CREATE TABLE [Order] (
    OrderId INT PRIMARY KEY,
    UserId INT FOREIGN KEY REFERENCES [User](UserId),
    AddressId INT FOREIGN KEY REFERENCES Address(AddressId),
    ShipmentCompanyId INT FOREIGN KEY REFERENCES ShipmentCompany(ShipmentCompanyId),
    ShipmentTrack NVARCHAR(127),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    ShippedAt DATETIME
);

CREATE TABLE OrderItem (
    OrderId INT FOREIGN KEY REFERENCES [Order](OrderId),
    ProductId INT FOREIGN KEY REFERENCES Product(ProductId),
    Quantity INT NOT NULL,
    UnitPrice FLOAT NOT NULL,
    PRIMARY KEY (OrderId, ProductId)
);