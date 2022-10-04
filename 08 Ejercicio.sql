USE AdventureWorks2019
GO

IF OBJECT_ID (N'Sales.ufn_Ventas') IS NOT NULL
   DROP FUNCTION Sales.ufn_Ventas
GO

CREATE FUNCTION Sales.ufn_Ventas(@StartDate date = NULL, @EndDate date = NULL)
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
	IF(@StartDate IS NULL AND @EndDate IS NULL)
	SET @StartDate= DATEADD(DAY,1,EOMONTH(GETDATE(),-1));
	SET @EndDate = EOMONTH(GETDATE());

	INSERT INTO @TablaVentas (ProductID, ProductName, Cantidad, Total, IdOrden, FechaOrden)
	SELECT s.ProductID, p.Name, s.OrderQty, s.LineTotal, S.SalesOrderID, h.OrderDate
		FROM Sales.SalesOrderDetail s
		INNER JOIN Production.Product p ON S.ProductID = p.ProductID
		INNER JOIN Sales.SalesOrderHeader h ON s.SalesOrderID = h.SalesOrderID
		WHERE (h.OrderDate BETWEEN @StartDate AND @EndDate)	
		RETURN;
END		
GO

SELECT *
FROM Sales.ufn_Ventas('2011-06-01','2012-05-06')