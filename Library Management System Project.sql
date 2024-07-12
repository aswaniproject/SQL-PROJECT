-- CREATING A DATABASE NAMED 'library'
CREATE DATABASE library;
USE library;

-- CREATING TABLES Branch, Employee, Books, Customer, IssueStatus, ReturnStatus
-- TABLE 1 'Branch'
CREATE TABLE Branch (Branch_no INT PRIMARY KEY,Manager_Id INT,Branch_address VARCHAR(100),Contact_no VARCHAR(10));
-- TABLE 2 'Employee'
CREATE TABLE Employee (Emp_Id INT PRIMARY KEY,Emp_name VARCHAR(255),Position VARCHAR(255),Salary DECIMAL(10, 2),Branch_no INT,
FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no));
-- TABLE 3 'Books'
CREATE TABLE Books (ISBN VARCHAR(20) PRIMARY KEY,Book_title VARCHAR(255),Category VARCHAR(255),Rental_Price DECIMAL(10, 2),Status VARCHAR(3) CHECK (Status IN ('yes', 'no')),
Author VARCHAR(255),Publisher VARCHAR(255));
-- TABLE 4 'Customer'
CREATE TABLE Customer (Customer_Id INT PRIMARY KEY,Customer_name VARCHAR(255),Customer_address VARCHAR(255),Reg_date DATE);
-- TABLE 5 'IssueStatus'
CREATE TABLE IssueStatus (Issue_Id INT PRIMARY KEY,Issued_cust INT,Issued_book_name VARCHAR(255),Issue_date DATE,Isbn_book VARCHAR(20),
FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN));
-- TABLE 6 'ReturnStatus'
CREATE TABLE ReturnStatus (Return_Id INT PRIMARY KEY,Return_cust INT,Return_book_name VARCHAR(255),Return_date DATE,Isbn_book2 VARCHAR(20),
FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN));

-- INSERTING VALUES TO TABLES
-- TABLE Branch
INSERT  INTO Branch VALUES
(1,101,'Address1','598621799'),
(2,102,'Address2','9549632788'),
(3,103,'Address3','6842971588'),
(4,104,'Address4','9794862866'),
(5,105,'Address5','9896387829');

-- TABLE Employee
INSERT INTO Employee VALUES
( 101,'Name1','Manager',800000,1),
( 102,'Name2','Assistant Manager',60000,2),
( 103,'Name3','Reader',45000,3),
( 104,'Name4','Worker',15000,4),
( 105,'Name5','Worker',10000,5);

-- TABLE Books
INSERT INTO Books VALUES
('100','Crimes','Crime Thriller',15,'yes','auth1','pub1'),
('108','Novels','Comic',25,'no','auth2','pub2'),
('109','History','Classic',28,'yes','auth3','pub3'),
('110','War','Tragedy',16,'no','auth4','pub4'),
('117','Love in Deep','Romantic',30,'no','auth5','pub5');

-- TABLE Customer
INSERT INTO Customer VALUES
(11,'Customer1','Addr1','2010-10-12'),
(12,'Customer2','Addr2','2011-05-25'),
(13,'Customer3','Addr3','2021-11-12'),
(14,'Customer4','Addr4','2008-10-10'),
(15,'Customer5','Addr5','2010-12-12');

-- TABLE IssueStatus
INSERT INTO IssueStatus VALUES
(10,11,'Crimes','2023-01-12','100'),
(11,12,'Novels','2022-11-12','108'),
(12,13,'History','2024-02-12','109'),
(13,14,'War','2023-12-12','110'),
(14,15,'Love in Deep','2022-01-01','117');

-- TABLE ReturnStatus
INSERT INTO ReturnStatus VALUES
(50,11,'Crimes','2023-02-01','100'),
(51,12,'Novels','2022-12-01','108'),
(52,13,'History','2024-02-15','109'),
(53,14,'War','2023-12-30','110'),
(54,15,'Love in Deep','2022-01-12','117');

-- 1. Retrieve the book title, category, and rental price of all available books. 
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- 2. List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT B.Book_title, C.Customer_name
FROM Books B
JOIN IssueStatus I ON B.ISBN = I.Isbn_book
JOIN Customer C ON I.Issued_cust = C.Customer_Id;

-- 4. Display the total count of books in each category. 
SELECT Category, COUNT(*)
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT C.Customer_name
FROM Customer C
LEFT JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE C.Reg_date < '2022-01-01' AND I.Issue_Id IS NULL;

-- 7. Display the branch numbers and the total count of employees in each branch. 
SELECT Branch_no, COUNT(*) as Count
FROM Employee
GROUP BY Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT C.Customer_name
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE I.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- 9. Retrieve book_title from book table containing history. 
SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch_no, COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

-- 11. Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT E.Emp_name, B.Branch_address
FROM Employee E
JOIN Branch B ON E.Emp_Id = B.Manager_Id;

-- 12.  Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT DISTINCT C.Customer_name
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
JOIN Books B ON I.Isbn_book = B.ISBN
WHERE B.Rental_Price > 25;


    




