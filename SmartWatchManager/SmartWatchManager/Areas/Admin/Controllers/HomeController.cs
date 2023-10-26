using SmartWatchManager.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Threading.Tasks;

namespace SmartWatchManager.Areas.Admin.Controllers
{
    public class HomeController : Controller
    {
        SmartWatchManagerEntity db = new SmartWatchManagerEntity();
        // GET: Admin/Home
        public ActionResult Index()
        {
            var listCategory = db.Categories.ToList();
            return View(listCategory);
        }
        
        public ActionResult RegisterAdmin()
        {
            ViewBag.RoleID = new SelectList(db.Roles, "RoleID", "RoleName");
            return View();
        }
       
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult RegisterAdmin(User user, HttpPostedFileBase Image)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    // Check if email is valid
                    if (!IsValidEmail(user.Email))
                    {
                        ModelState.AddModelError("Email", "Vui lòng nhập đúng email");
                        return View();
                    }
                    if (Image != null && Image.ContentLength > 0)
                    {
                        string fileName = Path.GetFileName(Image.FileName);
                        string path = Path.Combine(Server.MapPath("~/Content/Admin/assets"), fileName);
                        Image.SaveAs(path);
                        user.Image = fileName;
                    }
                    
                    user.Password = GetMD5(user.Password);
                    var checkCustomer = db.Customers.FirstOrDefault(s => s.Email == user.Email);
                    var checkUser = db.Users.FirstOrDefault(s => s.Email == user.Email);
                    if (checkCustomer == null && checkUser == null)
                    {
                        db.Users.Add(user);
                        db.SaveChanges();
                        Session["Role"] = user.RoleID;
                        Session["FullName"] = user.FullName;
                        Session["Email"] = user.Email;
                        Session["UserID"] = user.UserID;
                        Session["Image"] = user.Image;
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        ViewBag.errorEmailExists = "Email đã tồn tại !";
                        return View();
                    }
                }
                catch (Exception ex)
                {
                    ViewBag.Message = "Error: " + ex.Message;
                }
            }

            ViewBag.RoleID = new SelectList(db.Roles, "RoleID", "RoleName", user.RoleID);
            return View(user);
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
        public static string GetMD5(string str)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] fromData = Encoding.UTF8.GetBytes(str);
            byte[] targetData = md5.ComputeHash(fromData);
            string byte2String = null;

            for (int i = 0; i < targetData.Length; i++)
            {
                byte2String += targetData[i].ToString("x2");

            }
            return byte2String;
        }
        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Index");
        }
        
    }
}