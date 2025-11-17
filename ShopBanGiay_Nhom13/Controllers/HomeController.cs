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
        public ActionResult SignUp()
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
        public ActionResult flashSale()
        {
            ViewBag.lsp = csdl.LOAISP.ToList();
            ViewBag.thuonghieu = csdl.THUONGHIEU.ToList();

            List<SANPHAM> dsSale = csdl.SANPHAM.Where(sp => sp.MAKM != null).ToList();
            return View(dsSale);
        }
        public List<CartItem> GetCart()
        {
            if (Session["cart"] == null)
                Session["cart"] = new List<CartItem>();

            return Session["cart"] as List<CartItem>;
        }
        public ActionResult AddToCart(string masp, int quantity = 1)
        {
            var sp = csdl.SANPHAM.FirstOrDefault(x => x.MASP == masp);
            if (sp == null) return RedirectToAction("Index");

            var cart = GetCart();
            var item = cart.FirstOrDefault(x => x.MaSP == masp);

            if (item == null)
            {
                cart.Add(new CartItem
                {
                    MaSP = sp.MASP,
                    TenSP = sp.TENSP,
                    Gia = (decimal)sp.GIA,
                    SoLuong = quantity
                });
            }
            else
            {
                item.SoLuong += quantity;
            }

            return RedirectToAction("XemGio");
        }

        public ActionResult XemGio()
        {
            var cart = GetCart();
            ViewBag.TongTien = cart.Sum(x => x.ThanhTien);
            return View(cart);
        }
        [HttpPost]
        public ActionResult CapNhat(string masp, int soluong)
        {
            var cart = GetCart();
            var item = cart.FirstOrDefault(x => x.MaSP == masp);

            if (item != null)
            {
                item.SoLuong = soluong;
            }

            return RedirectToAction("XemGio");
        }
        public ActionResult XoaSP(string masp)
        {
            var cart = GetCart();
            var item = cart.FirstOrDefault(x => x.MaSP == masp);

            if (item != null)
            {
                cart.Remove(item);
            }

            return RedirectToAction("XemGio");
        }
        public ActionResult ThanhToan()
        {
            var cart = GetCart();
            if (cart.Count == 0)
                return RedirectToAction("XemGio");

            ViewBag.TongTien = cart.Sum(x => x.ThanhTien);
            return View(cart);
        }
        [HttpPost]
        public ActionResult LuuHoaDon(string makh)
        {
            var giohang = csdl.GIOHANG.Where(g => g.MAKH == makh).ToList();
            if (giohang.Count == 0)
                return RedirectToAction("Index");

            // Tạo hóa đơn
            HOADON hd = new HOADON
            {
                MAHD = "HD" + DateTime.Now.ToString("yyyyMMddHHmmss"),
                MAKH = makh,
                NGAYTAO = DateTime.Now,
                NGAYHENGIAO = DateTime.Now.AddDays(3),
                NGAYTHANHTOAN = DateTime.Now,
                TONGTIEN = 0m
            };

            
            decimal tong = 0;
            foreach (var item in giohang)
            {
                var sp = csdl.SANPHAM.FirstOrDefault(s => s.MASP == item.MASP);
                if (sp != null)
                {
                    decimal gia = sp.GIA ?? 0m;              // giá sản phẩm
                    int soluong = item.SOLUONG ?? 0;        // số lượng, đảm bảo không null
                    tong += gia * soluong;
                }
            }
            hd.TONGTIEN = tong;

            // Lưu hóa đơn
            csdl.HOADON.Add(hd);
            try
            {
                csdl.SaveChanges();
            }
            catch (Exception ex)
            {
                string loi = ex.InnerException?.Message ?? ex.Message;
                throw new Exception("Lỗi khi lưu hóa đơn: " + loi);
            }

            // Thêm chi tiết hóa đơn
            foreach (var item in giohang)
            {
                CHITIETHOADON cthd = new CHITIETHOADON
                {
                    MAHD = hd.MAHD,
                    MASP = item.MASP,
                    SOLUONG = item.SOLUONG
                };
                csdl.CHITIETHOADON.Add(cthd);
            }

            try
            {
                csdl.SaveChanges();
            }
            catch (Exception ex)
            {
                string loi = ex.InnerException?.Message ?? ex.Message;
                throw new Exception("Lỗi khi lưu chi tiết hóa đơn: " + loi);
            }

            // Xóa giỏ hàng 
            foreach (var gh in giohang)
                csdl.GIOHANG.Remove(gh);

            try
            {
                csdl.SaveChanges();
            }
            catch (Exception ex)
            {
                string loi = ex.InnerException?.Message ?? ex.Message;
                throw new Exception("Lỗi khi xóa giỏ hàng: " + loi);
            }

            return RedirectToAction("Index");
        }


        public ActionResult ThanhCong(int mahd)
        {
            ViewBag.ma = mahd;
            return View();
        }


    }
}
