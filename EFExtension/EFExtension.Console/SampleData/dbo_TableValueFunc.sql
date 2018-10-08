CREATE FUNCTION dbo.TableValueFunc(@ProductName NVARCHAR(50))
RETURNS TABLE
AS
RETURN (
    SELECT * FROM dbo.Product
    WHERE ProductName = @ProductName
);
GO