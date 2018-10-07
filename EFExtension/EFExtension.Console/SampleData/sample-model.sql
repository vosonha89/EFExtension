IF EXISTS
  (SELECT 1
   FROM sys.sysreferences r
   JOIN sys.sysobjects o ON (o.id = r.constid
                             AND o.type = 'F')
   WHERE r.fkeyid = object_id('"Order"')
     AND o.name = 'FK_ORDER_REFERENCE_CUSTOMER')
ALTER TABLE "Order"
DROP CONSTRAINT FK_ORDER_REFERENCE_CUSTOMER GO IF EXISTS
  (SELECT 1
   FROM sys.sysreferences r
   JOIN sys.sysobjects o ON (o.id = r.constid
                             AND o.type = 'F')
   WHERE r.fkeyid = object_id('OrderItem')
     AND o.name = 'FK_ORDERITE_REFERENCE_ORDER')
ALTER TABLE OrderItem
DROP CONSTRAINT FK_ORDERITE_REFERENCE_ORDER GO IF EXISTS
  (SELECT 1
   FROM sys.sysreferences r
   JOIN sys.sysobjects o ON (o.id = r.constid
                             AND o.type = 'F')
   WHERE r.fkeyid = object_id('OrderItem')
     AND o.name = 'FK_ORDERITE_REFERENCE_PRODUCT')
ALTER TABLE OrderItem
DROP CONSTRAINT FK_ORDERITE_REFERENCE_PRODUCT GO IF EXISTS
  (SELECT 1
   FROM sys.sysreferences r
   JOIN sys.sysobjects o ON (o.id = r.constid
                             AND o.type = 'F')
   WHERE r.fkeyid = object_id('Product')
     AND o.name = 'FK_PRODUCT_REFERENCE_SUPPLIER')
ALTER TABLE Product
DROP CONSTRAINT FK_PRODUCT_REFERENCE_SUPPLIER GO IF EXISTS
  (SELECT 1
   FROM sysindexes
   WHERE id = object_id('Customer')
     AND name = 'IndexCustomerName'
     AND indid > 0
     AND indid < 255)
DROP INDEX Customer.IndexCustomerName GO IF EXISTS
  (SELECT 1
   FROM sysobjects
   WHERE id = object_id('Customer')
     AND TYPE = 'U')
DROP TABLE Customer GO IF EXISTS
  (SELECT 1
   FROM sysindexes
   WHERE id = object_id('"Order"')
     AND name = 'IndexOrderOrderDate'
     AND indid > 0
     AND indid < 255)
DROP INDEX "Order".IndexOrderOrderDate GO IF EXISTS
  (SELECT 1
   FROM sysindexes
   WHERE id = object_id('"Order"')
     AND name = 'IndexOrderCustomerId'
     AND indid > 0
     AND indid < 255)
DROP INDEX "Order".IndexOrderCustomerId GO IF EXISTS
  (SELECT 1
   FROM sysobjects
   WHERE id = object_id('"Order"')
     AND TYPE = 'U')
DROP TABLE "Order" GO IF EXISTS
  (SELECT 1
   FROM sysindexes
   WHERE id = object_id('OrderItem')
     AND name = 'IndexOrderItemProductId'
     AND indid > 0
     AND indid < 255)
DROP INDEX OrderItem.IndexOrderItemProductId GO IF EXISTS
  (SELECT 1
   FROM sysindexes
   WHERE id = object_id('OrderItem')
     AND name = 'IndexOrderItemOrderId'
     AND indid > 0
     AND indid < 255)
DROP INDEX OrderItem.IndexOrderItemOrderId GO IF EXISTS
  (SELECT 1
   FROM sysobjects
   WHERE id = object_id('OrderItem')
     AND TYPE = 'U')
DROP TABLE OrderItem GO IF EXISTS
  (SELECT 1
   FROM sysindexes
   WHERE id = object_id('Product')
     AND name = 'IndexProductName'
     AND indid > 0
     AND indid < 255)
DROP INDEX Product.IndexProductName GO IF EXISTS
  (SELECT 1
   FROM sysindexes
   WHERE id = object_id('Product')
     AND name = 'IndexProductSupplierId'
     AND indid > 0
     AND indid < 255)
DROP INDEX Product.IndexProductSupplierId GO IF EXISTS
  (SELECT 1
   FROM sysobjects
   WHERE id = object_id('Product')
     AND TYPE = 'U')
DROP TABLE Product GO IF EXISTS
  (SELECT 1
   FROM sysindexes
   WHERE id = object_id('Supplier')
     AND name = 'IndexSupplierCountry'
     AND indid > 0
     AND indid < 255)
DROP INDEX Supplier.IndexSupplierCountry GO IF EXISTS
  (SELECT 1
   FROM sysindexes
   WHERE id = object_id('Supplier')
     AND name = 'IndexSupplierName'
     AND indid > 0
     AND indid < 255)
DROP INDEX Supplier.IndexSupplierName GO IF EXISTS
  (SELECT 1
   FROM sysobjects
   WHERE id = object_id('Supplier')
     AND TYPE = 'U')
