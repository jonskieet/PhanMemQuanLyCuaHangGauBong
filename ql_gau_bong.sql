use master
go
create database ql_gau_bong
go
use ql_gau_bong
go
create table BANGDICHVU
(
	MaDichVu int identity(1, 1) primary key,
	TenDichVu nvarchar(255),
	MoTa nvarchar(255)
)
go
create table CHUCVU
(
	MaChucVu int identity(1, 1) primary key,
	TenChucVu nvarchar(255)
)	
go
create table NHANVIEN
(
	MaNhanVien int identity(1, 1) primary key,
	HoTen nvarchar(255),
	NgaySinh date,
	DiaChi nvarchar(255),
	DienThoai nvarchar(255),
	DiaChiEmail nvarchar(255),
	TenDangNhap nvarchar(255),
	MatKhau nvarchar(255),
	MaChucVu int,
	foreign key(MaChucVu) references CHUCVU(MaChucVu)
)
go
create table MANHINH
(
	MaManHinh int identity(1, 1) primary key,
	TenManHinh nvarchar(255),
)
go
create table QUYENCHUCVU
(
	CoQuyen int,
	MaManHinh int,
	MaChucVu int,
	primary key(MaManHinh, MaChucVu),
	foreign key(MaManHinh) references MANHINH(MaManHinh),
	foreign key(MaChucVu) references CHUCVU(MaChucVu)
)
go
create table HANGHOA
(
	MaHangHoa int identity(1, 1) primary key,
	TenHangHoa nvarchar(255),
	QuyCach nvarchar(255),
	DonViTinh nvarchar(255),
	GiaMua float,
	GiaBan float,
	MoTa nvarchar(255),
	UrlHinhAnh nvarchar(255),
	SoLuongTon int,
	MauSac nvarchar(255),
	KichThuoc nvarchar(255)
)
go
create table KHACHHANG
(
	MaKhachHang int identity(1, 1) primary key,
	TenKhachHang nvarchar(255),
	SoDienThoai nvarchar(255),
	DiaChi nvarchar(255),
)
go
create table HOADONBANHANG
(
	MaHoaDon int identity(1, 1) primary key,
	NgayLap date,
	ThanhTien float,
	VAT float,
	TongTien float,
	MaNhanVien int,
	MaKhachHang int,
	foreign key(MaNhanVien) references NHANVIEN(MaNhanVien),
	foreign key(MaKhachHang) references KHACHHANG(MaKhachHang)
)
go
create table CHITIETHD
(
	SoLuong int,
	DonGia float,
	ThanhTien float,
	MaHoaDon int,
	MaHangHoa int,
	primary key(MaHoaDon, MaHangHoa),
	foreign key(MaHangHoa) references HANGHOA(MaHangHoa),
	foreign key(MaHoaDon) references HOADONBANHANG(MaHoaDon)
)
go
create table PHIEUDICHVU
(
	MaPhieu int identity(1, 1) primary key,
	NgayLap date,
	TrangThai nvarchar(255),
	TongTien float,
	MaKhachHang int,
	MaNhanVien int,
	foreign key(MaKhachHang) references KHACHHANG(MaKhachHang),
	foreign key(MaNhanVien) references NHANVIEN(MaNhanVien)
)
go
create table CHITIETDICHVU
(
	SoLuong int,
	DonGia float,
	ThanhTien float,
	MaDichVu int,
	MaPhieu int,
	MaHangHoa int,
	primary key(MaDichVu, MaPhieu, MaHangHoa),
	foreign key(MaDichVu) references BANGDICHVU(MaDichVu),
	foreign key(MaPhieu) references PHIEUDICHVU(MaPhieu),
	foreign key(MaHangHoa) references HANGHOA(MaHangHoa)
)
go
create table NHACUNGCAP
(
	MaNCC int identity(1, 1) primary key,
	TenNCC nvarchar(255),
	DiaChi nvarchar(255),
	SoDienThoai nvarchar(255),
	DiaChiEmail nvarchar(255),
)
go
create table DONDATHANG
(
	MaDDH int identity(1, 1) primary key,
	Ngaylap date,
	ThanhTien float,
	VAT float, 
	TongTien float,
	GhiChu nvarchar(255),
	MaNCC int, 
	MaNhanVien int,
	foreign key(MaNCC) references NHACUNGCAP(MaNCC),
	foreign key(MaNhanVien) references NHANVIEN(MaNhanVien)
)
go
create table CHITIETDDH
(
	SoLuong int,
	DonGia float,
	ThanhTien float,
	MaHangHoa int,
	MaDDH int,
	primary key(MaHangHoa, MaDDH),
	foreign key(MaHangHoa) references HANGHOA(MaHangHoa),
	foreign key(MaDDH) references DONDATHANG(MaDDH)
)
go
create table PHIEUNHAP
(
	MaPhieuNhap int identity(1, 1) primary key,
	NgayLap date, 
	LanNhap int,
	MaDDH int,
	foreign key(MaDDH) references DONDATHANG(MaDDH)
)
go
create table CHITIETPN
(
	SoLuong int,
	DonGia float,
	MaPhieuNhap int,
	MaHangHoa int,
	MaDDH int,
	primary key(MaPhieuNhap, MaHangHoa, MaDDH),
	foreign key(MaPhieuNhap) references PHIEUNHAP(MaPhieuNhap),
	foreign key(MaHangHoa, MaDDH) references CHITIETDDH(MaHangHoa, MaDDH),
)
go
create table PHIEUKHO
(
	MaPhieu int identity(1, 1) primary key,
	NgayLap date,
	GhiChu nvarchar(255),
	LoaiPhieu nvarchar(255),
	MaNhanVien int,
	foreign key(MaNhanVien) references NHANVIEN(MaNhanVien)
)
go
create table CHITIETPHIEUKHO
(
	SoLuongThucTe int,
	SoLuongThongKe int,
	ChenhLech int,
	SoLuongDieuChinh int,
	LyDoDieuChinh nvarchar(255),
	MaPhieu int,
	MaHangHoa int,
	foreign key(MaPhieu) references PHIEUKHO(MaPhieu),
	foreign key(MaHangHoa) references HANGHOA(MaHangHoa)
)
go
insert into CHUCVU (TenChucVu) values (N'Quản lý');
insert into CHUCVU (TenChucVu) values (N'Nhân viên bán hàng');
insert into CHUCVU (TenChucVu) values (N'Nhân viên kho');
go
insert into NHANVIEN (HoTen, NgaySinh, DiaChi, DienThoai, DiaChiEmail, TenDangNhap, MatKhau, MaChucVu) 
values (N'Nguyễn Văn A', '1990-05-15', N'123 Đường ABC, TP. HCM', '0123456789', 'nva@gmail.com', 'nva', 'password', 1);

