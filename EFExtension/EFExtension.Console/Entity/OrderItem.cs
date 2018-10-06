using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFExtension.Console.Entity
{
    [Table("OrderItem")]
    public class OrderItem
    {
        public int Id { get; set; }
        public int OrderId { get; set; }
        public int ProductId { get; set; }
        public decimal UnitPrice { get; set; }
        public int Quantity { get; set; }

        public void Print()
        {
            System.Console.WriteLine("ProductId : " + ProductId + " - UnitPrice : " + UnitPrice + " - Quantity : " + Quantity);
        }
    }
}
