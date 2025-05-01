-- Question 1 Achieving 1NF (First Normal Form) 
-- It starts with a table that has non-atomic values and then transforms it into a table that adheres to 1NF.

CREATE DATABASE monthly_sales;
USE monthly_sales;

CREATE TABLE ProductDetail(
OrderID INT,
CustomerName VARCHAR(100),
Products VARCHAR(255)
);

INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Create a new table in 1NF
CREATE TABLE ProductDetail_1NF(
OrderID INT,
CustomerName VARCHAR(100),
Product VARCHAR(100)
);

-- split the multiple products into separate rows, while repeating the OrderID and CustomerName for each product
-- Every column must contain atomic values (only one value per cell).
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- Question 2 Achieving 2NF (Second Normal Form)

-- The column CustomerName depends only on OrderID, not on the full composite key (OrderID, Product), which violates 2NF
-- Create a separate Orders table to store customer names and order IDs
use monthly_sales;

 CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Create a OrderItems table to store the products and quantities per order
use monthly_sales;

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);