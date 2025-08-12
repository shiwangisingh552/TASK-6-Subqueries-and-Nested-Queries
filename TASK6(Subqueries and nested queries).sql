1.CREATE Customers table:

    CREATE TABLE Customers (
        CustomerID INTEGER PRIMARY KEY,
        Name TEXT,
        City TEXT,
    );


--Insert into Customers:

    INSERT INTO Customers (CustomerID, Name, City) VALUES(1, 'Alice', 'Delhi');
    INSERT INTO Customers (CustomerID, Name, City) VALUES(2, 'Bob', 'Mumbai');
    INSERT INTO Customers (CustomerID, Name, City) VALUES(3, 'Charlie', 'Chennai');
    INSERT INTO Customers (CustomerID, Name, City) VALUES(4, 'Diana', 'Kolkata');

2. Subquery in SELECT (Scalar Subquery):
    
--Show each customer's name along with the total number of customers.
        SELECT 
            Name,
            (SELECT COUNT(*) FROM Customers) AS TotalCustomers
        FROM Customers;

3. Subquery in WHERE using IN:
    
--Find customers who live in cities that contain the letter 'i'.
        SELECT Name 
        FROM Customers 
        WHERE City IN (
            SELECT City FROM Customers WHERE City LIKE '%i%'
        );

4. Subquery in WHERE using EXISTS:
    
--Return customers only if someone lives in 'Mumbai'.
        SELECT Name 
        FROM Customers c 
        WHERE EXISTS (
            SELECT 1 FROM Customers 
            WHERE City = 'Mumbai' AND c.City = City
        );

5. Subquery in WHERE using = (Scalar Subquery):
    
--Find the customer from the city that comes first alphabetically.
        SELECT Name 
        FROM Customers 
        WHERE City = (
            SELECT MIN(City) FROM Customers
        );

6. Subquery in FROM (Derived Table):
    
--Join customers with a derived table showing count of customers per city.
        SELECT c.Name, c.City, city_count.TotalInCity
        FROM Customers c
        JOIN (
            SELECT City, COUNT(*) AS TotalInCity
            FROM Customers
            GROUP BY City
        ) AS city_count
        ON c.City = city_count.City;

7. Correlated Subquery in WHERE:
    
--Find customers who live in cities with more than one customer.
        SELECT Name, City 
        FROM Customers c1
        WHERE (
            SELECT COUNT(*) 
            FROM Customers c2 
            WHERE c2.City = c1.City
        ) > 1;
