using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Castle.Core.Resource;
using SmartWatchManager.Models;

namespace SmartWatchManager.Controllers
{
    public class OrdersController : Controller
    {
        private SmartWatchManagerEntity db = new SmartWatchManagerEntity();

        // GET: Orders
        public ActionResult Index()
        {
            var customerID = (int?)Session["CustomerID"];
            var purchaseHistory = (from s in db.SmartWatches
                                   join od in db.OrderDetails on s.ProductID equals od.ProductID
                                   join o in db.Orders on od.OrderID equals o.OrderID
                                   where o.CustomerID == customerID
                                   select new BillOrder
                                   {
                                       OrderID = o.OrderID,
                                       OrderName = o.OrderName,
                                       ProductName = s.ProductName,
                                       Quantity = (int)od.Quantity,
                                       OrderDate = (DateTime)o.OrderDate,
                                       TotalPrice = (decimal)od.TotalPrice,
                                   }).ToList();

            return View(purchaseHistory);
        }

        public ActionResult Delete(int id)
        {
            // Tìm đơn hàng cần xóa dựa trên id
            var purchase = db.OrderDetails
                .Where(od => od.OrderID == id)
                .Select(od => new BillOrder
                {
                    OrderID = od.Order.OrderID,
                    OrderName = od.Order.OrderName,
                    ProductName = od.SmartWatch.ProductName,
                    Quantity = (int)od.Quantity,
                    OrderDate = (DateTime)od.Order.OrderDate,
                    TotalPrice = (decimal)od.TotalPrice,
                })
                .FirstOrDefault();

            if (purchase == null)
            {
                return HttpNotFound(); // Trả về 404 Not Found nếu không tìm thấy đơn hàng
            }

            return View(purchase);
        }


        //// GET: Orders/Delete/5
        //public ActionResult Delete(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    Order order = db.Orders.Find(id);
        //    if (order == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(order);
        //}

        //// POST: Orders/Delete/5
        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public ActionResult DeleteConfirmed(int id)
        //{
        //    Order order = db.Orders.Find(id);
        //    db.Orders.Remove(order);
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
        //}

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
