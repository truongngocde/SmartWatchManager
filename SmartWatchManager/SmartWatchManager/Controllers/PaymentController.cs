using SmartWatchManager.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace SmartWatchManager.Controllers
{
    public class PaymentController : Controller
    {
        SmartWatchManagerEntity db = new SmartWatchManagerEntity();

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult ConfirmInfo(int? id)
        {
            if (Session["CustomerID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            else
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                Customer customer = db.Customers.Find(id);
                if (customer == null)
                {
                    return HttpNotFound();
                }
                return View(customer);
            }
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ConfirmInfo([Bind(Include = "CustomerID,FullName,Email,Password,ConfirmPassword,Phone,Address")] Customer customer)
        {
            if (ModelState.IsValid)
            {
                db.Entry(customer).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("CheckOut", "Payment");
            }
            return View(customer);
        }

        // GET: Payment
        public ActionResult CheckOut()
        {
            if (Session["CustomerID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }else if (Session["cart"] == null)
            {
                return RedirectToAction("Index", "ShoppingCart");
            }    
            else
            {
                var lstCart = (List<CartModel>)Session["cart"];
                Order order = new Order();
                order.OrderName = "Ma-" + DateTime.Now.ToString("yyyyMMddHHmmss");
                order.CustomerID = int.Parse(Session["CustomerID"].ToString());
                order.UserID = 5;
                order.OrderDate = DateTime.Now;
                order.ShipperDate = DateTime.Now.AddDays(3);
                order.StatusID = 1;
                db.Orders.Add(order);
                db.SaveChanges();

                int intOrderId = order.OrderID;
                List<OrderDetail> lstOrderDetails = new List<OrderDetail>();
                OrderDetail orderDetail;
                foreach (var item in lstCart)
                {
                    orderDetail = new OrderDetail();
                    orderDetail.OrderID = intOrderId;
                    orderDetail.ProductID = item.smartWatch.ProductID;
                    orderDetail.Quantity = item.Quantity;
                    orderDetail.TotalPrice = item.smartWatch.Price * item.Quantity;
                    lstOrderDetails.Add(orderDetail);
                }
                db.OrderDetails.AddRange(lstOrderDetails);
                db.SaveChanges();
            }
            return View();
        }
    }
}