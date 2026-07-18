CREATE DATABASE SOCCERSTORE

USE SOCCERSTORE
DELETE FROM CHITIETHOADON;
DELETE FROM HOADON;
DELETE FROM GIOHANG;
DELETE FROM SANPHAMNOIBAT;
DELETE FROM CHITIETKHUYENMAI;
DELETE FROM SANPHAM;
DELETE FROM KHACHHANG;
DELETE FROM KHUYENMAI;
DELETE FROM LOAISP;
DELETE FROM THUONGHIEU;

CREATE TABLE KHACHHANG
(
	MAKH VARCHAR(10) PRIMARY KEY,
	TENKH NVARCHAR(50),
	SODIENTHOAI VARCHAR(10),
	EMAIL NVARCHAR(50),
	PASSWORD_KH VARCHAR(50),
	ROLES NVARCHAR(10)
)
CREATE TABLE THUONGHIEU
(
	MATH VARCHAR(10) PRIMARY KEY,
	TENTH NVARCHAR(50)
)
CREATE TABLE LOAISP
(
	MAL VARCHAR(10) PRIMARY KEY,
	TENL NVARCHAR(100),
	MAL_CHA VARCHAR(10) NULL FOREIGN KEY REFERENCES	LOAISP(MAL)
)
CREATE TABLE KHUYENMAI
(
	MAKM VARCHAR(10) PRIMARY KEY,
    TENKM NVARCHAR(100),
    PHANTRAMGIAM INT,
    NGAYBD DATE,
    NGAYKT DATE
)
CREATE TABLE SANPHAM
(
	MASP VARCHAR(10) PRIMARY KEY,
	TENSP NVARCHAR(255),
	HINHANH VARCHAR(50),
	SOLUONG INT,
	GIA DECIMAL(12,0),
	MOTA NVARCHAR(255),
	MATH VARCHAR(10) FOREIGN KEY REFERENCES THUONGHIEU(MATH),
	MAL VARCHAR(10) FOREIGN KEY REFERENCES LOAISP(MAL),
	MAKM VARCHAR(10) FOREIGN KEY REFERENCES KHUYENMAI(MAKM)
)

CREATE TABLE CHITIETKHUYENMAI
(
    MAKM VARCHAR(10) FOREIGN KEY REFERENCES KHUYENMAI(MAKM),
    MASP VARCHAR(10) FOREIGN KEY REFERENCES SANPHAM(MASP),
    PRIMARY KEY (MAKM, MASP)
)

CREATE TABLE SANPHAMNOIBAT
(
	MASPNB VARCHAR(10) PRIMARY KEY,
	MASP VARCHAR(10) FOREIGN KEY REFERENCES SANPHAM(MASP),
	NGAYBD DATE,
	NGAYKT DATE
)
CREATE TABLE HOADON
(
	MAHD VARCHAR(10) PRIMARY KEY,
	NGAYTAO DATE,
	NGAYHENGIAO DATE,
	TONGTIEN DECIMAL(12,0),
	DIACHI NVARCHAR(100),
	GHICHU NVARCHAR(200),
	MAKH VARCHAR(10) FOREIGN KEY REFERENCES KHACHHANG(MAKH)

)
CREATE TABLE CHITIETHOADON
(
	MAHD VARCHAR(10) FOREIGN KEY REFERENCES HOADON(MAHD),
	MASP VARCHAR(10) FOREIGN KEY REFERENCES SANPHAM(MASP),
	SOLUONG INT,
	PRIMARY KEY(MAHD, MASP)
)
CREATE TABLE GIOHANG
(
	MAKH VARCHAR(10) FOREIGN KEY REFERENCES KHACHHANG(MAKH),
	MASP VARCHAR(10) FOREIGN KEY REFERENCES SANPHAM(MASP),
	SOLUONG INT,
	PRIMARY KEY(MAKH, MASP)
)
CREATE TABLE SIZE
(
	MASIZE VARCHAR(10) PRIMARY KEY,
	SOSIZE INT
)
CREATE TABLE SANPHAM_SIZE
(
	MASP VARCHAR(10) FOREIGN KEY REFERENCES SANPHAM(MASP),
	MASIZE VARCHAR(10) FOREIGN KEY REFERENCES SIZE(MASIZE),
	SOLUONG INT,
	PRIMARY KEY(MASP, MASIZE)
)


ALTER TABLE KHACHHANG
ADD CONSTRAINT DF_KHACHHANG_ROLES DEFAULT 'User' FOR ROLES

INSERT INTO KHACHHANG VALUES ('KH000', 'Admin', '0364109412', 'Admin@gmail.com', 'admin123', 'Admin'),
('KH001', 'Tuan', '0123456789', 'Tuan@gmail.com', '123', DEFAULT),
('KH002', 'Thuy', '0123456798', 'Thuy@gmail.com', '456', DEFAULT),
('KH003', 'Hai', '0123456987', 'Hai@gmail.com', '789', DEFAULT),
('KH004', 'Do', '0123456798', 'Do@gmail.com', '321', DEFAULT)

INSERT INTO THUONGHIEU(MATH, TENTH) VALUES 
('TH001', 'Nike'),
('TH002', 'Adidas'),
('TH003', 'Mizuno'),
('TH004', 'Puma'),
('TH005', 'Zocker'),
('TH006', 'Kamito'),
('TH007', 'Wika'),
('TH008', 'GKVN')

