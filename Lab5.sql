----------------------------------------bài 1a-------------------------------
create proc sp_Lab5_1a @name nvarchar(20)
as
	begin
		print 'Xin chào: ' + @name
	end
exec sp_Lab5_1a N'Phúc'


--------------------------------------bài 1b---------------------------------
create proc sp_Lab5_1b @numberA int, @numberB int
as
	begin
		declare @sum int = 0
		set @sum = @numberA + @numberB
		print 'Tong: ' + cast(@sum as varchar(10))
	end
exec sp_Lab5_1b 9,9
--------------------------------------bài 1c---------------------------------
create proc sp_Lab5_1c @n int
as
	begin
		declare @sum int = 0, @i int = 0;
		while @i < @n
			begin
				set @sum = @sum + @i
				set @i = @i + 2
			end
		print 'sum even: ' + cast(@sum as varchar(10))
	end

exec sp_Lab5_1c 20
----------------------------------bài 1d-------------------------------------
create proc sp_Lab5_1d @a int, @b int
as
	begin
		while (@a !=@b)
			begin
				if(@a > @b)
					set @a = @a -@b
				else
					set @b = @b -@a
			end
			return @a
	end
declare @c int
exec @c = sp_Lab5_1d 20,30
print @c
----------------------------------bài 2a-------------------------------------
create proc bai2a @MaNV varchar(3)
as
	begin
		select * from NHANVIEN where MANV = @MaNV
	end
exec bai2a '001'
-----------------------------bài2b--------------------------------------------------
CREATE PROC Bai2b @mada INT
AS
BEGIN
	SELECT COUNT(MANV) AS 'So luong NV', MADA, TENPHG
	FROM PHONGBAN
	INNER JOIN DEAN ON DEAN.PHONG = PHONGBAN.MAPHG
	INNER JOIN NHANVIEN ON NHANVIEN.PHG = PHONGBAN.MAPHG
	WHERE MADA = @mada
	GROUP BY TENPHG, MADA
END
----------------------------------bài2d--------------------------------------------
CREATE PROC Bai2c @trphg VARCHAR (20)
AS
BEGIN
	SELECT HONV, TENLOT, TENNV, TENPHG, NHANVIEN.MANV
	FROM NHANVIEN
	INNER JOIN PHONGBAN ON PHONGBAN.MAPHG = NHANVIEN.PHG
	LEFT OUTER JOIN THANNHAN ON THANNHAN.MA_NVIEN = NHANVIEN.MANV
	WHERE THANNHAN.MA_NVIEN IS NULL AND TRPHG = @trphg
END

EXEC Bai2c '008'
----------------------------------------bài2e------------------------------------
CREATE PROC Bai2d @manv VARCHAR(15), @mapb VARCHAR(15)
AS
BEGIN
	IF EXISTS(SELECT * FROM NHANVIEN WHERE MANV = @manv AND PHG = @mapb)
		PRINT 'Nhan vien ' + @manv + ' co trong phong ban: ' + @mapb
	ELSE
		PRINT'Nhan vien ' + @manv + ' khong co trong phong ban: ' + @mapb
END

EXEC Bai2d '006', '4'
--------------------------------------bài 3a------------------------------------
CREATE PROC Bai3a @mapb INT, @tenpb NVARCHAR(20), @trphg NVARCHAR(20), @ngaync DATE
AS
BEGIN
	IF(EXISTS(SELECT * FROM PHONGBAN WHERE MAPHG = @mapb))
		PRINT 'Them khong thanh cong'
	ELSE
		BEGIN
			INSERT INTO PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
			VALUES (@mapb, @tenpb, @trphg, @ngaync)
			PRINT('Them thanh cong')
		END
END

EXEC Bai3a '7', 'CNTT', '007', '2019-09-1'
--------------------------------bài 3b--------------------------------------------
CREATE PROC Bai3b @mapb INT, @tenpb NVARCHAR(20), @trphg NVARCHAR(20), @ngaync DATE
AS
BEGIN
	IF(EXISTS(SELECT * FROM PHONGBAN WHERE MAPHG = @mapb))
		UPDATE PHONGBAN
		SET TENPHG = @tenpb, TRPHG = @trphg, NG_NHANCHUC = @ngaync
		WHERE MAPHG = @mapb
	ELSE
		BEGIN
			INSERT INTO PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
			VALUES (@mapb, @tenpb, @trphg, @ngaync)
			PRINT('Cap nhat khong thanh cong')
		END
END

EXEC Bai3b '7', 'IT', '007', '2019-09-1'
--------------------------------------bài 3c-------------------------------------------
CREATE PROC Bai3c @honv NVARCHAR(20), @tenlot NVARCHAR(20), @tennv NVARCHAR(20), @manv NVARCHAR(10),
@ngsinh DATE, @dchi	NVARCHAR(50), @phai NVARCHAR(5), @luong FLOAT, @ma_nql NVARCHAR(5), @phg INT
AS
BEGIN
	DECLARE @age INT
	SET @age = YEAR(GETDATE()) - YEAR(@ngsinh)
	IF @phg = (SELECT MAPHG FROM PHONGBAN WHERE TENPHG = 'IT')
		BEGIN
			IF @luong < 25000
				SET @ma_nql = '009'
			ELSE SET @ma_nql = '005'

			IF (@phai = 'Nam' AND (@age >= 18 AND @age <= 65)) 
				OR (@phai = N'Nữ' AND (@age >= 18 AND @age <= 60))
				BEGIN
					INSERT INTO NHANVIEN(HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
					VALUES (@honv, @tenlot, @tennv, @manv, @ngsinh, @dchi, @phai, @luong, @ma_nql, @phg)
				END
			ELSE
				PRINT('Khong thuoc do tuoi lao dong')
		END
	ELSE
		PRINT ('Khong phai phong IT')
END

EXEC Bai3c 'Nguyen', 'Van', 'Linh', '021', '2002-04-03', 'Da Lat', 'Nam', '26000', '004', '5'
EXEC Bai3c 'Tran', 'Nguyen', 'Luan', '019', '2002-04-03', 'Da Lat', 'Nam', '26000', '004', '6'