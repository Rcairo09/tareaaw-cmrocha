USE AdventureWorks2019
GO

IF OBJECT_ID (N'Sales.ufn_VentasAnuales') IS NOT NULL
   DROP FUNCTION Sales.ufn_VentasAnuales
GO

CREATE FUNCTION Sales.ufn_VentasAnuales(@Year int = NULL)
RETURNS @TablaVentas TABLE(
		ProductID INT,
		ProductName NVARCHAR(50),
		Cantidad SMALLINT,
		Total NUMERIC(38,6),
		IdOrden INT,
		FechaOrden DATETIME
		)
AS
BEGIN 
	IF(@Year IS NULL)
	SET @Year= CONVERT(INT, DATEPART(YEAR, GETDATE()), 101);
	
	INSERT INTO @TablaVentas (ProductID, ProductName, Cantidad, Total, IdOrden, FechaOrden)
	SELECT s.ProductID, p.Name, s.OrderQty, s.LineTotal, S.SalesOrderID, h.OrderDate
		FROM Sales.SalesOrderDetail s
		INNER JOIN Production.Product p ON S.ProductID = p.ProductID
		INNER JOIN Sales.SalesOrderHeader h ON s.SalesOrderID = h.SalesOrderID
		WHERE (CONVERT(INT, DATEPART(YEAR, h.OrderDate),101) =  @Year)	
		RETURN;
END		
GO

SELECT *
FROM Sales.ufn_VentasAnuales(2014)