INSERT INTO LOAISP (MAL, TENL, MAL_CHA) VALUES 
('L001', N'Phụ kiện', NULL),
('L002', N'Găng tay thủ môn', 'L001'),
('L003', N'Quần áo đá bóng', 'L001'),
('L004', N'Quả bóng đá', 'L001'),
('L005', N'Balo & Túi xách', 'L001'),
('L006', N'Tất bóng đá', 'L001'),
('L007', N'Bọc ống đồng', 'L001'),
('L008', N'Giày bóng đá sân cỏ nhân tạo', NULL),
('L009', N'Giày bóng đá sân cỏ tự nhiên', NULL),
('L010', N'Giày bóng đá giá rẻ', NULL),
('L011', N'Giày bóng đá trẻ em', NULL),
('L012', N'Giày bóng đá nữ', NULL),
('L013', N'Phụ kiện khác', 'L001')

INSERT INTO KHUYENMAI (MAKM, TENKM, PHANTRAMGIAM, NGAYBD, NGAYKT) VALUES 
('KM001', 'SALE 20%', 20, '2025-12-12', '2025-12-20'),
('KM002', N'SALE 50% cuối năm', 50, '2025-12-15', '2025-12-30')

INSERT INTO SANPHAM (MASP, TENSP, HINHANH, SOLUONG, GIA, MOTA, MATH, MAL, MAKM) VALUES
-- 1. GĂNG TAY THỦ MÔN (SP001-SP016)
('SP001', N'Găng tay thủ môn GKVN KD - Đen', 'gkvn_kd_den.png', 90, 650000, N'Găng tay thủ môn GKVN KD, mút latex dày, độ bám tốt.', 'TH008', 'L002', 'KM001'),
('SP002', N'Găng tay thủ môn GKVN KD - Xanh Mint', 'gkvn_kd_xanhmint.png', 85, 650000, N'Găng tay thủ môn GKVN KD, màu xanh mint.', 'TH008', 'L002', NULL),
('SP003', N'Găng tay thủ môn GKVN KD - Vàng', 'gkvn_kd_vang.png', 80, 650000, N'Găng tay thủ môn GKVN KD, màu vàng.', 'TH008', 'L002', NULL),
('SP004', N'Găng tay thủ môn Nike Dynamic Fit Nữ', 'IF8194-830.png', 40, 2050000, N'Găng tay Nike Dynamic Fit dành cho nữ, cổ tay co giãn.', 'TH001', 'L002', NULL),
('SP005', N'Găng tay thủ môn GKVN Trở lại Tuxedo version', 'gkvn_tuxedo.png', 75, 390000, N'Găng tay thủ môn GKVN phiên bản Tuxedo, giá rẻ, độ bền cao.', 'TH008', 'L002', NULL),
('SP006', N'Găng tay thủ môn GKVN 4 mùa - Đồng Kiếm Em', 'gkvn_dongkiem.png', 85, 650000, N'Găng tay thủ môn GKVN, sử dụng 4 mùa, Đồng Kiếm.', 'TH008', 'L002', NULL),
('SP007', N'Găng tay thủ môn Nike Grip 3 - Đỏ/Đen', 'HQ0256-635.png', 35, 1850000, N'Găng tay Nike Grip 3, mút tiếp xúc bóng tối đa.', 'TH001', 'L002', NULL),
('SP008', N'Găng tay thủ môn GKVN Mệnh - Thủy Pro Contact', 'gkvn_thuy_procontact.png', 70, 950000, N'Găng tay GKVN Mệnh Thủy, Pro Contact, mút cao cấp.', 'TH008', 'L002', NULL),
('SP009', N'Găng tay thủ môn GKVN KD - Đen (Mới)', 'gkvn_kd_den_v2.png', 90, 650000, NULL, 'TH008', 'L002', NULL),
('SP010', N'Găng tay thủ môn GKVN KD - Xanh Mint (Mới)', 'gkvn_kd_xanhmint_v2.png', 85, 650000, NULL, 'TH008', 'L002', NULL),
('SP011', N'Găng tay thủ môn GKVN KD - Vàng (Mới)', 'gkvn_kd_vang_v2.png', 80, 650000, NULL, 'TH008', 'L002', NULL),
('SP012', N'Găng tay thủ môn Nike Dynamic Fit Nữ (Mới)', 'IF8194-830_v2.png', 40, 2050000, NULL, 'TH001', 'L002', NULL),
('SP013', N'Găng tay thủ môn GKVN Trở lại Tuxedo version (Mới)', 'gkvn_tuxedo_v2.png', 75, 390000, NULL, 'TH008', 'L002', NULL),
('SP014', N'Găng tay thủ môn GKVN 4 mùa - Đồng Kiếm Em (Mới)', 'gkvn_dongkiem_em_v2.png', 85, 650000, NULL, 'TH008', 'L002', NULL),
('SP015', N'Găng tay thủ môn Nike Grip 3 - Đỏ/Đen (Mới)', 'HQ0256-635_v2.png', 35, 1850000, NULL, 'TH001', 'L002', NULL),
('SP016', N'Găng tay thủ môn GKVN Mệnh - Thủy Pro Contact (Mới)', 'gkvn_thuy_procontact_v2.png', 70, 950000, NULL, 'TH008', 'L002', NULL),
-- 2. GIÀY SÂN CỎ TỰ NHIÊN (FG/AG) (SP017-SP024)
('SP017', N'Nike Mercurial Vapor 16 Elite FG - Lime Light', 'FQ1457-302.png', 20, 5800000, N'Phân khúc Elite, đế FG chuyên nghiệp, màu xanh neon tốc độ.', 'TH001', 'L009', 'KM002'),
('SP018', N'Adidas F50 League FG/MG - Coral Blaze', 'JI0004.png', 35, 2360000, N'Phiên bản League, đế FG/MG cho sân tự nhiên và cỏ nhân tạo cao cấp.', 'TH002', 'L009', NULL),
('SP019', N'Nike Phantom GX 6 Pro AG - Max Voltage', 'HO2317-800.png', 30, 4860000, N'Phân khúc Pro, đế AG cho cỏ nhân tạo chuyên nghiệp.', 'TH001', 'L009', NULL),
('SP020', N'Nike Tiempo Legend 10 Academy FG/MG - Vàng Chanh', 'HO2317-800_v2.png', 45, 2000000, N'Phân khúc Academy, đế FG/MG, da tổng hợp FlyTouch.', 'TH001', 'L009', NULL),
('SP021', N'Adidas Predator Elite FG - Jude Bellingham', 'JF3108.png', 15, 6000000, N'Phiên bản Elite, đế FG, thiết kế đặc biệt theo Jude Bellingham.', 'TH002', 'L009', NULL),
('SP022', N'Puma Future 8 Match FG/AG - Trắng Sứ', '108595-01.png', 40, 2100000, N'Phân khúc Match, đế FG/AG, màu trắng cơ bản.', 'TH004', 'L009', NULL),
('SP023', N'Nike Mercurial Vapor 16 Elite FG x Air Max 95 SE', 'HV9915-100.png', 10, 8600000, N'Phiên bản giới hạn, đế FG chuyên nghiệp, kết hợp công nghệ Air Max 95.', 'TH001', 'L009', NULL),
('SP024', N'Puma Ultra 6 Match FG/AG - Hồng/Xanh', '108846-01.png', 30, 2200000, N'Phân khúc Match, đế FG/AG, giày tốc độ.', 'TH004', 'L009', NULL),
-- 3. GIÀY SÂN CỎ NHÂN TẠO (TF) (SP025-SP032)
('SP025', N'Adidas F50 Pro TF Son Heung-min', 'JR5893.png', 30, 2920000, N'Phiên bản Pro TF của dòng F50, đế TF sân cỏ nhân tạo.', 'TH002', 'L008', NULL),
('SP026', N'Puma Future 8 Match TF - Đỏ Lửa', '108597-03.png', 40, 2400000, N'Phân khúc Match, cổ cao, đế TF.', 'TH004', 'L008', NULL),
('SP027', N'Puma Future 8 Pro Cage TF - Vàng Chuối Audacity', '108366-03.png', 35, 2500000, N'Phân khúc Pro Cage, màu vàng nổi bật, đế TF.', 'TH004', 'L008', NULL),
('SP028', N'Puma Future 7 Match TF - Grey Skies', '107937-03.png', 50, 1570000, N'Phân khúc Match TF, họa tiết Grey Skies.', 'TH004', 'L008', NULL),
('SP029', N'Puma Future 7 Match TF - Blue Amazing', '107937-01.png', 45, 1590000, N'Phân khúc Match TF, màu xanh dương rực rỡ.', 'TH004', 'L008', NULL),
('SP030', N'Puma Future 7 Pro Cage TF - Gray Skies', '107923-04.png', 40, 2150000, N'Phân khúc Pro Cage TF, cổ cao, họa tiết Gray Skies.', 'TH004', 'L008', NULL),
('SP031', N'Nike Tiempo Legend 10 Academy TF - Vàng Chanh', 'DV4351-180.png', 80, 1810000, N'Phân khúc Academy, da tổng hợp FlyTouch, đế TF.', 'TH001', 'L008', NULL),
('SP032', N'Nike Mercurial Vapor 16 Academy TF - Vàng Chanh', 'F08449-300.png', 75, 1990000, N'Phân khúc Academy, giày tốc độ, đế TF.', 'TH001', 'L008', NULL),
-- 4. GIÀY GIÁ RẺ/KAMITO/ZOCKER (SP033-SP042)
('SP033', N'Giày Mitre Vần Lang xanh dương (Giá Rẻ)', 'mitre_vanlang_xanhduong.png', 100, 385000, NULL, 'TH005', 'L010', NULL),
('SP034', N'Giày Mitre Vần Lang cam (Giá Rẻ)', 'mitre_vanlang_cam.png', 100, 385000, NULL, 'TH005', 'L010', NULL),
('SP035', N'Zocker Inspire Pro TF Gen 2 - Đỏ/Trắng', 'Zocker_inspire_redwhite.png', 65, 760000, NULL, 'TH005', 'L010', NULL),
('SP036', N'Zocker Inspire Pro TF Gen 2 - Hồng/Trắng', 'Zocker_inspire_pinkwhite.png', 60, 760000, NULL, 'TH005', 'L010', NULL),
('SP037', N'Zocker Inspire Pro TF Gen 2 - Cam', 'Zocker_inspire_orange.png', 55, 760000, NULL, 'TH005', 'L010', NULL),
('SP038', N'Zocker Inspire Pro TF Gen 2 - Tím', 'Zocker_inspire_purple.png', 50, 760000, NULL, 'TH005', 'L010', NULL),
('SP039', N'Kamito Artista Pro TF - Trắng/Đỏ Orange', 'KMTF240355.png', 65, 660000, NULL, 'TH006', 'L010', NULL),
('SP040', N'Kamito Artista Pro TF - Xanh Dương/Navy', 'KMTF240321.png', 60, 660000, NULL, 'TH006', 'L010', NULL),
('SP041', N'Kamito Velocidad Pro TF - xanh cổ vịt', 'KMTF240229.png', 80, 599000, NULL, 'TH006', 'L010', NULL),
('SP042', N'Kamito Velocidad Pro TF - màu đỏ', 'KMTF240210.png', 75, 599000, NULL, 'TH006', 'L010', NULL),
-- 5. GIÀY TRẺ EM (NIKE) (SP043-SP050)
('SP043', N'Nike Mercurial Vapor 16 Academy TF Jr - Xanh Hồng', 'FQ8284-301.png', 80, 1550000, NULL, 'TH001', 'L011', NULL),
('SP044', N'Nike Phantom 6 Academy TF Jr - Vàng Chanh', 'HQ2049-800.png', 75, 1850000, NULL, 'TH001', 'L011', NULL),
('SP045', N'Nike Mercurial Vapor 16 Academy TF Jr - Đỏ Than/Hồng', 'FQ8284-800.png', 85, 1850000, NULL, 'TH001', 'L011', NULL),
('SP046', N'Nike Mercurial Vapor 16 Academy TF Jr - Kylian Mbappe', 'FQ8285-400.png', 70, 2400000, NULL, 'TH001', 'L011', NULL),
('SP047', N'Nike Mercurial Vapor 16 Academy TF Jr - Nữ', 'IB1514-600.png', 65, 1800000, NULL, 'TH001', 'L011', NULL),
('SP048', N'Nike Tiempo Legend 10 Academy TF Jr - Vàng Chanh', 'DV4351-444.png', 90, 1810000, NULL, 'TH001', 'L011', NULL),
('SP049', N'Nike Phantom 6 Academy TF Jr - Xanh/Vàng', 'HQ2038-800.png', 80, 1960000, NULL, 'TH001', 'L011', NULL),
('SP050', N'Nike Mercurial Vapor 16 Academy TF Jr - Vàng/Đen', 'FQ8284-800_v3.png', 75, 2000000, NULL, 'TH001', 'L011', NULL),
-- 6. THƯƠNG HIỆU ADIDAS, MIZUNO (SP051-SP063)
('SP051', N'Adidas Copa Pure III League TF - Trắng/Hồng', 'JR2853.png', 60, 2100000, NULL, 'TH002', 'L008', NULL),
('SP052', N'Adidas F50 Pro TF Son Heung-min (TF)', 'JR5893.png', 30, 2920000, NULL, 'TH002', 'L008', NULL),
('SP053', N'Adidas F50 Pro TF Laceless - Coral Blaze', 'JR9329.png', 25, 3120000, NULL, 'TH002', 'L008', NULL),
('SP054', N'Adidas F50 League TF - Sparkfusion Coral Blaze', 'JI0015.png', 55, 1950000, NULL, 'TH002', 'L008', NULL),
('SP055', N'Adidas F50 Elite FG sân cỏ hò', 'JH7618.png', 20, 5800000, NULL, 'TH002', 'L009', 'KM002'),
('SP056', N'Adidas F50 League TF màu cam', 'JH7723.png', 50, 2050000, NULL, 'TH002', 'L008', NULL),
('SP057', N'Mizuno Morelia Neo Sala Beta β Japan TF - Đỏ', 'Q1GB254060.png', 30, 3999000, NULL, 'TH003', 'L008', NULL),
('SP058', N'Mizuno Morelia Neo Sala Beta β Japan TF - Trắng', 'Q1GB254009.png', 35, 3999000, NULL, 'TH003', 'L008', NULL),
('SP059', N'Mizuno Morelia Sala Pro TF - Trắng/Đen', 'Q1GB251309.png', 45, 2400000, NULL, 'TH003', 'L008', NULL),
('SP060', N'Mizuno Morelia Sala Elite TF - Trắng/Đen', 'Q1GB251209.png', 40, 3300000, NULL, 'TH003', 'L008', NULL),
('SP061', N'Mizuno Morelia Sala Japan TF - Đỏ Ruby', 'Q1GB250260.png', 25, 3999000, NULL, 'TH003', 'L008', NULL),
('SP062', N'Mizuno Morelia Sala Japan TF - Trắng/Đen', 'Q1GB250209.png', 30, 4300000, NULL, 'TH003', 'L008', NULL),
('SP063', N'Mizuno Alpha II Elite AS TF - Đỏ Ruby', 'P1GD256260.png', 35, 3500000, NULL, 'TH003', 'L008', NULL),
-- 7. THƯƠNG HIỆU PUMA (SP064-SP072)
('SP064', N'Bóng Puma Orbita Match Premier League Winter Ball', '084705-01.png', 80, 2500000, NULL, 'TH004', 'L004', NULL),
('SP065', N'Bóng Puma Orbita Pro Premier League Winter Ball', '084708-01.png', 60, 2500000, NULL, 'TH004', 'L004', NULL),
('SP066', N'Bóng Puma Orbita Ultimate Premier League Winter Ball', '084894-01.png', 40, 4000000, NULL, 'TH004', 'L004', NULL),
('SP067', N'Puma Future 8 Match TF - Đỏ Lửa (Mới)', '108597-03_v2.png', 55, 2400000, NULL, 'TH004', 'L008', NULL),
('SP068', N'Puma Future 8 Pro Cage TF - Vàng Chuối Audacity', '108366-03_v2.png', 35, 2500000, NULL, 'TH004', 'L008', NULL),
('SP069', N'Puma Future 7 Match TF - Grey Skies', '107937-03_v2.png', 70, 1570000, NULL, 'TH004', 'L008', NULL),
('SP070', N'Puma Future 7 Match TF - Blue Amazing', '107937-01_v2.png', 65, 1590000, NULL, 'TH004', 'L008', NULL),
('SP071', N'Puma Future 7 Pro Cage TF - Gray Skies', '107923-04_v2.png', 50, 2150000, NULL, 'TH004', 'L008', NULL),
('SP072', N'Kamito Velocidad Pro TF - Xanh cổ vịt', 'KMTF240229.png', 60, 599000, NULL, 'TH006', 'L010', NULL),	
--8. QUẦN ÁO BÓNG ĐÁ (SP073-SP080)
('SP073', N'Bộ quần áo CLB Liverpool đỏ 2025-26', 'liv_red_25_26_ta.png', 150, 230000, NULL, 'TH001', 'L003', NULL),
('SP074', N'Bộ quần áo CLB Barcelona xanh đỏ 2025-2025', 'bar_blue_red_25_ta.png', 140, 230000, NULL, 'TH001', 'L003', NULL),
('SP075', N'Bộ quần áo CLB Manchester United đỏ 2025', 'man_red_25.png', 130, 220000, NULL, 'TH001', 'L003', NULL),
('SP076', N'Bộ quần áo CLB Chelsea màu xanh 2025', 'che_blue_25.png', 150, 220000, NULL, 'TH001', 'L003', NULL),
('SP077', N'Bộ quần áo CLB Manchester City màu xanh 2025', 'man_city_blue_25.png', 145, 220000, NULL, 'TH001', 'L003', NULL),
('SP078', N'Bộ quần áo CLB Liverpool đỏ 2025 (Giày)', 'liv_red_25_giay.png', 120, 220000, NULL, 'TH001', 'L003', NULL),
('SP079', N'Bộ quần áo CLB Liverpool trẻ em 2025 màu đỏ', 'liv_red_25_kid.png', 180, 130000, NULL, 'TH001', 'L003', NULL),
('SP080', N'Bộ quần áo CLB Barcelona xanh đỏ 2025 (Giày)', 'bar_blue_red_25_giay.png', 135, 220000, NULL, 'TH001', 'L003', NULL),
--9. BALO & TÚI XÁCH (SP081-SP088)
('SP081', N'Túi đựng giày Adidas Tiro League', 'HS9767.png', 90, 450000, NULL, 'TH002', 'L005', NULL),
('SP082', N'Túi bóng đá Nike Academy Team (41L)', 'CU8097-010.png', 55, 1020000, NULL, 'TH001', 'L005', NULL),
('SP083', N'Túi bóng đá Nike Academy Team (60L)', 'CU8090-010.png', 45, 1230000, NULL, 'TH001', 'L005', NULL),
('SP084', N'Balo bóng đá Keepfly Daily', 'KL03-XA.png', 150, 100000, NULL, 'TH005', 'L005', NULL),
('SP085', N'Túi trống bóng đá Sigo màu xanh navy', 'Sigo_navy_01-XB.png', 120, 195000, NULL, 'TH005', 'L005', NULL),
('SP086', N'Túi trống bóng đá Sigo màu đỏ', 'Sigo_red_01-DO.png', 110, 195000, NULL, 'TH005', 'L005', NULL),
('SP087', N'Túi trống bóng đá Sigo màu xám', 'Sigo_gray_01-XA.png', 130, 195000, NULL, 'TH005', 'L005', NULL),
('SP088', N'Balo Nike Academy Team Backpack - Xanh Mint', 'DV0761-395.png', 70, 1450000, NULL, 'TH001', 'L005', NULL),
--10. TẤT BÓNG ĐÁ (SP089-SP96)
('SP089', N'Tất thể thao chống trơn Spinnix ProX - Trắng/Cam', 'Spinnix_ProX_trangcam.png', 200, 70000, NULL, 'TH005', 'L006', NULL),
('SP090', N'Combo 3 đôi tất chống trơn Spinnix ProX', 'Spinnix_ProX_combo.png', 150, 200000, NULL, 'TH005', 'L006', NULL),
('SP091', N'Tất thể thao chống trơn Spinnix ProX - Trắng/Xanh', 'Spinnix_ProX_trangxanh.png', 220, 70000, NULL, 'TH005', 'L006', NULL),
('SP092', N'Tất bóng đá chống trơn Nevor TCN06 - Đen/Trắng', 'Nevor_TCN06_dentrang.png', 180, 75000, NULL, 'TH005', 'L006', NULL),
('SP093', N'Tất chống trơn Wika - Vàng', 'Wika_WCT-VA_vang.png', 250, 40000, NULL, 'TH007', 'L006', NULL),
('SP094', N'Tất chống trơn Wika - Trắng', 'Wika_WCT-TR_trang.png', 300, 40000, NULL, 'TH007', 'L006', NULL),
('SP095', N'Tất chống trơn Wika - Xanh Blue', 'Wika_WCT-XB_xanhblue.png', 280, 40000, NULL, 'TH007', 'L006', NULL),
('SP096', N'Tất Nike Academy OTC - Trắng', 'SX4120-101.png', 100, 330000, NULL, 'TH001', 'L006', NULL),
--11. BỌC ỐNG ĐỒNG (SP97-SP104)
('SP97', N'Bọc ống đồng Nike Mercurial Lite - Xanh Chuối', 'DN3611-745.png', 90, 745000, NULL, 'TH001', 'L007', NULL),
('SP98', N'Lót ống đồng Adidas Tiro Club - Trắng/Đen', 'IP3895.png', 120, 300000, NULL, 'TH002', 'L007', NULL),
('SP99', N'Ốp bảo vệ ống đồng Adidas Tiro Club - Đen/Vàng', 'DN3611-745_v2.png', 110, 300000, NULL, 'TH002', 'L007', NULL),
('SP100', N'Lót ống đồng Nike Mercurial Lite - Trắng', 'DN3611-100.png', 130, 745000, NULL, 'TH001', 'L007', NULL),
('SP101', N'Ốp ống đồng Adidas Tiro League - Đen/Vàng', 'IP4000.png', 80, 850000, NULL, 'TH002', 'L007', NULL),
('SP102', N'Bọc ống đồng Nike Mercurial Lite - Xanh Xám', 'DN3611-395.png', 100, 750000, NULL, 'TH001', 'L007', NULL),
('SP103', N'Lót ống đồng Nike Mercurial Hardshell - Đỏ Cam', 'DN3614-850.png', 95, 485000, NULL, 'TH001', 'L007', NULL),
('SP104', N'Bọc ống đồng Nike Mercurial Lite - Đỏ Cam', 'DN3611-850.png', 105, 745000, NULL, 'TH001', 'L007', NULL),
--12. THƯƠNG HIỆU WIKA/KAMITO/MIZUNO (SP105-SP112)
('SP105', N'Wika TH10 Tuấn Hải - Màu Kem', 'wika_th10_kem.png', 70, 630000, NULL, 'TH007', 'L010', NULL),
('SP106', N'Wika TH10 Tuấn Hải - Xanh Ngọc', 'wika_th10_xanhngoc.png', 65, 630000, NULL, 'TH007', 'L010', NULL),
('SP107', N'Wika QH19 Z-Voi Quang Hải - Xanh Ngọc/Cam', 'wika_qh19_xanhngoccam.png', 60, 630000, NULL, 'TH007', 'L010', NULL),
('SP108', N'Kamito Velocidad Pro TF - Đỏ', 'KMTF240210_v2.png', 55, 599000, NULL, 'TH006', 'L010', NULL),
('SP109', N'Kamito Artista Pro TF màu trắng/ xanh green', 'KMTF240356.png', 50, 660000, NULL, 'TH006', 'L010', NULL),
('SP110', N'Mizuno Morelia Neo Sala Beta β Japan TF - Đỏ', 'Q1GB254060_v2.png', 30, 3999000, NULL, 'TH003', 'L008', NULL),
('SP111', N'Mizuno Morelia Neo Sala Beta β Japan TF - Trắng', 'Q1GB254009_v2.png', 35, 3999000, NULL, 'TH003', 'L008', NULL),
('SP112', N'Mizuno Morelia Sala Pro TF - Trắng/Đen', 'Q1GB251309_v2.png', 45, 2400000, 'TH003', NULL, 'L008', NULL),
--13. QUẢ BÓNG ĐÁ (SP113-SP116)
('SP113', N'Quả bóng đá Zocker Latico microfiber ZK5-L206 size 5', 'ZK5-L206.png', 80, 1190000, NULL, 'TH005', 'L004', NULL),
('SP114', N'Bóng Puma Orbita Pro Premier League Winter Ball 25/26 084708-01', '084708-01.png', 70, 2500000, NULL, 'TH005', 'L004', NULL),
('SP115', N'Bóng Puma Orbita Ultimate Premier League Winter Ball 25/26 084894-01', '084894-01.png', 50, 4000000, NULL, 'TH005', 'L004', NULL),
('SP116', N'Bóng Nike Academy Plus trắng/đen HV4392-100', 'HV4392-100.png', 80, 1350000, NULL, 'TH005', 'L004', NULL),

