using SmartWatchManager.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SmartWatchManager.Controllers
{
    public class CartController : Controller
    {
        // GET: Cart
        SmartWatchManagerEntity db = new SmartWatchManagerEntity();
        private List<CartModel> lstCart; 

        // GET: Cart
        public ActionResult Index()
        {

            return View((List<CartModel>)Session["cart"]);
        }

        public ActionResult AddToCart(int id, int quantity)
        {
            if (Session["cart"] == null)
            {
                List<CartModel> cart = new List<CartModel>();
                cart.Add(new CartModel { smartWatch = db.SmartWatches.Find(id), Quantity = quantity });
                Session["cart"] = cart;
                Session["count"] = 1;
            }
            else
            {
                List<CartModel> cart = (List<CartModel>)Session["cart"];
                //kiểm tra sản phẩm có tồn tại trong giỏ hàng chưa???
                int index = isExist(id);
                if (index != -1)
                {
                    //nếu sp tồn tại trong giỏ hàng thì cộng thêm số lượng
                    cart[index].Quantity += quantity;
                }
                else
                {
                    //nếu không tồn tại thì thêm sản phẩm vào giỏ hàng
                    cart.Add(new CartModel { smartWatch = db.SmartWatches.Find(id), Quantity = quantity });
                    //Tính lại số sản phẩm trong giỏ hàng
                    Session["count"] = Convert.ToInt32(Session["count"]) + 1;
                }
                Session["cart"] = cart;
            }
            return Json(new { Message = "Thành công", JsonRequestBehavior.AllowGet });
        }

        private int isExist(int id)
        {
            List<CartModel> cart = (List<CartModel>)Session["cart"];
            for (int i = 0; i < cart.Count; i++)
                if (cart[i].smartWatch.ProductID.Equals(id))
                    return i;
            return -1;
        }

        //xóa sản phẩm khỏi giỏ hàng theo id
        public ActionResult Remove(int Id)
        {
            List<CartModel> li = (List<CartModel>)Session["cart"];
            li.RemoveAll(x => x.smartWatch.ProductID == Id);
            Session["cart"] = li;
            Session["count"] = Convert.ToInt32(Session["count"]) - 1;

            return Json(new { Message = "Thành công", Count = Session["count"] }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult RemoveAll()
        {
            List<CartModel> li = (List<CartModel>)Session["cart"];
            li.RemoveAll(x => true);
            Session["cart"] = li;
            Session["count"] = 0;

            return Json(new { Message = "Thành công", Count = Session["count"] }, JsonRequestBehavior.AllowGet);
        }


        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //[ValidateInput(false)]
        //public ActionResult AddOrder()
        //{
        //    if (Session["CustumerID"] == null)
        //    {
        //        return RedirectToAction("Login", "Home");

        //    }
        //    else
        //    {
        //        lstCart = Session["cart"] as List<CartModel>;
        //        Order orderObj = new Order()
        //        {
        //            OrderName = "Ma_" + DateTime.Now.ToString("yyyyMMddHHss"),
        //            CustomerID = int.Parse(Session["CustomerID"].ToString()),
        //            UserID = 5,
        //            OrderDate = DateTime.Now,
        //            ShipperDate = DateTime.Now.AddDays(3),
        //            StatusID = 1
        //        };
        //        db.Orders.Add(orderObj);
        //        db.SaveChanges();
        //        int OrderId = orderObj.OrderID;

        //        foreach (var item in lstCart)
        //        {
        //            OrderDetail detail = new OrderDetail();

        //            detail.OrderID = OrderId;
        //            detail.ProductID = item.smartWatch.ProductID;
        //            detail.Quantity = item.Quantity;
        //            detail.TotalPrice = (decimal?)Session["TotalAmount"];
        //            db.OrderDetails.Add(detail);
        //            db.SaveChanges();

        //        }


        //    }            
        //    return RedirectToAction("Index", "ShoppingCart");
        //}

    }
}
