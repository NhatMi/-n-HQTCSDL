------------------------------Bai 1.1 -----------------------------------------

SELECT IIF (LUONG>=LTB, 'KHONG TANG LUONG','TANG LUONG')
AS THUONG, TENNV, LUONG, LTB
FROM 
(SELECT TENNV, LUONG, LTB FROM NHANVIEN,

(select PHG,avg(luong) as "ltb" FROM NHANVIEN GROUP BY PHG) AS TEMP
WHERE NHANVIEN.PHG=TEMP.PHG) AS ABC

------------------------------Bai 1.2 -----------------------------------------

SELECT IIF (LUONG>=LTB, 'NHANVIEN','TRUONGPHONG')
AS THUONG, TENNV, LUONG, LTB
FROM 
(SELECT TENNV, LUONG, LTB FROM NHANVIEN,

(select PHG,avg(luong) as "ltb" FROM NHANVIEN GROUP BY PHG) AS TEMP
WHERE NHANVIEN.PHG=TEMP.PHG) AS ABC

------------------------------Bai 1.3 -----------------------------------------

SELECT TENNV = CASE PHAI
  WHEN N'NAM' THEN 'MR. ' + [TENNV]
  WHEN N'NỮ' THEN 'MS. ' + [TENNV]

END
FROM NHANVIEN

------------------------------Bai 1.4 -----------------------------------------

SELECT TENNV,LUONG, THUE = CASE
  WHEN LUONG BETWEEN 0 AND 25000 THEN LUONG*0.1
  WHEN LUONG BETWEEN 25000 AND 30000 THEN LUONG*0.12

ELSE LUONG*0.25 END
FROM NHANVIEN
------------------------------Bai 2.1 -----------------------------------------

SELECT * FROM NHANVIEN
DECLARE @dem int=2;
WHILE @dem<(SELECT count(MANV)
FROM NHANVIEN)
 BEGIN
      SELECT * 
FROM NHANVIEN WHERE cast(MANV as int)=@dem
      SET @dem=@dem+2;
    END

------------------------------Bai 2.2 -----------------------------------------

SELECT * FROM NHANVIEN
DECLARE @demm int=2;
WHILE @demm<(SELECT count(MANV)
FROM NHANVIEN)
 BEGIN
      SELECT * 
FROM NHANVIEN WHERE cast(MANV as int)=@demm AND MANV!=4
      SET @demm=@demm+2;
    END

------------------------------Bai 3.1 -----------------------------------------

Begin try
    insert PHONGBAN values(799, 'ZXK-799', '2008-07-01', '0197-05-22')
----Nếu lệnh thực thi thành công in ra dòng bên dưới----
print'Them du lieu thanh cong'
end try

---nếu lỗi thì in ra dòng bên dưới-----
begin catch
print 'failure: chen du lieu khong thanh cong'
print 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1)
 + ': ' + ERROR_MESSAGE()
end catch
------------------------Bài 3.2--------------------
BEGIN TRY
   DECLARE @result INT
   SET @result = 55/0
END TRY
BEGIN CATCH
  DECLARE
@ErMessage NVARCHAR(2048),
@ErSeverity INT,
@ErState INT
SELECT
@ErMessage = ERROR_MESSAGE(),
@ErSeverity = ERROR_SEVERITY(),
@ErState = ERROR_STATE()
RAISERROR (@ErMEssage,
            @ErSeverity,
            @ErState )
END CATCH
---------------------Bài 4-----------------------
-----Tính tổng các số chẵn từ 1 đến 10----------------
DECLARE @tong int = 0,@c int,@g int = 1;
SET @c = 10 
WHILE (@g<=@c)
BEGIN
if (@g %2 =0)
SET @tong = @tong + @g
SET @g = @g + 1 
END
PRINT ('Tong cac so chan la: ' )
PRINT @tong


-----Tính tổng các số từ 1 đến 10 trừ số 4----------------
DECLARE @tong1 int = 0,@d INT = 10,@F INT
SET @F = 1
WHILE (@f<=@d)
BEGIN
if (@f %2 =0)
SET @tong1 = @tong1 + @f
SET @f = @f + 1 
if(@f = 4)
SET @tong1 = @tong1 - 4
END
PRINT ('Tong cac so chan tru 4 la: ' )
PRINT @tong1