--14. GIÀY BÓNG ĐÁ NỮ(SP117-120)
('SP117', N'Adidas F50 League TF Jr Mid trắng đồng JI3550', 'JI3550.png', 80, 1890000, N'Adidas F50 phiên bản cổ cao Mid, mang phong cách khác lạ, là model giày cực hiếm.', 'TH002', 'L012', NULL),
('SP118', N'Adidas F50 League Jr trắng đồng Road to Glory – JI0002', 'JI0002.png', 90, 1700000, N'Giày F50 phiên bản nữ/ trẻ em, phom và size giày phù hợp, phù hợp cho sân cỏ nhân tạo, đế giày bám sân, upper cực mềm …', 'TH002', 'L012', NULL),
('SP119', N'Nike Phantom 6 Academy TF high Jr lá chanh HQ2049-800', 'HQ2049-800.png', 80, 1850000, N'Phantom 6 phiên bản Junior cực đẹp, đảm bảo hàng chính hãng fullbox, đổi size đổi mẫu không giới hạn, luôn kèm quà tặng.', 'TH001', 'L012', NULL),
('SP120', N'Nike Mercurial Vapor 16 Academy TF Jr Kylian Mbappe xoài chín FQ8285-801', 'FQ8285-801.png', 90, 2400000, N'Giày bóng đá Nike chính hãng, phiên bản đặc biệt phối màu dành riêng cho siêu sao Mbappe, model Jr- Junior dành cho trẻ em và cầu thủ nữ …', 'TH001', 'L012', NULL),
--13. PHỤ KIỆN KHÁC (SP121-SP128)
('SP121', N'Chai xịt nóng hỗ trợ Ligpro 200ml', 'Ligpro_hot_spray.png', 150, 145000, NULL, 'TH005', 'L013', NULL),
('SP122', N'Chai xịt lạnh giảm đau Ligpro Cool Spray 200ml', 'Ligpro_cool_spray.png', 140, 145000, NULL, 'TH005', 'L013', NULL),
('SP123', N'Bó gối thể thao Spinnix Novix - Xám', 'Spinnix_Novix_knee.png', 110, 210000, NULL, 'TH005', 'L013', NULL),
('SP124', N'Combo 2 bó gối thể thao Spinnix Virex - Đen', 'Spinnix_Virex_knee_black.png', 100, 180000, NULL, 'TH005', 'L013', NULL),
('SP125', N'Bó gối thể thao Spinnix Virex - Đen', 'Spinnix_Virex_knee_single.png', 130, 99000, NULL, 'TH005', 'L013', NULL),
('SP126', N'Băng quấn cổ chân Nevor BQCC04', 'Nevor_BQCC04_ankle.png', 160, 105000, NULL, 'TH005', 'L013', NULL),
('SP127', N'Bó đầu gối Nevor BDG12 - Đen/Đỏ', 'Nevor_BDG12_redblack.png', 105, 245000, NULL, 'TH005', 'L013', NULL),
('SP128', N'Bó gối trị liệu đầu gối Nevor BDG13 - Trắng', 'Nevor_BDG13_white.png', 95, 195000, NULL, 'TH005', 'L013', NULL)
INSERT INTO CHITIETKHUYENMAI (MAKM, MASP) VALUES 
('KM001', 'SP001'),
('KM002', 'SP017'),
('KM002', 'SP057');
INSERT INTO SANPHAMNOIBAT (MASPNB, MASP, NGAYBD, NGAYKT) VALUES
('NB001', 'SP009', '2025-11-01', '2025-12-31'), 
('NB002', 'SP013', '2025-11-01', '2025-11-30');
INSERT INTO HOADON (MAHD, NGAYTAO, NGAYHENGIAO, TONGTIEN, DIACHI, GHICHU, MAKH) VALUES
('HD001', '2025-11-05', '2025-11-08', 5500000, N'Hà Nội', N'Đường abc','KH001'),
('HD002', '2025-11-06', '2025-11-10', 8000000, 'TP.HCM' ,N'Phường XYZ','KH002');
-- INSERT CHITIETHOADON
INSERT INTO CHITIETHOADON (MAHD, MASP, SOLUONG) VALUES
('HD001', 'SP009', 1), ('HD001', 'SP004', 1),
('HD002', 'SP013', 1), ('HD002', 'SP007', 2);
-- INSERT GIOHANG
INSERT INTO GIOHANG (MAKH, MASP, SOLUONG) VALUES
('KH001', 'SP057', 1), ('KH002', 'SP071', 2);
-- INSERT SIZE 
INSERT INTO SIZE (MASIZE, SOSIZE) VALUES
('S32', 36),
('S33', 36),
('S34', 36),
('S35', 36),
('S36', 36),
('S37', 37),
('S38', 38),
('S39', 39),
('S40', 40),
('S41', 41),
('S42', 42),
('S43', 43),
('S44', 44);
-- INSERT SANPHAM_SIZE
-- =============================
-- GIÀY SÂN CỎ TỰ NHIÊN (SP017 – SP024)
-- (size 39–44)
-- =============================
INSERT INTO SANPHAM_SIZE(MASP, MASIZE, SOLUONG) VALUES
('SP017','S39',5), ('SP017','S40',6), ('SP017','S41',5), ('SP017','S42',3), ('SP017','S43',1), ('SP017','S44',1),
('SP018','S39',10),('SP018','S40',9),('SP018','S41',8),('SP018','S42',5),('SP018','S43',3), ('SP018','S44',1),
('SP019','S39',7), ('SP019','S40',8), ('SP019','S41',7), ('SP019','S42',5), ('SP019','S43',3), ('SP019','S44',1),
('SP020','S39',10),('SP020','S40',12),('SP020','S41',11),('SP020','S42',8), ('SP020','S43',4), ('SP020','S44',1),
('SP021','S39',4), ('SP021','S40',4), ('SP021','S41',3), ('SP021','S42',2), ('SP021','S43',2), ('SP021','S44',1),
('SP022','S39',10),('SP022','S40',11),('SP022','S41',9), ('SP022','S42',7), ('SP022','S43',3), ('SP022','S44',1),
('SP023','S39',3), ('SP023','S40',3), ('SP023','S41',2), ('SP023','S42',1), ('SP023','S43',1), ('SP023','S44',1),
('SP024','S39',8), ('SP024','S40',8), ('SP024','S41',7), ('SP024','S42',4), ('SP024','S43',3), ('SP024','S44',3);

