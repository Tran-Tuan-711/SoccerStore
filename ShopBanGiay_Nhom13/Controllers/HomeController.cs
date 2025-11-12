using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
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
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();

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
            return RedirectToAction("LocSanPham", new { phanLoai = "Giay", maLoai = (string)null });
        }
        public ActionResult LocSanPham(string MAL)
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();


            List<SANPHAM> dssp = csdl.SANPHAM.Where(x => x.LOAISP.MAL == MAL).ToList();

            var loaiSpHienTai = csdl.LOAISP.FirstOrDefault(x => x.MAL == MAL);


            string phanLoai;
            string maCha;

            if (loaiSpHienTai != null)
            {
                maCha = loaiSpHienTai.MAL_CHA;
                phanLoai = (maCha == null ? "Giay" : "PhuKien");
            }
            else
            {
                phanLoai = "Giay";
                maCha = null;   
            }
            var dsLoaiCon = new List<LOAISP>();

            if (maCha == null)
            {
                dsLoaiCon = csdl.LOAISP.Where(x => x.MAL_CHA == null).ToList();
            }
            else
            {
                dsLoaiCon = csdl.LOAISP.Where(x => x.MAL_CHA == maCha).ToList();
            }



            var model = new DanhMucViewModel
            {
                DanhSachSP = dssp,
                DanhSachLoaiSP = dsLoaiCon,
                PhanLoai = phanLoai,
                MaLoaiHienTai = MAL
            };
            return View("DanhMucSanPham", model);
        }
        public ActionResult LocThuongHieu(string math)
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();

            List<SANPHAM> dsth = csdl.SANPHAM.Where(x => x.THUONGHIEU.MATH == math).ToList();

            var listMaLoaiLienQuan = dsth.Select(sp => sp.MAL).Distinct().ToList();

            var dsLoaiCon = csdl.LOAISP
                                  .Where(lsp => listMaLoaiLienQuan.Contains(lsp.MAL))
                                  .OrderBy(lsp => lsp.MAL_CHA)
                                  .ToList();

            var model = new DanhMucViewModel
            {
                DanhSachSP = dsth,
                DanhSachLoaiSP = dsLoaiCon,
                PhanLoai = "ThuongHieu",
                MaLoaiHienTai = null
            };
            return View("DanhMucSanPham", model);
        }
        public ActionResult Giay()
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();

            var model = new DanhMucViewModel
            {
                DanhSachSP = csdl.SANPHAM.Where(x => x.LOAISP.MAL_CHA == null).ToList(),
                DanhSachLoaiSP = csdl.LOAISP.Where(x => x.MAL_CHA == null).ToList(),
                PhanLoai = "Giay"
            };
            return View("DanhMucSanPham", model);
        }
        public ActionResult PhuKien()
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();

            var model = new DanhMucViewModel
            {
                DanhSachSP = csdl.SANPHAM.Where(x => x.LOAISP.MAL_CHA == "L001").ToList(),
                DanhSachLoaiSP = csdl.LOAISP.Where(x => x.MAL_CHA == "L001").ToList(),
                PhanLoai = "PhuKien"
            };
            return View("DanhMucSanPham", model);
        }
    }
}
