CREATE PROCEDURE dbo.sp_GetOrderDetail
  @OrderId INT,
  @CustomerId INT
AS
  SELECT * FROM OrderItem 
  WHERE OrderId = @OrderId
  SELECT * FROM Customer
  WHERE Id = @CustomerId 
GO