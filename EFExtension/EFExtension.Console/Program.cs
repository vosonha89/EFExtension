﻿using EFExtension.Console.Entity;
using EFExtension.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace EFExtension.Console
{
    class Program
    {
        static void Main(string[] args)
        {
            using (EFExtensionContext ctx = new EFExtensionContext())
            {
                List<Order> orders = ctx.Orders.Take(10).ToList();
                foreach (Order order in orders)
                {
                    order.OrderItems = ctx.ExcuteStoreProcedure<OrderItem>("dbo.sp_GetOrderDetail", new SqlParameter { ParameterName = "@OrderId", Value = order.Id, Direction = System.Data.ParameterDirection.Input });
                    //order.OrderItems = ctx.ExcuteStoreProcedure<OrderItem>("dbo.sp_GetOrderDetail", new SimpleSqlParam { Name = "@OrderId", Value = order.Id });
                    order.Print();
                }
            }
            System.Console.ReadLine();
        }
    }
}
