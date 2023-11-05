USE SmartWatchManager;
GO
-- Đảm bảo giá tiền của đồng hồ không âm
CREATE TRIGGER SetPriceToZero
ON SmartWatch
FOR INSERT, UPDATE
AS
BEGIN
    UPDATE sw
    SET sw.Price = 0
    FROM SmartWatch sw
    JOIN inserted i ON sw.ProductID = i.ProductID
    WHERE i.Price < 0;
END;
GO
-- Khi cập nhật số lượng đồng hồ trong kho , trigger ghi lại thông tin về người dùng thực hiện thay đổi và thời gian cập nhật
CREATE TRIGGER UpdateSmartWatchQuantityOnOrder
ON OrderDetail
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @newQuantity INT;
  DECLARE @productId INT;

  SELECT @newQuantity = i.Quantity, @productId = i.ProductID
  FROM INSERTED i;

  -- Cập nhật số lượng trong bảng SmartWatch
  UPDATE SmartWatch
  SET Quantity = Quantity - @newQuantity
  WHERE ProductID = @productId;
END;
GO

-- Tạo trigger trước khi thêm sản phẩm SmartWatch
CREATE TRIGGER UpdateSmartWatchQuantityOnInsert
ON SmartWatch
INSTEAD OF INSERT
AS
BEGIN
  SET NOCOUNT ON;

  -- Tăng số lượng sản phẩm nếu sản phẩm đã tồn tại
  UPDATE SmartWatch
  SET Quantity = SmartWatch.Quantity + I.Quantity
  FROM SmartWatch
  INNER JOIN INSERTED I ON SmartWatch.ProductID = I.ProductID
  WHERE SmartWatch.Image = I.Image
  AND SmartWatch.CategoryID = I.CategoryID
  AND SmartWatch.Price = I.Price;

  -- Chỉ chèn dữ liệu mới vào bảng nếu sản phẩm chưa tồn tại
  INSERT INTO SmartWatch (ProductID, Image, CategoryID, Price, Quantity)
  SELECT ProductID, Image, CategoryID, Price, Quantity
  FROM INSERTED
  WHERE NOT EXISTS (
    SELECT 1
    FROM SmartWatch
    WHERE SmartWatch.ProductID = INSERTED.ProductID
    AND SmartWatch.Image = INSERTED.Image
    AND SmartWatch.CategoryID = INSERTED.CategoryID
    AND SmartWatch.Price = INSERTED.Price
  );
END;

-- thông báo đến người quản trị khi số lượng đồng hồ còn trong kho dưới 1 ngưỡng nhất định .
CREATE TABLE AdminNotifications (
    NotificationID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    Quantity INT
);
GO

CREATE TRIGGER NotifyAdminOnLowQuantity
ON SmartWatch
AFTER UPDATE
AS
BEGIN
    DECLARE @ProductID INT;
    DECLARE @NewQuantity INT;

    SELECT @ProductID = i.ProductID, @NewQuantity = i.Quantity
    FROM inserted i;

    IF @NewQuantity = 2
    BEGIN
        INSERT INTO AdminNotifications (ProductID, Quantity)
        VALUES (@ProductID, @NewQuantity);
    END;
END;








