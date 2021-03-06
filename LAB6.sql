CREATE DATABASE DONHANGQUANLI
--
CREATE TABLE KHACHHANG1
(
	MaKhachhang INT
	CONSTRAINT PK_KHACHHANG1_MaKhachHang PRIMARY KEY,
	TenKhachHang NVARCHAR(30),
	DiaChi NVARCHAR(20),
	Email VARCHAR (50),
	DienThoai	VARCHAR(15),
	Fax VARCHAR(15),
)
CREATE TABLE LOAIHANG1
(
	MaLoaiHang	CHAR(4)
	CONSTRAINT PK_LOAIHANG1_MaLoaiHang PRIMARY KEY(MaLoaiHang),
	TenLoaiHang NVARCHAR(30),
)
CREATE TABLE MATHANG1
(
	MaHang CHAR(4)
	CONSTRAINT PK_MATHANG1_MaHang PRIMARY KEY(MaHang),
	TenHang NVARCHAR(30),
	MaLoaiHang CHAR(4),
	SOLUONG INT,
	DonViTinh NVARCHAR(10),
	GiaHang	NUMERIC(10,2),
	MoTa NVARCHAR(30)
	CONSTRAINT FK_LOAIHANG1_MATHANG FOREIGN KEY (MaLoaiHang) REFERENCES LOAIHANG1(MaLoaiHang)
    )
	CREATE TABLE DONDATHANG1
	(
	SoHoaDon INT
	CONSTRAINT PK_DONDATHANG1_SoHoaDon PRIMARY KEY,
	MaKhachHang INT,
	NgayDatHang	DATETIME,
	NgayGiaohang	DATETIME,
	NgayChuyenHang	DATETIME,
	NoiGiaohang NVARCHAR(80),
	CONSTRAINT FK_DONDATHANG1_MaKhachHang FOREIGN KEY(MaKhachHang) REFERENCES KHACHHANG1(MaKhachHang)
	)
	CREATE TABLE CHITIETDATHANG1
	(
	SoHoaDon	INT ,
	MaHang	CHAR(4),
	GiaBan	NUMERIC(10,2),
	SoLuong	INT,
	MucGiamGia	NUMERIC(10,2),
	CONSTRAINT PK_CHITIETDATHANG1_SoHoaDon_MaHang PRIMARY KEY(SoHoaDon),
	CONSTRAINT FK_CHITIETDATHANG1_SoHoaDon FOREIGN KEY (SoHoaDon)
	REFERENCES DONDATHANG1(SoHoaDon),
	CONSTRAINT FK_CHITIETDATHANG1_MaHang FOREIGN KEY(MaHang) REFERENCES MATHANG1(MaHang)
	)
	--
	--Bảng Loại Hàng dùng để phân loại các mặt hàng hiện có
	INSERT INTO LOAIHANG1 VALUES('MT01',N'Máy Tính')
	INSERT INTO LOAIHANG1 VALUES('DT01',N'Điện Thoại')
	INSERT INTO LOAIHANG1 VALUES('MI01',N'Máy In')
	--
	select* from KHACHHANG1
	INSERT INTO KHACHHANG1 VALUES('123',N'Nguyễn Văn An',N' 111 Nguyễn Trãi','anlenuyen@gmail.com','987654321','02-464238')
	--
	--Bảng Mặt Hàng
	INSERT INTO MATHANG1 VALUES('MH01',N'Máy Tính T450','MT01','1',N'Chiếc',1000,N'Máy nhập mơi')
	INSERT INTO MATHANG1 VALUES('MH02',N'Điện Thoại Nokia 5670','DT01','2',N'Chiếc',200,N'Điện thoại đang hot')
	INSERT INTO MATHANG1 VALUES('MH03',N'Máy in Samsung 450','MI01','1',N'Chiếc',100,N'Máy in đang ế')
	--
	--Bảng đơn đặt hàng
	INSERT INTO DONDATHANG1 VALUES(001,'123','2018-5-6','2018-6-7','2018-7-8',N'Hà Nội')
	INSERT INTO DONDATHANG1 VALUES(002,'123','2018-4-5','2018-5-6','2018-6-7',N'Hà Nội')
	INSERT INTO DONDATHANG1 VALUES(003,'123','2017-5-6','2017-6-7','2017-7-8',N'Hà Nội')
	--
	INSERT INTO CHITIETDATHANG1 VALUES(001,'MH01',1000,'1',0)
	INSERT INTO CHITIETDATHANG1 VALUES(002,'MH02',200,'2',0)
	INSERT INTO CHITIETDATHANG1 VALUES(003,'MH03',100,'1',0)
	INSERT INTO CHITIETDATHANG1 VALUES(004,'MH02',100,'2',0)
	--
	--4
	--a
	SELECT * FROM KHACHHANG1
	--b
	SELECT * FROM MATHANG1
	--C
	SELECT * FROM DONDATHANG1
	SELECT * FROM CHITIETDATHANG1
	--5
	--a
	SELECT * FROM KHACHHANG1 ORDER BY TenKhachHang ASC
	--b
	 SELECT * FROM MATHANG1
	 ORDER BY SOLUONG DESC;
	--C
	SELECT DISTINCT S.MaHang, TenHang
	FROM MATHANG1 S INNER JOIN CHITIETDATHANG1 C
	ON S.MaHang = C.MaHang
	AND EXISTS(SELECT *
	FROM CHITIETDATHANG1 C INNER JOIN DONDATHANG1 H
	ON C.SoHoaDon = H.SoHoaDon
	and MaKhachHang IN(SELECT H.MaKhachHang
	FROM DONDATHANG1 H INNER JOIN KHACHHANG1 K
	ON H.MaKhachHang = K.MaKhachhang
	WHERE TenKhachHang = N'Nguyễn Văn An') AND S.MaHang = C.MaHang)
	--6
	--a
	SELECT K.MaKhachhang
	FROM KHACHHANG1 K INNER JOIN DONDATHANG1 H
	ON K.MaKhachhang = H.MaKhachHang
	--b
	SELECT  DISTINCT Mahang,TenHang
	FROM MATHANG1
	--c
	SELECT DONDATHANG1.MaKhachHang,CHITIETDATHANG1.SoHoaDon,
	SUM(SOLUONG*GiaBan) as 'Thanh Tien'
	FROM CHITIETDATHANG1,DONDATHANG1
	WHERE DONDATHANG1.SoHoaDon=CHITIETDATHANG1.SoHoaDon
	GROUP BY MaKhachHang,CHITIETDATHANG1.SoHoaDon
	--7
	--A
	UPDATE MATHANG1 SET MaLoaiHang = 'MT01' , GiaHang = 100000;
	SELECT * FROM MATHANG1
	--B
	--C
	ALTER TABLE MATHANG1
	ADD NgayXuatHien date;
	select * from MATHANG1