-- =============================
-- GIÀY SÂN CỎ NHÂN TẠO (TF) SP025–SP032
-- size 38-42
-- =============================
INSERT INTO SANPHAM_SIZE(MASP, MASIZE, SOLUONG) VALUES
('SP025','S38',5),('SP025','S39',8),('SP025','S40',9),('SP025','S41',5),('SP025','S42',3),
('SP026','S38',6),('SP026','S39',10),('SP026','S40',11),('SP026','S41',8),('SP026','S42',5),
('SP027','S38',5),('SP027','S39',8),('SP027','S40',9),('SP027','S41',8),('SP027','S42',5),
('SP028','S38',10),('SP028','S39',14),('SP028','S40',15),('SP028','S41',8),('SP028','S42',3),
('SP029','S38',8),('SP029','S39',12),('SP029','S40',14),('SP029','S41',7),('SP029','S42',4),
('SP030','S38',6),('SP030','S39',10),('SP030','S40',13),('SP030','S41',7),('SP030','S42',4),
('SP031','S38',10),('SP031','S39',20),('SP031','S40',25),('SP031','S41',18),('SP031','S42',7),
('SP032','S38',10),('SP032','S39',18),('SP032','S40',22),('SP032','S41',15),('SP032','S42',10);

-- =============================
-- GIÀY GIÁ RẺ (SP033–SP042)
-- size 38–43
-- =============================
INSERT INTO SANPHAM_SIZE(MASP, MASIZE, SOLUONG) VALUES
('SP033','S38',15),('SP033','S39',20),('SP033','S40',25),('SP033','S41',20),('SP033','S42',15),('SP033','S43',10),
('SP034','S38',15),('SP034','S39',20),('SP034','S40',25),('SP034','S41',20),('SP034','S42',15),('SP034','S43',10),
('SP035','S38',10),('SP035','S39',15),('SP035','S40',20),('SP035','S41',10),('SP035','S42',7),('SP035','S43',3),
('SP036','S38',10),('SP036','S39',15),('SP036','S40',20),('SP036','S41',10),('SP036','S42',7),('SP036','S43',3),
('SP037','S38',10),('SP037','S39',15),('SP037','S40',20),('SP037','S41',10),('SP037','S42',7),('SP037','S43',3),
('SP038','S38',10),('SP038','S39',15),('SP038','S40',20),('SP038','S41',10),('SP038','S42',7),('SP038','S43',3),
('SP039','S38',12),('SP039','S39',18),('SP039','S40',20),('SP039','S41',10),('SP039','S42',3),('SP039','S43',2),
('SP040','S38',12),('SP040','S39',18),('SP040','S40',20),('SP040','S41',10),('SP040','S42',3),('SP040','S43',2),
('SP041','S38',15),('SP041','S39',20),('SP041','S40',25),('SP041','S41',15),('SP041','S42',3),('SP041','S43',2),
('SP042','S38',15),('SP042','S39',20),('SP042','S40',25),('SP042','S41',15),('SP042','S42',3),('SP042','S43',2);

