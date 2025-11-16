using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShopBanGiay_Nhom13.Models
{
    public class Kho
    {
        public string MASP { get; set; }
        public string TENSP { get; set; }
        public string HINHANH { get; set; }
        public int SOLUONG { get; set; }
        public decimal GIA { get; set; }
        public string MOTA { get; set; }
    }
}