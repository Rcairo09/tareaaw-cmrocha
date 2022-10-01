USE AdventureWorks2019
GO

IF OBJECT_ID ('Production.ProductosDescontinuados', 'V') IS NOT NULL  
DROP VIEW Production.ProductosDescontinuados;  
GO

CREATE VIEW Production.ProductosDescontinuados
AS
SELECT *
FROM Production.Product
WHERE DiscontinuedDate IS NOT NULL
GO

SELECT *
FROM Production.ProductosDescontinuados
GO