-- =============================
-- GIÀY TRẺ EM (SP043–SP050)
-- size trẻ em 32–37
-- =============================
INSERT INTO SANPHAM_SIZE(MASP, MASIZE, SOLUONG) VALUES
('SP043','S32',10),('SP043','S33',15),('SP043','S34',20),('SP043','S35',15),('SP043','S36',10),('SP043','S37',5),
('SP044','S32',8),('SP044','S33',12),('SP044','S34',18),('SP044','S35',15),('SP044','S36',8),('SP044','S37',5),
('SP045','S32',12),('SP045','S33',15),('SP045','S34',20),('SP045','S35',18),('SP045','S36',10),('SP045','S37',5),
('SP046','S32',5),('SP046','S33',10),('SP046','S34',12),('SP046','S35',8), ('SP046','S36',5), ('SP046','S37',3),
('SP047','S32',6),('SP047','S33',10),('SP047','S34',14),('SP047','S35',12),('SP047','S36',8), ('SP047','S37',5),
('SP048','S32',10),('SP048','S33',18),('SP048','S34',25),('SP048','S35',20),('SP048','S36',10),('SP048','S37',7),
('SP049','S32',8),('SP049','S33',14),('SP049','S34',18),('SP049','S35',15),('SP049','S36',9), ('SP049','S37',5),
('SP050','S32',6),('SP050','S33',10),('SP050','S34',14),('SP050','S35',12),('SP050','S36',8), ('SP050','S37',5);

