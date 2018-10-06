using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFExtension.Console.Entity
{
    [Table("Order")]
    public class Order
    {
        public int Id { get; set; }
        public DateTime OrderDate { get; set; }
        public string OrderNumber { get; set; }
        public int CustomerId { get; set; }
        public decimal TotalAmount { get; set; }

        [NotMapped]
        public List<OrderItem> OrderItems { get; set; }
        public Order()
        {
            OrderItems = new List<OrderItem>();
        }

        public void Print()
        {
            System.Console.WriteLine("OrderNumber : " + OrderNumber + " - OrderDate : " + OrderDate + " - TotalAmount : " + TotalAmount);
            System.Console.WriteLine("----- Order detail -----");
            foreach(OrderItem item in OrderItems)
            {
                item.Print();
            }
            System.Console.WriteLine();
        }
    }
}
