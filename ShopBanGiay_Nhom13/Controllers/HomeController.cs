using ShopBanGiay_Nhom13.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Xml.Linq;

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
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();
            return View();
        }

        [HttpPost]
        public ActionResult SignIn(string txtName, string txtPass)
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();
            var kh = csdl.KHACHHANG.FirstOrDefault(x => x.EMAIL == txtName && x.PASSWORD_KH == txtPass);

            if (string.IsNullOrEmpty(txtName) ||
                string.IsNullOrEmpty(txtPass))
            {
                ViewBag.Error = "Vui lòng nhập đầy đủ thông tin!";
                return View();
            }

            if (kh == null || kh.PASSWORD_KH != txtPass)
            {
                ViewBag.Error = "Email hoặc mật khẩu không đúng!";
                return View();
            }

            Session["KHACHHANG"] = kh;
            return RedirectToAction("Index");
        }
        public ActionResult SignUp()
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();
            return View();
        }

        [HttpPost]
        public ActionResult SignUp(string txtEmail, string txtPhone, string txtPass, string txtRepass)
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();
            if (string.IsNullOrEmpty(txtEmail) ||
                string.IsNullOrEmpty(txtPhone) ||
                string.IsNullOrEmpty(txtPass) ||
                string.IsNullOrEmpty(txtRepass))
            {
                ViewBag.Error = "Vui lòng nhập đầy đủ thông tin!";
                return View(); 
            }
            if (txtPass != txtRepass)
            {
                ViewBag.Error = "Mật khẩu không trùng khớp!";
                return View();
            }

            // Tạo mã KH tự động
            string makh = "KH" + (csdl.KHACHHANG.Count() + 1).ToString("000");

            KHACHHANG kh = new KHACHHANG()
            {
                MAKH = makh,
                EMAIL = txtEmail,
                SODIENTHOAI = txtPhone,
                PASSWORD_KH = txtPass,
                TENKH = txtEmail,
                ROLES = "user"
            };

            csdl.KHACHHANG.Add(kh);
            csdl.SaveChanges();

            Session["KHACHHANG"] = kh;

            return RedirectToAction("Index");
        }
        public ActionResult Logout()
        {
            Session["KHACHHANG"] = null;
            return RedirectToAction("Index");
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
        public ActionResult ChiTietSanPham(string masp)
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();

            SANPHAM ctsp = csdl.SANPHAM.FirstOrDefault(x => x.MASP == masp);
            return View(ctsp);
        }
    }
}
