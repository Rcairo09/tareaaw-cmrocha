USE AdventureWorks2019
GO

IF OBJECT_ID ('Production.ProductosCategoria', 'V') IS NOT NULL  
DROP VIEW Production.ProductosCategoria;  
GO

CREATE VIEW Production.ProductosCategoria
AS
SELECT p.ProductID, p.Name AS Producto, p.ProductModelID, m.Name AS Modelo, s.ProductSubcategoryID, s.Name AS Subcategoria, 
c.ProductCategoryID, c.Name AS Categoria 
FROM Production.Product p
FULL JOIN Production.ProductModel m ON p.ProductModelID = m.ProductModelID
LEFT JOIN Production.ProductSubcategory s ON s.ProductSubcategoryID = p.ProductSubcategoryID
LEFT JOIN Production.ProductCategory c ON c.ProductCategoryID = s.ProductCategoryID
GO

SELECT *
FROM Production.ProductosCategoria
GO