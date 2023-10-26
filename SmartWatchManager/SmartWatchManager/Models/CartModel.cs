using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SmartWatchManager.Models
{
    public class CartModel
    {
        public SmartWatch smartWatch { get; set; }
        public int Quantity { get; set; }
    }
}