using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using System.Data;
using ShopBanGiay_Nhom13.Models;

namespace ShopBanGiay_Nhom13.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        SoccerStoreEntities csdl = new SoccerStoreEntities();
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult SignIn()
        {
            return View();
        }
        public ActionResult SignUp()
        {
            return View();
        }
        public ActionResult DanhMucSanPham()
        {
            List<SANPHAM> dssp = csdl.SANPHAM.ToList();

            return View(dssp);
        }
        public ActionResult DanhMuc_GiayNhanTao()
        {
            return View();
        }

        public ActionResult PhuKien()
        {
            List<SANPHAM> dspk = csdl.SANPHAM.Where(x => x.MAL == x.LOAISP.MAL_CHA).ToList();
            return View(dspk);
        }
        public ActionResult Dashboard()
        {
            var kho = csdl.SANPHAM.Select(s => new Kho
            {
                MASP = s.MASP,
                TENSP = s.TENSP,
                HINHANH = s.HINHANH,
                SOLUONG = s.SOLUONG ?? 0,  
                GIA = s.GIA ?? 0,       
                MOTA = s.MOTA
            }).ToList();

            ViewBag.Categories = csdl.LOAISP
                .Select(l => l.TENL) 
                .Distinct()
                .ToList();

            return View(kho);
        }
    }
}
