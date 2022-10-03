USE AdventureWorks2019
GO

IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'HumanResources'
     AND SPECIFIC_NAME = N'usp_GetGeneralEmployee' 
)
   DROP PROCEDURE HumanResources.usp_GetGeneralEmployee
GO

CREATE PROCEDURE HumanResources.usp_GetGeneralEmployee
	@DepartmentId INT = NULL
AS
	SELECT COUNT (d.DepartmentID) AS CantidadEmpleados 
	FROM Person.Person p
	INNER JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory h ON e.BusinessEntityID = h.BusinessEntityID
	INNER JOIN HumanResources.Department d ON h.DepartmentID = d.DepartmentID
	WHERE @DepartmentId IS NULL OR @DepartmentId = d.DepartmentID 
	
GO

EXEC HumanResources.usp_GetGeneralEmployee 