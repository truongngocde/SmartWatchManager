using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SmartWatchManager.Models
{
    public class BillOrder
    {

        //public List<Order> lstOrders { get; set; }
        //public List<OrderDetail> lstOrdersDetail { get; set; }
        //public List<SmartWatch> lstSmartWatch { get; set; }


        public string ProductName { get; set; }
        public int Quantity { get; set; }
        public decimal TotalPrice { get; set; }
        public int OrderID { get; set; }
        public string OrderName { get; set; }
        public DateTime OrderDate { get; set; }

    }
}