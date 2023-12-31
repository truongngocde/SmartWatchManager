USE [SmartWatchManager]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 5/17/2023 11:08:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [nvarchar](50) NOT NULL,
	[CategoryName] [nvarchar](255) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 5/17/2023 11:08:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[Email] [varchar](50) NULL,
	[FContent] [ntext] NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 5/17/2023 11:08:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[Email] [varchar](250) NULL,
	[Password] [nvarchar](max) NULL,
	[ConfirmPassword] [nvarchar](max) NULL,
	[Phone] [nchar](10) NOT NULL,
	[Address] [nvarchar](250) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 5/17/2023 11:08:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderName] [varchar](250) NULL,
	[CustomerID] [int] NULL,
	[UserID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[ShipperDate] [datetime] NULL,
	[StatusID] [int] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 5/17/2023 11:08:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[TotalPrice] [decimal](18, 0) NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 5/17/2023 11:08:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 5/17/2023 11:08:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](250) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SmartWatch]    Script Date: 5/17/2023 11:08:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SmartWatch](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](255) NULL,
	[Image] [varchar](255) NULL,
	[Description] [ntext] NULL,
	[CategoryID] [nvarchar](50) NOT NULL,
	[Price] [decimal](18, 0) NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_SmartWatch] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/17/2023 11:08:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[Email] [varchar](50) NULL,
	[Password] [nvarchar](max) NULL,
	[Phone] [nchar](10) NULL,
	[Address] [nvarchar](255) NULL,
	[Image] [nvarchar](255) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (N'1', N'Apple Watch')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (N'2', N'Samsung')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (N'3', N'Huawie')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (N'4', N'Xiaomi')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (N'5', N'Asus')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (N'6', N'Garmin')
GO
SET IDENTITY_INSERT [dbo].[Contact] ON 