-- =============================
-- THƯƠNG HIỆU ADIDAS, MIZUNO (SP051–SP063) TF
-- size 38–43
-- =============================
INSERT INTO SANPHAM_SIZE(MASP, MASIZE, SOLUONG) VALUES
('SP051','S38',10),('SP051','S39',15),('SP051','S40',18),('SP051','S41',12),('SP051','S42',5),('SP051','S43',3),
('SP052','S38',5), ('SP052','S39',8), ('SP052','S40',10),('SP052','S41',5), ('SP052','S42',2), ('SP052','S43',0),
('SP053','S38',4), ('SP053','S39',6), ('SP053','S40',8), ('SP053','S41',5), ('SP053','S42',2), ('SP053','S43',0),
('SP054','S38',10),('SP054','S39',12),('SP054','S40',15),('SP054','S41',10),('SP054','S42',5),('SP054','S43',3),
('SP055','S39',3), ('SP055','S40',4), ('SP055','S41',3), ('SP055','S42',2), ('SP055','S43',1),
('SP056','S38',8), ('SP056','S39',12),('SP056','S40',15),('SP056','S41',10),('SP056','S42',4),('SP056','S43',1),
('SP057','S39',6), ('SP057','S40',8), ('SP057','S41',6), ('SP057','S42',3), ('SP057','S43',2),
('SP058','S39',7), ('SP058','S40',9), ('SP058','S41',7), ('SP058','S42',4), ('SP058','S43',2),
('SP059','S38',6), ('SP059','S39',9), ('SP059','S40',10),('SP059','S41',8), ('SP059','S42',4), ('SP059','S43',2),
('SP060','S39',5), ('SP060','S40',7), ('SP060','S41',6), ('SP060','S42',4), ('SP060','S43',2),
('SP061','S38',4), ('SP061','S39',6), ('SP061','S40',7), ('SP061','S41',5), ('SP061','S42',3), ('SP061','S43',1),
('SP062','S38',5), ('SP062','S39',8), ('SP062','S40',9), ('SP062','S41',6), ('SP062','S42',3), ('SP062','S43',2),
('SP063','S38',5), ('SP063','S39',7), ('SP063','S40',9), ('SP063','S41',6), ('SP063','S42',3), ('SP063','S43',2);

