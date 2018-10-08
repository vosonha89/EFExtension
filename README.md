# EFExtension
Extension for entity framework in .NET Framework. Helping developers are easy to use EF6.0 to call store procedure, view, function in SQL Server
* Nuget:
  > https://www.nuget.org/packages/EFExtension/
* Note : You can download sample app in this source or this link:              https://github.com/vosonha89/EFExtension/blob/master/dist/package_0.0.1/sample/EFExtension.Console.zip
# Usage
# 1. How to call Store Procedure
- Your store procedure returns only one data: 
  > **Context.ExecuteStoreProcedureOneDataResult**
  
- Your store procedure returns result set data:
  > **Context.ExecuteStoreProcedureOneResultSet**
  * Example: 
  ```C#
  order.OrderItems = ctx.ExecuteStoreProcedureOneResultSet<OrderItem>("dbo.sp_GetOrderDetail",
                        new SimpleSqlParam { Name = "@OrderId", Value = order.Id },
                        new SimpleSqlParam { Name = "@CustomerId", Value = 1 }
                        );
  ```
  * Or
  ```C#
  order.OrderItems = ctx.ExecuteStoreProcedureOneResultSet<OrderItem>("dbo.sp_GetOrderDetail",
                        new SqlParameter { ParameterName = "@OrderId", Value = order.Id, Direction = System.Data.ParameterDirection.Input },
                        new SqlParameter { ParameterName = "@CustomerId", Value = 1, Direction = System.Data.ParameterDirection.Input }
                        );
  ```
- Your store procedure returns multiple result set data:
  > **Contex.ExecuteStoreProcedureMultipleResultSet**
  * Example: 
  ```C#
  List<object> result3 = ctx.ExecuteStoreProcedureMultipleResultSet("dbo.sp_GetOrderDetail",
                        new SqlParameter { ParameterName = "@OrderId", Value = order.Id },
                        new SqlParameter { ParameterName = "@CustomerId", Value = 1 })
                        .With<OrderItem>()
                        .With<Customer>()
                        .Execute();
  ```
  * Or
  ```C#
  List<object> result2 = ctx.ExecuteStoreProcedureMultipleResultSet("dbo.sp_GetOrderDetail",
                        new SimpleSqlParam { Name = "@OrderId", Value = order.Id },
                        new SimpleSqlParam { Name = "@CustomerId", Value = 1 })
                        .With<OrderItem>()
                        .With<Customer>()
                        .Execute();
  ```                        
# 2. How to call Function
- Scalar:
  > **Context.ExecuteScalarFunction**
  * Example:
  ```C#
  var scalarResult = ctx.ExecuteScalarFunction<DateTime>("dbo.ScalarValueFunc", DateTime.Now);
  ```
- Table:
  > **Context.ExecuteTableFunction**
  * Example:
  ```C#
  var tableResult = ctx.ExecuteTableFunction<Product>("dbo.TableValueFunc", "Sir Rodney's Scones");
  ```
# 3. How to use View
  > **Creating View in your database -> Creating object mapping using attribute [Table(Viewname)] -> Adding like a DbSet to your context -> Using like a entity**
  * Example:
    - Creating object mapping using attribute [Table(Viewname)]
    ```C#
    [Table("V_ProductWithSupplier")]
    public class ProductWithSupplierView
    {
        public int Id { get; set; }
        public string ProductName { get; set; }
        public int SupplierId { get; set; }
        public decimal UnitPrice { get; set; }
        public string Package { get; set; }
        public bool IsDiscontinued { get; set; }
        public string CompanyName { get; set; }
        public string ContactName { get; set; }
        public string ContactTitle { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
    }
    ```
    - Adding like a DbSet to your context
    ```C#
     // Views
     public DbSet<ProductWithSupplierView> ProductWithSupplierView { get; set; }
    ```
    - Using like a entity
    ```C#
    List<ProductWithSupplierView> data = ctx.ProductWithSupplierView.ToList();
    ```
  # Thank you and help me to improve EFExtension by logging any issues you met when using this
