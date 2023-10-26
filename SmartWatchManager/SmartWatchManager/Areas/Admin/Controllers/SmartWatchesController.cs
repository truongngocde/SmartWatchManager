using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using PagedList;
using System.Web.Mvc;
using SmartWatchManager.Models;
using System.IO;

namespace SmartWatchManager.Areas.Admin.Controllers
{
    public class SmartWatchesController : Controller
    {
        private SmartWatchManagerEntity db = new SmartWatchManagerEntity();

        public ViewResult Index(string sortOrder, string currentFilter, string searchSmartWatch, int? page, string categoryID)
        {
            IQueryable<SmartWatch> products = db.SmartWatches.Include(b => b.Category);

            ViewBag.CurrentSort = sortOrder;
            ViewBag.PriceSortParm = String.IsNullOrEmpty(sortOrder) ? "Price_desc" : "";
            ViewBag.QuanlitySortParm = sortOrder == "Quanlity" ? "Quanlity_desc" : "Quanlity";

            if (searchSmartWatch != null)
            {
                page = 1;
            }
            else
            {
                searchSmartWatch = currentFilter;
            }

            ViewBag.CurrentFilter = searchSmartWatch;

            products = db.SmartWatches.Include(b => b.Category);
            if (!String.IsNullOrEmpty(searchSmartWatch))
            {
                products = products.Where(s => s.ProductName.Contains(searchSmartWatch)
                                       || s.CategoryID.Contains(searchSmartWatch));
            }
            if (!string.IsNullOrEmpty(categoryID))
            {
                products = products.Where(c => c.CategoryID == categoryID);
            }
            ViewBag.Manufacturers = new SelectList(db.Categories.Select(p => p.CategoryName).Distinct().OrderBy(m => m));

            switch (sortOrder)
            {
                case "Price_desc":
                    products = products.OrderByDescending(s => s.Price);
                    break;
                case "Price":
                    products = products.OrderBy(s => s.Price);
                    break;
                case "Quanlity":
                    products = products.OrderBy(s => s.Quantity);
                    break;
                case "Quanlity_desc":
                    products = products.OrderByDescending(s => s.Quantity);
                    break;
                default:   
                    products = products.OrderBy(s => s.ProductID);
                    break;
            }

            int pageSize = 5;
            int pageNumber = (page ?? 1);
            return View(products.ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/SmartWatches/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SmartWatch smartWatch = db.SmartWatches.Find(id);
            if (smartWatch == null)
            {
                return HttpNotFound();
            }
            return View(smartWatch);
        }

        // GET: Admin/SmartWatches/Create
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            return View();
        }

        // POST: Admin/SmartWatches/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Create([Bind(Include = "ProductID,ProductName,Image,Description,CategoryID,Price,Quantity")] SmartWatch smartWatch, HttpPostedFileBase Image)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    if (Image != null && Image.ContentLength > 0)
                    {
                        string fileName = Path.GetFileName(Image.FileName);
                        string path = Path.Combine(Server.MapPath("~/Content/Image"), fileName);
                        Image.SaveAs(path);
                        smartWatch.Image = fileName;
                    }
                    db.SmartWatches.Add(smartWatch);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch
                {
                    ViewBag.Message = "không thành công!!";
                }

            }

            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", smartWatch.CategoryID);
            return View(smartWatch);
        }

        // GET: Admin/SmartWatches/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SmartWatch smartWatch = db.SmartWatches.Find(id);
            if (smartWatch == null)
            {
                return HttpNotFound();
            }
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", smartWatch.CategoryID);
            return View(smartWatch);
        }

        // POST: Admin/SmartWatches/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Edit([Bind(Include = "ProductID,ProductName,Image,Description,CategoryID,Price,Quantity")] SmartWatch smartWatch, HttpPostedFileBase Image, FormCollection form)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    if (Image != null)
                    {
                        string _FileName = Path.GetFileName(Image.FileName);
                        string _path = Path.Combine(Server.MapPath("~/Content/Image"), _FileName);
                        Image.SaveAs(_path);
                        smartWatch.Image = _FileName;

                        _path = Path.Combine(Server.MapPath("~/Content/Image"), form["oldimage"]);
                        if (System.IO.File.Exists(_path))
                            System.IO.File.Delete(_path);

                    }
                    else
                        smartWatch.Image = form["oldimage"];
                    db.Entry(smartWatch).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch
                {
                    ViewBag.Message = "không thành công!!";
                }

                return RedirectToAction("Index");
            }

            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", smartWatch.CategoryID);
            return View(smartWatch);
        }

        // GET: Admin/SmartWatches/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SmartWatch smartWatch = db.SmartWatches.Find(id);
            if (smartWatch == null)
            {
                return HttpNotFound();
            }
            return View(smartWatch);
        }

        // POST: Admin/SmartWatches/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            SmartWatch smartWatch = db.SmartWatches.Find(id);
            db.SmartWatches.Remove(smartWatch);
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
    }
}