-- =============================
-- THƯƠNG HIỆU PUMA (SP067–SP072)
-- size 38–42
-- =============================
INSERT INTO SANPHAM_SIZE(MASP, MASIZE, SOLUONG) VALUES
('SP067','S38',8), ('SP067','S39',12), ('SP067','S40',15), ('SP067','S41',12), ('SP067','S42',6),
('SP068','S38',5), ('SP068','S39',8), ('SP068','S40',10), ('SP068','S41',7), ('SP068','S42',5),
('SP069','S38',12), ('SP069','S39',18), ('SP069','S40',22), ('SP069','S41',12), ('SP069','S42',6),
('SP070','S38',10), ('SP070','S39',16), ('SP070','S40',20), ('SP070','S41',12), ('SP070','S42',7),
('SP071','S38',8), ('SP071','S39',12), ('SP071','S40',15), ('SP071','S41',9), ('SP071','S42',6),
('SP072','S38',10), ('SP072','S39',15), ('SP072','S40',20), ('SP072','S41',10), ('SP072','S42',5);
-- =============================
-- GÌAY NỮ (SP117–SP120)
-- size 38–43
-- =============================
INSERT INTO SANPHAM_SIZE(MASP, MASIZE, SOLUONG) VALUES
('SP117', 'S34', 5), ('SP117', 'S35', 8), ('SP117', 'S36', 10), ('SP117', 'S37', 7), ('SP117', 'S38', 6),
('SP118', 'S34', 6),('SP118', 'S35', 10),('SP118', 'S36', 12),('SP118', 'S37', 8),('SP118', 'S38', 5),
('SP119', 'S34', 4),('SP119', 'S35', 7),('SP119', 'S36', 9),('SP119', 'S37', 6),('SP119', 'S38', 4),
('SP120', 'S34', 3),('SP120', 'S35', 5),('SP120', 'S36', 8),('SP120', 'S37', 10),('SP120', 'S38', 6),('SP120', 'S39', 2);


select * from SANPHAM
