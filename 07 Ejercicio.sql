USE AdventureWorks2019
GO

IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'Sales'
     AND SPECIFIC_NAME = N'usp_Ventas' 
)
   DROP PROCEDURE Sales.usp_Ventas
GO

CREATE PROCEDURE Sales.usp_Ventas
	@StartDate date = NULL,
	@EndDate date = NULL
AS
	IF ((@StartDate IS NOT NULL) AND (@EndDate IS NOT NULL) AND (@EndDate > GETDATE()) OR (@EndDate < '2011-05-31'))
		BEGIN  
			PRINT N'Rango de fechas no v?lido para mostras datos'  
        RETURN  
		END  
	ELSE IF((@StartDate IS NOT NULL) AND (@EndDate IS NOT NULL))
		SELECT s.ProductID, p.Name, s.OrderQty, s.LineTotal, S.SalesOrderID, h.OrderDate
		FROM Sales.SalesOrderDetail s
		INNER JOIN Production.Product p ON S.ProductID = p.ProductID
		INNER JOIN Sales.SalesOrderHeader h ON s.SalesOrderID = h.SalesOrderID
		WHERE h.OrderDate BETWEEN @StartDate AND @EndDate 	
	ELSE IF((@StartDate IS NULL) AND (@EndDate IS NULL))
		SELECT s.ProductID, p.Name, s.OrderQty, s.LineTotal, S.SalesOrderID, h.OrderDate
		FROM Sales.SalesOrderDetail s
		INNER JOIN Production.Product p ON S.ProductID = p.ProductID
		INNER JOIN Sales.SalesOrderHeader h ON s.SalesOrderID = h.SalesOrderID
		WHERE @StartDate= DATEADD(DAY,1,EOMONTH(GETDATE(),-1)) AND  @EndDate = EOMONTH(GETDATE())
GO

EXEC Sales.usp_Ventas '2006-01-10', '2012-03-10'
GO