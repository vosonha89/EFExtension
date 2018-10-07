CREATE VIEW dbo.V_ProductWithSupplier 
AS SELECT 
  Product.Id, ProductName, SupplierId, UnitPrice, Package, IsDiscontinued,
  CompanyName, ContactName, ContactTitle, City, Country, Phone, Fax
  FROM Product
  JOIN Supplier
  ON SupplierId = Supplier.Id
GO