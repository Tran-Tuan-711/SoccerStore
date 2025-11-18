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

            ViewBag.spNB = csdl.SANPHAMNOIBAT
                                        .Where(spnb => spnb.NGAYBD <= DateTime.Now && spnb.NGAYKT >= DateTime.Now)
                                        .Select(spnb => spnb.SANPHAM)
                                        .Distinct()
                                        .ToList();

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
        public ActionResult LocSanPham(string MAL, string math)
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();

            List<SANPHAM> dssp = csdl.SANPHAM.Where(x => x.LOAISP.MAL == MAL).ToList();
            //Loc San Pham Theo Thuong Hieu
            if (math != null)
            {

                List<SANPHAM> dsth = csdl.SANPHAM.Where(x => x.THUONGHIEU.MATH == math).ToList();

                var listMaLoaiLienQuan = dsth.Select(sp => sp.MAL).Distinct().ToList();

                var dsLoaiCon = csdl.LOAISP
                                      .Where(lsp => listMaLoaiLienQuan.Contains(lsp.MAL))
                                      .OrderBy(lsp => lsp.MAL_CHA)
                                      .ToList();


                var model = new DanhMucViewModel
                {
                    DanhSachSP = dssp,
                    DanhSachLoaiSP = dsLoaiCon,
                    PhanLoai = "ThuongHieu",
                    MaLoaiHienTai = null

                };
                ViewBag.math = math;
                return View("DanhMucSanPham", model);
            }
            else
            {
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
                    MaLoaiHienTai = null

                };
                return View("DanhMucSanPham", model);
            }
        }

        public ActionResult ThuongHieu(string math)
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
            @ViewBag.math = math;
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
        public ActionResult flashSale()
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();

            List<SANPHAM> dsSale = csdl.SANPHAM.Where(sp => sp.MAKM != null).ToList();
            return View(dsSale);
        }
        //public ActionResult Dashboard()
        //{
        //    var kho = csdl.SANPHAM.Select(s => new Kho
        //    {
        //        MASP = s.MASP,
        //        TENSP = s.TENSP,
        //        HINHANH = s.HINHANH,
        //        SOLUONG = s.SOLUONG ?? 0,
        //        GIA = s.GIA ?? 0,
        //        MOTA = s.MOTA
        //    }).ToList();

        //    ViewBag.Categories = csdl.LOAISP
        //        .Select(l => l.TENL)
        //        .Distinct()
        //        .ToList();

        //    return View(kho);
        //}
        //[HttpPost]
        //public ActionResult Delete(string id)
        //{
        //    try
        //    {
        //        if (string.IsNullOrEmpty(id))
        //        {
        //            TempData["Error"] = "Không xác định được sản phẩm cần xóa.";
        //            return RedirectToAction("Dashboard");
        //        }

        //        var sp = csdl.SANPHAM.FirstOrDefault(x => x.MASP == id);
        //        if (sp != null)
        //        {
        //            csdl.SANPHAM.Remove(sp);
        //            csdl.SaveChanges();
        //            TempData["Success"] = $"Đã xóa vĩnh viễn sản phẩm: {sp.TENSP}";
        //        }
        //        else
        //        {
        //            TempData["Error"] = "Không tìm thấy sản phẩm cần xóa.";
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        TempData["Error"] = "Lỗi khi xóa sản phẩm: " + ex.Message;
        //    }
        //    return RedirectToAction("Dashboard");
        //}
        public ActionResult SearchProducts(string Search)
        {
            ViewBag.lsp = csdl.LOAISP.ToList(); ViewBag.thuonghieu = csdl.THUONGHIEU.ToList(); var model = new DanhMucViewModel
            {
                DanhSachLoaiSP = csdl.LOAISP.Where(x => x.MAL_CHA == null).ToList(), // Giả sử hiển thị loại giày chính
                PhanLoai = "TimKiem",
                MaLoaiHienTai = null
            };

            if (string.IsNullOrWhiteSpace(Search))
            {
                ViewBag.Error = "Vui lòng nhập từ khóa tìm kiếm!";
                model.DanhSachSP = new List<SANPHAM>();
                return View("DanhMucSanPham", model); // Trả về DanhMucViewModel
            }
            var result = csdl.SANPHAM.Where(sp => sp.TENSP.Contains(Search) || sp.LOAISP.TENL.Contains(Search) || sp.THUONGHIEU.TENTH.Contains(Search)).ToList();

            if (result.Count == 0)
            {
                ViewBag.Error = "Không tìm thấy sản phẩm nào phù hợp!";
            }

            model.DanhSachSP = result;
            return View("DanhMucSanPham", model);
        }
    }
}
