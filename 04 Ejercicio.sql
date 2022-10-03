IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'HumanResources'
     AND SPECIFIC_NAME = N'usp_GetInfo' 
)
   DROP PROCEDURE HumanResources.usp_GetInfo
GO

CREATE PROCEDURE HumanResources.usp_GetInfo
	@DepartmentId INT = NULL
AS
	SELECT p.BusinessEntityID AS ID, p.FirstName AS Nombre, p.LastName AS Apellido, 
	e.BirthDate, e.Gender, h.DepartmentID AS IdDepartamento, d.Name AS Departamento
	FROM Person.Person p
	INNER JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory h ON e.BusinessEntityID = h.BusinessEntityID
	INNER JOIN HumanResources.Department d ON h.DepartmentID = d.DepartmentID
	WHERE @DepartmentId IS NULL OR @DepartmentId = d.DepartmentID
	ORDER BY d.DepartmentID ASC
GO

EXECUTE HumanResources.usp_GetInfo 15
GO