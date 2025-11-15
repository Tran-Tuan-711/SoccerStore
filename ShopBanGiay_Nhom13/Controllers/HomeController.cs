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
<<<<<<< Updated upstream
=======
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();

            ViewBag.spNB = csdl.SANPHAMNOIBAT
                                        .Where(spnb => spnb.NGAYBD <= DateTime.Now && spnb.NGAYKT >= DateTime.Now)
                                        .Select(spnb => spnb.SANPHAM)
                                        .Distinct()
                                        .ToList();

>>>>>>> Stashed changes
            return View();
        }
        public ActionResult SignIn()
        {
            return View();
        }
        public ActionResult SignUp()
        {
<<<<<<< Updated upstream
=======
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();
            ViewBag.spNB = csdl.SANPHAMNOIBAT
                                        .Where(spnb => spnb.NGAYBD <= DateTime.Now && spnb.NGAYKT >= DateTime.Now)
                                        .Select(spnb => spnb.SANPHAM)
                                        .Distinct()
                                        .ToList();

>>>>>>> Stashed changes
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
        [HttpPost]
        public ActionResult Delete(string id)
        {
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    TempData["Error"] = "Không xác định được sản phẩm cần xóa.";
                    return RedirectToAction("Dashboard");
                }

                var sp = csdl.SANPHAM.FirstOrDefault(x => x.MASP == id);
                if (sp != null)
                {
                    csdl.SANPHAM.Remove(sp);
                    csdl.SaveChanges();
                    TempData["Success"] = $"Đã xóa vĩnh viễn sản phẩm: {sp.TENSP}";
                }
                else
                {
                    TempData["Error"] = "Không tìm thấy sản phẩm cần xóa.";
                }
            }
            catch (Exception ex)
            {
                TempData["Error"] = "Lỗi khi xóa sản phẩm: " + ex.Message;
            }

<<<<<<< Updated upstream
            return RedirectToAction("Dashboard");
=======
            return RedirectToAction("Product");
        }

        public ActionResult DashBoard()
        {
               return View();
<<<<<<< Updated upstream
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
>>>>>>> Stashed changes
        }
        public ActionResult flashSale()
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();

            List<SANPHAM> dsSale = csdl.SANPHAM.Where(sp => sp.MAKM != null).ToList();
            return View(dsSale);
        }
    }
}