INSERT [dbo].[Contact] ([id], [FullName], [Email], [FContent]) VALUES (2, N'Đặng Thành Luân', N'luanthanh@gmail.com', N'Sản phẩm rất ưng ý')
INSERT [dbo].[Contact] ([id], [FullName], [Email], [FContent]) VALUES (3, N'Bùi Thành Danh', N'danh@gmail.com', N'Sản phẩm rất ưng ý')
SET IDENTITY_INSERT [dbo].[Contact] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerID], [FullName], [Email], [Password], [ConfirmPassword], [Phone], [Address]) VALUES (0, N'Đặng Thành Luân', N'luanthanh@gmail.com', N'25f9e794323b453885f5181f1b624d0b', N'25f9e794323b453885f5181f1b624d0b', N'0344796136', N'Phù Mỹ')
INSERT [dbo].[Customer] ([CustomerID], [FullName], [Email], [Password], [ConfirmPassword], [Phone], [Address]) VALUES (2, N'Bùi Thành Danh', N'danh@gmail.com', N'25f9e794323b453885f5181f1b624d0b', N'25f9e794323b453885f5181f1b624d0b', N'0344796136', N'Đà Nẵng')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [OrderName], [CustomerID], [UserID], [OrderDate], [ShipperDate], [StatusID]) VALUES (8, N'Ma-20230515215406', 0, NULL, CAST(N'2023-05-15T21:54:06.000' AS DateTime), CAST(N'2023-05-18T21:54:06.000' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderID], [OrderName], [CustomerID], [UserID], [OrderDate], [ShipperDate], [StatusID]) VALUES (9, N'Ma-20230515220049', 0, 5, CAST(N'2023-05-15T22:00:49.380' AS DateTime), CAST(N'2023-05-18T22:00:49.380' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderID], [OrderName], [CustomerID], [UserID], [OrderDate], [ShipperDate], [StatusID]) VALUES (10, N'Ma-20230516074852', 0, 5, CAST(N'2023-05-16T07:48:52.250' AS DateTime), CAST(N'2023-05-19T07:48:52.253' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderID], [OrderName], [CustomerID], [UserID], [OrderDate], [ShipperDate], [StatusID]) VALUES (11, N'Ma-20230516074925', 0, 5, CAST(N'2023-05-16T07:49:25.287' AS DateTime), CAST(N'2023-05-19T07:49:25.287' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderID], [OrderName], [CustomerID], [UserID], [OrderDate], [ShipperDate], [StatusID]) VALUES (12, N'Ma-20230516080031', 2, NULL, CAST(N'2023-05-16T08:00:31.000' AS DateTime), CAST(N'2023-05-19T08:00:31.000' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderID], [OrderName], [CustomerID], [UserID], [OrderDate], [ShipperDate], [StatusID]) VALUES (13, N'Ma-20230516082101', 2, 5, CAST(N'2023-05-16T08:21:01.677' AS DateTime), CAST(N'2023-05-19T08:21:01.677' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderID], [OrderName], [CustomerID], [UserID], [OrderDate], [ShipperDate], [StatusID]) VALUES (14, N'Ma-20230516084735', 0, 5, CAST(N'2023-05-16T08:47:35.490' AS DateTime), CAST(N'2023-05-19T08:47:35.490' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderID], [OrderName], [CustomerID], [UserID], [OrderDate], [ShipperDate], [StatusID]) VALUES (15, N'Ma-20230517084038', 0, 5, CAST(N'2023-05-17T08:40:38.797' AS DateTime), CAST(N'2023-05-20T08:40:38.797' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderID], [OrderName], [CustomerID], [UserID], [OrderDate], [ShipperDate], [StatusID]) VALUES (16, N'Ma-20230517084342', 0, 5, CAST(N'2023-05-17T08:43:42.150' AS DateTime), CAST(N'2023-05-20T08:43:42.150' AS DateTime), 1)
INSERT [dbo].[Order] ([OrderID], [OrderName], [CustomerID], [UserID], [OrderDate], [ShipperDate], [StatusID]) VALUES (17, N'Ma-20230517223017', 0, 5, CAST(N'2023-05-17T22:30:17.983' AS DateTime), CAST(N'2023-05-20T22:30:17.987' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (5, 8, 2, 1, CAST(7390000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (6, 8, 20, 1, CAST(7230000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (7, 8, 21, 3, CAST(15900000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (8, 10, 2, 1, CAST(7390000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (9, 10, 20, 1, CAST(7230000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (10, 10, 21, 3, CAST(15900000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (11, 11, 2, 1, CAST(7390000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (12, 11, 20, 1, CAST(7230000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (13, 11, 21, 3, CAST(15900000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (14, 12, 2, 1, CAST(7390000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (15, 12, 20, 1, CAST(7230000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (16, 13, 2, 1, CAST(7390000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (17, 13, 20, 2, CAST(14460000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (18, 14, 2, 1, CAST(7390000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (19, 14, 20, 1, CAST(7230000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (20, 15, 2, 1, CAST(7390000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (21, 15, 20, 1, CAST(7230000 AS Decimal(18, 0)))
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [ProductID], [Quantity], [TotalPrice]) VALUES (23, 17, 2, 1, CAST(7390000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([StatusID], [Name]) VALUES (1, N'Đã đặt hàng')
INSERT [dbo].[OrderStatus] ([StatusID], [Name]) VALUES (2, N'Đã xác nhận')
INSERT [dbo].[OrderStatus] ([StatusID], [Name]) VALUES (3, N'Đang xử lý')
INSERT [dbo].[OrderStatus] ([StatusID], [Name]) VALUES (4, N'Đang vận chuyển')
INSERT [dbo].[OrderStatus] ([StatusID], [Name]) VALUES (5, N'Đã giao hàng')
INSERT [dbo].[OrderStatus] ([StatusID], [Name]) VALUES (6, N'Đã hủy')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Staff')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[SmartWatch] ON 

INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (2, N'Samsung Galaxy Watch5 Bluetooth (44mm) Chính Hãng', N'samsung1.jpg', N'Đồng hồ thông minh Samsung Galaxy Watch 5 44mm sẽ đi kèm với màn hình nâng cấp sắc nét, theo dõi nhịp tim, theo dõi giấc ngủ và hơn thế nữa. Các thông số kỹ thuật cũng được cải tiến với bộ vi xử lý mới để tăng hiệu suất, tăng thời lượng pin và mở rộng số lượng ứng dụng mà mọi người có thể truy cập trên thiết bị.', N'2', CAST(7390000 AS Decimal(18, 0)), 10)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (20, N'Apple Watch SE 2 (2022) 44mm (GPS) Viền nhôm - Dây cao su Chính Hãng', N'apple1.jpg', N'Apple Watch SE 2 (2022) 44mm (GPS) Viền nhôm - Dây cao su Chính Hãng bán tại Di Động Việt - Đại lý uỷ quyền chính thức của Apple tại Việt Nam. Chiếc smartwatch này sở hữu màn hình rộng 1.78 inches, hiển thị nhiều thông tin. Với nhiều tính năng theo dõi sức khỏe hiện đại, thiết bị hứa hẹn mang đến những trải nghiệm tuyệt vời cho người dùng.', N'1', CAST(7230000 AS Decimal(18, 0)), 4)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (21, N'Xiaomi Series 8 41mm (GPS) Viền nhôm - Dây cao su | Chính Hãng VN', N'apple2.jpg', N'Xiaomi Series 8 41mm (GPS) Viền nhôm - Dây cao su | Chính Hãng VN/A sở hữu ngoại hình sang trọng, hiển thị nội dung bảo quát rõ ràng với màn hình lớn hơn, có kích thước là 41mm và 45mm, chạy trên nền hệ điều hành watchOS 9 cùng nhiều tính năng đo lường sức khoẻ mới như tính năng đo huyết áp, bơi lội, v.v', N'4', CAST(5300000 AS Decimal(18, 0)), 4)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (22, N'Samsung Galaxy Watch5 LTE (40mm) Chính Hãng', N'samsung3.jpg', N'Đồng hồ thông minh Samsung Galaxy Watch 5 LTE (40mm)được trang bị màn hình nâng cấp sắc nét được làm từ chất liệu sapphire. Nó sở hữu nhiều tính năng chăm sóc sức khỏe như: theo dõi nhịp tim, theo dõi giấc ngủ, đo nồng oxy SpO2, đo huyết áp và điện tâm đồ. Bên cạnh đó, chiếc smartwatch này còn được trang bị viên pin 284 mAh cho phép sử dụng bền bỉ hơn so với đời tiền nhiệm.', N'2', CAST(5730000 AS Decimal(18, 0)), 5)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (23, N'Đồng hồ thông minh Huawei Watch GT Cyber Chính Hãng', N'huawei1.png', N'Đồng hồ Huawei Watch GT Cyber thiết kế thay đổi khung ngoài đồng hồ độc đáo, tạo nên cá tính riêng cho bạn. Tích hợp các tính năng theo dõi sức khoẻ hiện đại, nhiều bài tập luyện mới mẻ hơn. Chế tác bằng các vật liệu cao cấp giúp tạo ra một chiếc đồng hồ nhẹ, vừa vặn, thoải mái đeo trên tay suốt cả ngày.', N'3', CAST(6370000 AS Decimal(18, 0)), 4)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (25, N'Đồng hồ thông minh Huawei Watch Buds', N'huawei2.jpg', N'Đồng hồ thông minh Huawei Watch Buds sở hữu thiết kế cực tinh xảo và trẻ trung nhưng không kém phần sang trọng với dáng mặt tròn cổ điển. Màn hình được trang bị tấm nền AMOLED giúp mang đến khả năng hiển thị sống động, sặc sỡ. Kết hợp với tai nghe được đặt ở ngay bên dưới màn hình giúp bạn có thể chơi nhạc ngay trên đồng hồ. Tai nghe được thiết kế nằm gọn trong tai - ít gây cảm giác đau khi dùng trong thời gian dài.', N'3', CAST(5430000 AS Decimal(18, 0)), 5)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (26, N'Samsung Galaxy Watch5 LTE (40mm) Chính Hãng', N'samsung1.jpg', N'sssssssssssssssssssssssssssssssss', N'2', CAST(7390000 AS Decimal(18, 0)), 6)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (35, N'Garmin Forerunner 255 Chính Hãng', N'garmin1.jpg', N'Đồng hồ thông minh Forerunner 255 sở hữu thiết kế nhỏ gọn, năng động. Được trang bị những tính năng bảo vệ sức khỏe vượt trội như chế độ luyện tập, theo dõi giấc ngủ, tính calo tiêu thụ, tính quãng đường chạy, đếm bước chân, đo lượng oxy trong máu, đo nhịp tim...Đồng thời, chiếc smartwatch này cũng được trang bị công nghệ chống nước chuẩn 5ATM.', N'6', CAST(8990000 AS Decimal(18, 0)), 5)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (36, N'Garmin Forerunner 255S Chính Hãng', N'garmin2.jpg', N'Đồng hồ thông minh Forerunner 255S sở hữu thiết kế trẻ trung, năng động cùng với nhiều tính năng bảo vệ sức khỏe như theo dõi nhịp tim, chỉ số luyện tập, lượng calo tiêu thụ, nồng độ oxy trong máu... Đồng thời được trang bị công nghệ chống nước lên đến 5ATM, đồng hành cùng bạn trong mọi điều kiện môi trường.', N'6', CAST(7990000 AS Decimal(18, 0)), 3)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (37, N'Vòng đeo tay thông minh Xiaomi Redmi Band 2', N'xiaomi1.jpg', N'Vòng đeo tay thông minh Redmi Band 2 sở hữu thiết kế nhỏ gọn, hiện đại. Với màn hình rộng 1.47 inch mang đến không gian trải nghiệm rộng lớn, mãn nhãn. Có độ mỏng chỉ 9.99mm vô cùng mỏng nhẹ mang đến cảm giác đeo thoải mái. Được trang bị hơn 30 chế độ tập luyện, kháng nước chuẩn 5ATM. Đồng thời, viên pin cho phép sử dụng lên đến 14 ngày cho nhu cầu sử dụng bình thường hàng ngày.', N'4', CAST(79000 AS Decimal(18, 0)), 6)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (38, N'Vòng đeo tay thông minh Xiaomi Band 7 Pro Chính Hãng', N'apple3.png', N'Vòng đeo tay thông minh Xiaomi Band 7 Pro sở hữu màn hình với kích thước 1.64 inch, AMOLED, với độ phân giải 280 x 456 pixel, mật độ điểm ảnh đạt mức “retina” là 326PPI. Bên cạnh đó còn hỗ trợ đo nhịp tim và SpO2 liên tục, theo dõi giấc ngủ và mức độ căng thẳng, đi kèm 117 chế độ luyện tập thể dục thể thao và 10 bài tập chạy. Ngoài ra có hỗ trợ kháng nước 5ATM. Sản phẩm tích hợp GPS và có thể hoạt động độc lập khi luyện tập.', N'4', CAST(299000 AS Decimal(18, 0)), 5)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (42, N'Samsung Galaxy Watch5 LTE (40mm) Chính Hãng', N'apple5.jpg', N'dddd', N'1', CAST(7390000 AS Decimal(18, 0)), 6)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (43, N'Apple Watch SE 2 (2022) 44mm (GPS) Viền nhôm - Dây cao su Chính Hãng', N'apple2.jpg', N'wwwwww', N'1', CAST(2560 AS Decimal(18, 0)), 2)
INSERT [dbo].[SmartWatch] ([ProductID], [ProductName], [Image], [Description], [CategoryID], [Price], [Quantity]) VALUES (47, N'Samsung Galaxy Watch5 LTE (40mm) Chính Hãng', N'garmin1.jpg', N'Garmin chinhs hang 1000 cam ket chat luong mai do mai do', N'5', CAST(2560 AS Decimal(18, 0)), 9)
SET IDENTITY_INSERT [dbo].[SmartWatch] OFF
GO
INSERT [dbo].[User] ([UserID], [RoleID], [FullName], [Email], [Password], [Phone], [Address], [Image]) VALUES (5, 1, N'Trương Ngọc Đệ', N'admin@gmail.com', N'827ccb0eea8a706c4c34a16891f84e7b', N'0344796136', N'Bình Định', N'admin1.png')
INSERT [dbo].[User] ([UserID], [RoleID], [FullName], [Email], [Password], [Phone], [Address], [Image]) VALUES (16, 2, N'Danh', N'staff@gmail.com', N'827ccb0eea8a706c4c34a16891f84e7b', N'0344796136', N'Đà Nẵng', N'face5.jpg')
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer1] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer1]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatus] FOREIGN KEY([StatusID])
REFERENCES [dbo].[OrderStatus] ([StatusID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User1] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User1]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_SmartWatch] FOREIGN KEY([ProductID])
REFERENCES [dbo].[SmartWatch] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_SmartWatch]
GO
ALTER TABLE [dbo].[SmartWatch]  WITH CHECK ADD  CONSTRAINT [FK_SmartWatch_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[SmartWatch] CHECK CONSTRAINT [FK_SmartWatch_Category]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