insert into NHANVIEN (HoTen, NgaySinh, DiaChi, DienThoai, DiaChiEmail, TenDangNhap, MatKhau, MaChucVu) 
values (N'Trần Thị B', '1995-07-20', N'456 Đường XYZ, Hà Nội', '0987654321', 'ttb@gmail.com', 'ttb', 'password', 2);
go
insert into KHACHHANG (TenKhachHang, SoDienThoai, DiaChi) 
values (N'Phạm Minh C', '0901234567', N'789 Đường DEF, Đà Nẵng');

insert into KHACHHANG (TenKhachHang, SoDienThoai, DiaChi) 
values (N'Lê Thị D', '0934567890', N'321 Đường GHI, Cần Thơ');
go
insert into HANGHOA (TenHangHoa, QuyCach, DonViTinh, GiaMua, GiaBan, MoTa, UrlHinhAnh, SoLuongTon, MauSac, KichThuoc)
values (N'Giày Thể Thao Nam', N'Hộp 1 đôi', N'Đôi', 500000, 700000, N'Giày thể thao màu đen', 'image1.jpg', 100, N'Đen', '42');

insert into HANGHOA (TenHangHoa, QuyCach, DonViTinh, GiaMua, GiaBan, MoTa, UrlHinhAnh, SoLuongTon, MauSac, KichThuoc)
values (N'Giày Cao Gót Nữ', N'Hộp 1 đôi', N'Đôi', 400000, 600000, N'Giày cao gót màu đỏ', 'image2.jpg', 50, N'Đỏ', '38');
go
insert into BANGDICHVU (TenDichVu, MoTa)
values (N'Đánh bóng giày', N'Dịch vụ đánh bóng giày chuyên nghiệp');

insert into BANGDICHVU (TenDichVu, MoTa)
values (N'Thay dây giày', N'Dịch vụ thay dây giày mới');
go
insert into HOADONBANHANG (NgayLap, ThanhTien, VAT, TongTien, MaNhanVien, MaKhachHang)
values ('2024-10-14', 1500000, 10, 1650000, 1, 1);

insert into HOADONBANHANG (NgayLap, ThanhTien, VAT, TongTien, MaNhanVien, MaKhachHang)
values ('2024-10-14', 1200000, 10, 1320000, 2, 2);
go
insert into CHITIETHD (SoLuong, DonGia, ThanhTien, MaHoaDon, MaHangHoa)
values (1, 700000, 700000, 1, 1);

insert into CHITIETHD (SoLuong, DonGia, ThanhTien, MaHoaDon, MaHangHoa)
values (1, 600000, 600000, 2, 2);
go
insert into NHACUNGCAP (TenNCC, DiaChi, SoDienThoai, DiaChiEmail)
values (N'Công ty ABC', N'123 Đường 1, TP. HCM', '02812345678', 'abc@company.com');

insert into NHACUNGCAP (TenNCC, DiaChi, SoDienThoai, DiaChiEmail)
values (N'Công ty XYZ', N'456 Đường 2, Hà Nội', '02498765432', 'xyz@company.com');

insert into NHACUNGCAP (TenNCC, DiaChi, SoDienThoai, DiaChiEmail)
values (N'Công ty DEF', N'789 Đường 3, Đà Nẵng', '02361234567', 'def@company.com');
go
insert into DONDATHANG (Ngaylap, ThanhTien, VAT, TongTien, GhiChu, MaNCC, MaNhanVien)
values ('2024-10-13', 2000000, 10, 2200000, 'Đơn đặt hàng giày nam', 1, 1);
go
insert into CHITIETDDH (SoLuong, DonGia, ThanhTien, MaHangHoa, MaDDH)
values (10, 500000, 5000000, 1, 1);

insert into CHITIETDDH (SoLuong, DonGia, ThanhTien, MaHangHoa, MaDDH)
values (5, 400000, 2000000, 2, 1);
go
