--Crea una vista que muestre un listado de productos (Production.Product) activos con sus respectivas categor�as (Production.ProductCategory), subcategor�as (Production.ProductSubcategory)
--y modelo (Production.ProductModel).Deben mostrarse todos los productos activos aunque no tengan modelo asociado.

USE AdventureWorks2019
GO

SELECT 
FROM Production.Product p
INNER JOIN Production.ProductModel m 
ON p.ProductID = m.ProductModelID 
