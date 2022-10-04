USE AdventureWorks2019
GO

IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'HumanResources'
     AND SPECIFIC_NAME = N'usp_GetBirthDate' 
)
   DROP PROCEDURE HumanResources.usp_GetBirthDate
GO

CREATE PROCEDURE HumanResources.usp_GetBirthDate
	@DepartmentId INT = NULL
AS
	SELECT p.FirstName AS Nombre, p.LastName AS Apellido, e.Gender, d.Name AS Departamento, e.BirthDate
	FROM Person.Person p
	INNER JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory h ON e.BusinessEntityID = h.BusinessEntityID
	INNER JOIN HumanResources.Department d ON h.DepartmentID = d.DepartmentID
	WHERE @DepartmentId IS NULL OR @DepartmentId = d.DepartmentID AND DATEPART(MONTH, e.BirthDate) = DATEPART(MONTH, GETDATE())
	ORDER BY Apellido, Departamento ASC
GO

EXEC HumanResources.usp_GetBirthDate 

v