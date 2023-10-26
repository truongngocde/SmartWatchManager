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

namespace SmartWatchManager.Controllers
{
    public class ShoppingCartController : Controller
    {
        private SmartWatchManagerEntity db = new SmartWatchManagerEntity();

        // GET: ShoppingCart
        /*public ActionResult Index(int? page, string category, SmartWatch smart)
        {
            IQueryable<SmartWatch> smartWatches = db.SmartWatches.Include(s => s.Category);
            
            if (!String.IsNullOrEmpty(category))
            {
                category = category.ToLower();
                smartWatches = smartWatches.Where(b => b.Category.CategoryName.ToLower().Contains(category));
            }

            // Phân trang
            smartWatches = smartWatches.OrderBy(b => b.ProductID);
            if (page == null) { page = 1; }
            int pageSize = 9;
            int pageNumber = (page ?? 1);

            return View(smartWatches.ToPagedList(pageNumber, pageSize));
        }*/
        public ActionResult Index(int? page, string searchSmartWatch, string category)
        {
            // Tìm Kiếm            
            IQueryable<SmartWatch> smartWatches = db.SmartWatches.Include(b => b.Category);

            if (!String.IsNullOrEmpty(searchSmartWatch))
            {
                searchSmartWatch = searchSmartWatch.ToLower();
                smartWatches = smartWatches.Where(b => b.ProductName.ToLower().Contains(searchSmartWatch));
            }
            if (!String.IsNullOrEmpty(category))
            {
                category = category.ToLower();
                smartWatches = smartWatches.Where(b => b.Category.CategoryName.ToLower().Contains(category));
            }

            // Phân trang
            smartWatches = smartWatches.OrderBy(b => b.ProductID);
            if (page == null) { page = 1; }
            int pageSize = 9;
            int pageNumber = (page ?? 1);

            return View(smartWatches.ToPagedList(pageNumber, pageSize));
        }

        // GET: ShoppingCart/Details/5
        public ActionResult Details(int? id)
        {
            var tb_Products = db.SmartWatches.AsNoTracking().Take(8).ToList();
            ViewBag.Products = tb_Products;

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
        

        
    }
}