DROP TABLE Supplier GO /*==============================================================*/ /* Table: Customer                                              */ /*==============================================================*/
CREATE TABLE Customer ( Id int IDENTITY,
                               FirstName nvarchar(40) NOT NULL,
                                                      LastName nvarchar(40) NOT NULL,
                                                                            City nvarchar(40) NULL,
                                                                                              Country nvarchar(40) NULL,
                                                                                                                   Phone nvarchar(20) NULL,
                                                                                                                                      CONSTRAINT PK_CUSTOMER PRIMARY KEY (Id)) GO /*==============================================================*/ /* Index: IndexCustomerName                                     */ /*==============================================================*/
CREATE INDEX IndexCustomerName ON Customer (LastName ASC, FirstName ASC) GO /*==============================================================*/ /* Table: "Order"                                               */ /*==============================================================*/
CREATE TABLE "Order" ( Id int IDENTITY,
                              OrderDate datetime NOT NULL DEFAULT getdate(),
                                                                  OrderNumber nvarchar(10) NULL,
                                                                                           CustomerId int NOT NULL,
                                                                                                          TotalAmount decimal(12, 2) NULL DEFAULT 0,
                                                                                                                                                  CONSTRAINT PK_ORDER PRIMARY KEY (Id)) GO /*==============================================================*/ /* Index: IndexOrderCustomerId                                  */ /*==============================================================*/
CREATE INDEX IndexOrderCustomerId ON "Order" (CustomerId ASC) GO /*==============================================================*/ /* Index: IndexOrderOrderDate                                   */ /*==============================================================*/
CREATE INDEX IndexOrderOrderDate ON "Order" (OrderDate ASC) GO /*==============================================================*/ /* Table: OrderItem                                             */ /*==============================================================*/
CREATE TABLE OrderItem ( Id int IDENTITY,
                                OrderId int NOT NULL,
                                            ProductId int NOT NULL,
                                                          UnitPrice decimal(12, 2) NOT NULL DEFAULT 0,
                                                                                                    Quantity int NOT NULL DEFAULT 1,
                                                                                                                                  CONSTRAINT PK_ORDERITEM PRIMARY KEY (Id)) GO /*==============================================================*/ /* Index: IndexOrderItemOrderId                                 */ /*==============================================================*/
CREATE INDEX IndexOrderItemOrderId ON OrderItem (OrderId ASC) GO /*==============================================================*/ /* Index: IndexOrderItemProductId                               */ /*==============================================================*/
CREATE INDEX IndexOrderItemProductId ON OrderItem (ProductId ASC) GO /*==============================================================*/ /* Table: Product                                               */ /*==============================================================*/
CREATE TABLE Product ( Id int IDENTITY,
                              ProductName nvarchar(50) NOT NULL,
                                                       SupplierId int NOT NULL,
                                                                      UnitPrice decimal(12, 2) NULL DEFAULT 0,
                                                                                                            PACKAGE nvarchar(30) NULL,
                                                                                                                                 IsDiscontinued bit NOT NULL DEFAULT 0,
                                                                                                                                                                     CONSTRAINT PK_PRODUCT PRIMARY KEY (Id)) GO /*==============================================================*/ /* Index: IndexProductSupplierId                                */ /*==============================================================*/
CREATE INDEX IndexProductSupplierId ON Product (SupplierId ASC) GO /*==============================================================*/ /* Index: IndexProductName                                      */ /*==============================================================*/
CREATE INDEX IndexProductName ON Product (ProductName ASC) GO /*==============================================================*/ /* Table: Supplier                                              */ /*==============================================================*/
CREATE TABLE Supplier ( Id int IDENTITY,
                               CompanyName nvarchar(40) NOT NULL,
                                                        ContactName nvarchar(50) NULL,
                                                                                 ContactTitle nvarchar(40) NULL,
                                                                                                           City nvarchar(40) NULL,
                                                                                                                             Country nvarchar(40) NULL,
                                                                                                                                                  Phone nvarchar(30) NULL,
                                                                                                                                                                     Fax nvarchar(30) NULL,
                                                                                                                                                                                      CONSTRAINT PK_SUPPLIER PRIMARY KEY (Id)) GO /*==============================================================*/ /* Index: IndexSupplierName                                     */ /*==============================================================*/
CREATE INDEX IndexSupplierName ON Supplier (CompanyName ASC) GO /*==============================================================*/ /* Index: IndexSupplierCountry                                  */ /*==============================================================*/
CREATE INDEX IndexSupplierCountry ON Supplier (Country ASC) GO
ALTER TABLE "Order" ADD CONSTRAINT FK_ORDER_REFERENCE_CUSTOMER
FOREIGN KEY (CustomerId) REFERENCES Customer (Id) GO
ALTER TABLE OrderItem ADD CONSTRAINT FK_ORDERITE_REFERENCE_ORDER
FOREIGN KEY (OrderId) REFERENCES "Order" (Id) GO
ALTER TABLE OrderItem ADD CONSTRAINT FK_ORDERITE_REFERENCE_PRODUCT
FOREIGN KEY (ProductId) REFERENCES Product (Id) GO
ALTER TABLE Product ADD CONSTRAINT FK_PRODUCT_REFERENCE_SUPPLIER
FOREIGN KEY (SupplierId) REFERENCES Supplier (Id) GO