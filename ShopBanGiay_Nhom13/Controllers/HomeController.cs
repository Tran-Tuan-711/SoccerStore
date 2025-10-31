using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShopBanGiay_Nhom13.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult DanhMucSanPham()
        {
            return View();
        }
        public ActionResult DanhMuc_GiayNhanTao()
        {
            return View();
        }
    }
}
