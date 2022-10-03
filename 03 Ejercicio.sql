USE AdventureWorks2019
GO

SELECT p.BusinessEntityID, p.FirstName, p.LastName, h.DepartmentID, d.Name
FROM Person.Person p
INNER JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory h ON e.BusinessEntityID = h.BusinessEntityID
INNER JOIN HumanResources.Department d ON h.DepartmentID = d.DepartmentID
