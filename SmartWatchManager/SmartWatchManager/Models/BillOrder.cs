using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SmartWatchManager.Models
{
    public class BillOrder
    {
        //public List<Customer> lstCustomer { get; set; }
        //public List<Order> lstOrders { get; set;}
        //public List<OrderDetail> lstOrdersDetail { get; set; }
        public List<Order> lstOrders { get; set;}
        public int productID { get; set; }
        public int Quantity { get; set; }
        public Nullable<decimal> TotalPriceProduct { get; set; }
        
    }
}