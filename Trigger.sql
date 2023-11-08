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
-- Khi người dùng mua hàng, trigger cập nhật số lượng đồng hồ trong kho
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


-- thông báo đến người quản trị khi số lượng đồng hồ còn trong kho dưới 1 ngưỡng nhất định .
CREATE TABLE AdminNotifications (
    NotificationID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    Quantity INT
);
GO


-- Tạo trigger để thông báo quản trị khi Quantity trong bảng SmartWatch được cập nhật
-- sau đó kiểm tra và xử lý các trường hợp Quantity <= 2
DROP TRIGGER NotifyAdminOnLowQuantity

CREATE TRIGGER NotifyAdminOnLowQuantity
ON SmartWatch
AFTER UPDATE
AS
BEGIN
    -- Tạo bảng tạm thời để lưu trữ thông tin trước và sau cập nhật
    CREATE TABLE #TempQuantityChanges (
        ProductID INT,
        OldQuantity INT,
        NewQuantity INT
    );

    -- Chèn thông tin trước và sau cập nhật vào bảng tạm thời
    INSERT INTO #TempQuantityChanges (ProductID, OldQuantity, NewQuantity)
    SELECT d.ProductID, d.Quantity, i.Quantity
    FROM deleted d
    INNER JOIN inserted i ON d.ProductID = i.ProductID;

    -- Xóa dữ liệu trong bảng AdminNotifications tương ứng với sản phẩm có Quantity > 2 sau cập nhật
    DELETE an
    FROM AdminNotifications an
    INNER JOIN #TempQuantityChanges tc ON an.ProductID = tc.ProductID
    WHERE tc.NewQuantity > 2;

    -- Insert các sản phẩm có Quantity <= 2 từ bảng SmartWatch vào bảng AdminNotifications
    INSERT INTO AdminNotifications (ProductID, Quantity)
    SELECT i.ProductID, i.NewQuantity
    FROM #TempQuantityChanges i
    WHERE i.NewQuantity <= 2;

    -- Xóa bảng tạm thời
    DROP TABLE #TempQuantityChanges;
END;















