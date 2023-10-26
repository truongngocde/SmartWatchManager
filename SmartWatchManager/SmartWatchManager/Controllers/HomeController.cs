using SmartWatchManager.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace SmartWatchManager.Controllers
{
    public class HomeController : Controller
    {
        SmartWatchManagerEntity smartWatchEntity = new SmartWatchManagerEntity();
        
        public ActionResult Index()          
        {
            var listSmartWatch = smartWatchEntity.SmartWatches.ToList();
            return View(listSmartWatch);
        }
               
        public ActionResult About()
        {
            return View();
        }
        

        public ActionResult Contact()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Contact([Bind(Include = "id,FullName,Email,FContent")] Contact contact)
        {
            if (Session["CustomerID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            else
            {
                if (ModelState.IsValid)
                {
                    smartWatchEntity.Contacts.Add(contact);
                    smartWatchEntity.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            return View(contact);
        }

        //GET: Register
        public ActionResult Register()
        {
            return View();
        }
        //POST: Register
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(Customer customer)
        {
            if (ModelState.IsValid)
            {
                // Check if email is valid
                if (!IsValidEmail(customer.Email))
                {
                    ModelState.AddModelError("Email", "Vui lòng nhập đúng email");
                    return View();
                }
                //Check if phone number is valid
                if (!Regex.Match(customer.Phone, @"^(84|0)(3[2-9]|5[2689]|7[0|6-9]|8[1-9]|9[0-4|6-9])[0-9]{7}$").Success)
                {
                    ModelState.AddModelError("Phone", "Số điện thoại không hợp lệ!");
                    return View();
                }
                var checkCustomer = smartWatchEntity.Customers.FirstOrDefault(s => s.Email == customer.Email);
                var checkUser = smartWatchEntity.Users.FirstOrDefault(s => s.Email == customer.Email);
                if (checkCustomer == null && checkUser == null)
                {
                    customer.Password = GetMD5(customer.Password);
                    customer.ConfirmPassword = GetMD5(customer.ConfirmPassword);
                    smartWatchEntity.Configuration.ValidateOnSaveEnabled = false;
                    smartWatchEntity.Customers.Add(customer);
                    smartWatchEntity.SaveChanges();
                    Session["FullName"] = customer.FullName;
                    Session["Email"] = customer.Email;
                    Session["CustomerID"] = customer.CustomerID;
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.errorEmailExists = "Email đã tồn tại !";
                    return View();
                }


            }
            return View();

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

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(string email, string password)
        {
            if (ModelState.IsValid)
            {
                var f_password = GetMD5(password);
                var customerData = smartWatchEntity.Customers.Where(s => s.Email.Equals(email) && s.Password.Equals(f_password)).ToList();
                if (customerData.Count() > 0)
                {
                    Session["FullName"] = customerData.FirstOrDefault().FullName;
                    Session["Email"] = customerData.FirstOrDefault().Email;
                    Session["CustomerID"] = customerData.FirstOrDefault().CustomerID;
                    Session["UserID"] = null; 
                    return RedirectToAction("Index");
                }
                else
                {
                    var userData = smartWatchEntity.Users.Where(s => s.Email.Equals(email) && s.Password.Equals(f_password)).ToList();
                    if (userData.Count() > 0)
                    {
                        Session["FullName"] = userData.FirstOrDefault().FullName;
                        Session["Email"] = userData.FirstOrDefault().Email;
                        Session["UserID"] = userData.FirstOrDefault().UserID;
                        Session["Image"] = userData.FirstOrDefault().Image;
                        Session["Role"] = userData.FirstOrDefault().Role.RoleName;
                        Session["CustomerID"] = null; 
                        return RedirectToAction("Index");
                    }
                }
            }
            ViewBag.error = "Thông tin đăng nhập không chính xác !";
            return View();
        }


        //Logout
        public ActionResult Logout()
        {
            Session.Clear();//remove session
            return RedirectToAction("Index");
        }
        //create a string MD5
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

        
    }
}
