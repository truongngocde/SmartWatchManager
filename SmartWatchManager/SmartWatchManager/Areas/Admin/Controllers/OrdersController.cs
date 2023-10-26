using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using PagedList;
using SmartWatchManager.Models;

namespace SmartWatchManager.Areas.Admin.Controllers
{
    public class OrdersController : Controller
    {
        private SmartWatchManagerEntity db = new SmartWatchManagerEntity();

        // GET: Admin/Orders
        //public ActionResult Index()
        //{
        //    var orders = db.Orders.Include(o => o.Customer).Include(o => o.OrderStatu).Include(o => o.User);
        //    return View(orders.ToList());
        //}
        public ActionResult Index(int? page, string searchOrder)
        {
            // Tìm Kiếm            
            IQueryable<Order> orders = db.Orders.Include(b => b.User);

            if (!String.IsNullOrEmpty(searchOrder))
            {
                searchOrder = searchOrder.ToLower();
                orders = orders.Where(b => b.Customer.FullName.ToLower().Contains(searchOrder));
            }
            // Phân trang
            orders = orders.OrderBy(b => b.OrderID);
            if (page == null) { page = 1; }
            int pageSize = 5;
            int pageNumber = (page ?? 1);

            return View(orders.ToPagedList(pageNumber, pageSize));
        }
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.Orders.Find(id);
            Session["OrderID"] = order.OrderID;
            if (order == null)
            {
                return HttpNotFound();
            }

            // Lấy danh sách chi tiết đơn hàng từ bảng OrderDetails
            List<OrderDetail> orderDetails = db.OrderDetails.Where(od => od.OrderID == order.OrderID).ToList();
            order.OrderDetails = orderDetails;

            return View(order);
        }
        // GET: Admin/Orders/Create
        public ActionResult Create()
        {
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerID", "FullName");
            ViewBag.StatusID = new SelectList(db.OrderStatus, "StatusID", "Name");
            ViewBag.UserID = new SelectList(db.Users, "UserID", "FullName");
            return View();
        }

        // POST: Admin/Orders/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "OrderID,OrderName,CustomerID,UserID,OrderDate,ShipperDate,StatusID")] Order order)
        {
            if (ModelState.IsValid)
            {
                db.Orders.Add(order);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerID", "FullName", order.CustomerID);
            ViewBag.StatusID = new SelectList(db.OrderStatus, "StatusID", "Name", order.StatusID);
            ViewBag.UserID = new SelectList(db.Users, "UserID", "FullName", order.UserID);
            return View(order);
        }

        // GET: Admin/Orders/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.Orders.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerID", "FullName", order.CustomerID);
            ViewBag.StatusID = new SelectList(db.OrderStatus, "StatusID", "Name", order.StatusID);
            ViewBag.UserID = new SelectList(db.Users, "UserID", "FullName", order.UserID);
            return View(order);
        }

        // POST: Admin/Orders/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "OrderID,OrderName,CustomerID,UserID,OrderDate,ShipperDate,StatusID")] Order order)
        {
            if (ModelState.IsValid)
            {
                db.Entry(order).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CustomerID = new SelectList(db.Customers, "CustomerID", "FullName", order.CustomerID);
            ViewBag.StatusID = new SelectList(db.OrderStatus, "StatusID", "Name", order.StatusID);
            ViewBag.UserID = new SelectList(db.Users, "UserID", "FullName", order.UserID);
            return View(order);
        }

        // GET: Admin/Orders/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.Orders.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            return View(order);
        }

        // POST: Admin/Orders/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Order order = db.Orders.Find(id);
            db.Orders.Remove(order);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }



        public ActionResult Charts()
        {
            return View();
        }
    }
}
