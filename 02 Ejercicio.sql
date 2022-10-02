USE AdventureWorks2019
GO

IF OBJECT_ID ('Production.ProductosCategoria', 'V') IS NOT NULL  
DROP VIEW Production.ProductosCategoria;  
GO

CREATE VIEW Production.ProductosCategoria
AS
SELECT p.ProductID, p.Name AS Producto, s.Name AS Subcategoria, c.Name AS Categoria, m.Name AS Modelo
FROM Production.Product p, Production.ProductSubcategory s, Production.ProductCategory c, Production.ProductModel m
GO

SELECT *
FROM Production.ProductosCategoria
GO