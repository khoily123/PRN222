USE [master]
GO
/****** Object:  Database [projectPRN222]    Script Date: 03/03/2025 11:47:33 SA ******/
CREATE DATABASE [projectPRN222]
GO
ALTER DATABASE [projectPRN222] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [projectPRN222].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [projectPRN222] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [projectPRN222] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [projectPRN222] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [projectPRN222] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [projectPRN222] SET ARITHABORT OFF 
GO
ALTER DATABASE [projectPRN222] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [projectPRN222] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [projectPRN222] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [projectPRN222] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [projectPRN222] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [projectPRN222] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [projectPRN222] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [projectPRN222] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [projectPRN222] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [projectPRN222] SET  ENABLE_BROKER 
GO
ALTER DATABASE [projectPRN222] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [projectPRN222] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [projectPRN222] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [projectPRN222] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [projectPRN222] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [projectPRN222] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [projectPRN222] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [projectPRN222] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [projectPRN222] SET  MULTI_USER 
GO
ALTER DATABASE [projectPRN222] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [projectPRN222] SET DB_CHAINING OFF 
GO
ALTER DATABASE [projectPRN222] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [projectPRN222] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [projectPRN222] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [projectPRN222] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [projectPRN222] SET QUERY_STORE = ON
GO
ALTER DATABASE [projectPRN222] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [projectPRN222]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 03/03/2025 11:47:33 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
    [a_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[balance] [money] NULL,
	[type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[a_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Computer]    Script Date: 03/03/2025 11:47:33 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Computer](
	[pc_id] [int] IDENTITY(1,1) NOT NULL,
	[pc_name] [nvarchar](50) NOT NULL,
	[pc_type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Computer_Session]    Script Date: 03/03/2025 11:47:33 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Computer_Session](
	[cs_id] [int] IDENTITY(1,1) NOT NULL,
	[pc_id] [int] NOT NULL,
	[a_id] [int] NOT NULL,
	[time_start] [datetime] NOT NULL,
	[time_end] [datetime] NULL,
	[status] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[cs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Computer_Type]    Script Date: 03/03/2025 11:47:33 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Computer_Type](
	[ct_id] [int] IDENTITY(1,1) NOT NULL,
	[ct_name] [nvarchar](50) NOT NULL,
	[price] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 03/03/2025 11:47:33 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[od_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[unitPrice] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[od_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 03/03/2025 11:47:33 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[a_id] [int] NOT NULL,
	[order_date] [date] NOT NULL,
	[totalAmount] [money] NOT NULL,
	[status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 03/03/2025 11:47:33 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[price] [money] NOT NULL,
	[image] [nvarchar](255) NOT NULL,
	[description] [text] NULL,
	[type] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Account] ([username], [password], [balance], [type]) VALUES (N'user1', N'pass1', 50000.0000, 0)
INSERT [dbo].[Account] ([username], [password], [balance], [type]) VALUES (N'user2', N'pass2', 120000.0000, 0)
INSERT [dbo].[Account] ([username], [password], [balance], [type]) VALUES (N'admin', N'adminpass', NULL, 1)
INSERT [dbo].[Account] ([username], [password], [balance], [type]) VALUES (N'user3', N'pass3', 80000.0000, 0)
INSERT [dbo].[Account] ([username], [password], [balance], [type]) VALUES (N'user4', N'pass4', 30000.0000, 0)
INSERT [dbo].[Account] ([username], [password], [balance], [type]) VALUES (N'user5', N'pass5', 60000.0000, 0)
INSERT [dbo].[Account] ([username], [password], [balance], [type]) VALUES (N'user6', N'pass6', 100000.0000, 0)
GO
INSERT [dbo].[Computer] ( [pc_name], [pc_type]) VALUES (N'PC_01', 1)
INSERT [dbo].[Computer] ( [pc_name], [pc_type]) VALUES (N'PC_02', 1)
INSERT [dbo].[Computer] ( [pc_name], [pc_type]) VALUES (N'PC_03', 2)
INSERT [dbo].[Computer] ( [pc_name], [pc_type]) VALUES (N'PC_04', 2)
INSERT [dbo].[Computer] ( [pc_name], [pc_type]) VALUES (N'PC_05', 3)
INSERT [dbo].[Computer] ( [pc_name], [pc_type]) VALUES (N'PC_06', 3)
INSERT [dbo].[Computer] ( [pc_name], [pc_type]) VALUES (N'PC_07', 1)
INSERT [dbo].[Computer] ( [pc_name], [pc_type]) VALUES (N'PC_08', 2)
INSERT [dbo].[Computer] ( [pc_name], [pc_type]) VALUES (N'PC_09', 4)
INSERT [dbo].[Computer] ( [pc_name], [pc_type]) VALUES (N'PC_10', 4)
GO
INSERT [dbo].[Computer_Session] ( [pc_id], [a_id], [time_start], [time_end], [status]) VALUES (1, 1, CAST(N'2025-02-12T10:00:00.000' AS DateTime), CAST(N'2025-02-12T12:00:00.000' AS DateTime), N'F')
INSERT [dbo].[Computer_Session] ( [pc_id], [a_id], [time_start], [time_end], [status]) VALUES (2, 2, CAST(N'2025-02-12T14:00:00.000' AS DateTime), NULL, N'A')
INSERT [dbo].[Computer_Session] ( [pc_id], [a_id], [time_start], [time_end], [status]) VALUES (3, 3, CAST(N'2025-02-12T15:00:00.000' AS DateTime), NULL, N'A')
INSERT [dbo].[Computer_Session] ( [pc_id], [a_id], [time_start], [time_end], [status]) VALUES (4, 4, CAST(N'2025-02-12T16:00:00.000' AS DateTime), NULL, N'A')
INSERT [dbo].[Computer_Session] ( [pc_id], [a_id], [time_start], [time_end], [status]) VALUES (5, 5, CAST(N'2025-02-12T17:00:00.000' AS DateTime), NULL, N'A')
GO
INSERT [dbo].[Computer_Type] ( [ct_name], [price]) VALUES (N'Normal', 6000.0000)
INSERT [dbo].[Computer_Type] ( [ct_name], [price]) VALUES (N'VIP', 8000.0000)
INSERT [dbo].[Computer_Type] ( [ct_name], [price]) VALUES (N'Gaming', 10000.0000)
INSERT [dbo].[Computer_Type] ( [ct_name], [price]) VALUES (N'Super Gaming', 15000.0000)
GO
INSERT [dbo].[OrderDetail] ( [order_id], [product_id], [quantity], [unitPrice]) VALUES (1, 1, 1, 15000.0000)
INSERT [dbo].[OrderDetail] ( [order_id], [product_id], [quantity], [unitPrice]) VALUES (2, 2, 1, 10000.0000)
INSERT [dbo].[OrderDetail] ( [order_id], [product_id], [quantity], [unitPrice]) VALUES (2, 3, 1, 12000.0000)
INSERT [dbo].[OrderDetail] ( [order_id], [product_id], [quantity], [unitPrice]) VALUES (3, 4, 2, 20000.0000)
INSERT [dbo].[OrderDetail] ( [order_id], [product_id], [quantity], [unitPrice]) VALUES (4, 5, 1, 12000.0000)
INSERT [dbo].[OrderDetail] ( [order_id], [product_id], [quantity], [unitPrice]) VALUES (5, 6, 2, 40000.0000)
GO
INSERT [dbo].[Orders] ( [a_id], [order_date], [totalAmount], [status]) VALUES (1, CAST(N'2025-02-12' AS Date), 15000.0000, 1)
INSERT [dbo].[Orders] ( [a_id], [order_date], [totalAmount], [status]) VALUES (2, CAST(N'2025-02-12' AS Date), 22000.0000, 0)
INSERT [dbo].[Orders] ( [a_id], [order_date], [totalAmount], [status]) VALUES (3, CAST(N'2025-02-12' AS Date), 20000.0000, 1)
INSERT [dbo].[Orders] ( [a_id], [order_date], [totalAmount], [status]) VALUES (4, CAST(N'2025-02-12' AS Date), 12000.0000, 1)
INSERT [dbo].[Orders] ( [a_id], [order_date], [totalAmount], [status]) VALUES (5, CAST(N'2025-02-12' AS Date), 20000.0000, 0)
GO
INSERT [dbo].[Product] ( [name], [price], [image], [description], [type]) VALUES (N'Mì ly', 15000.0000, N'mi_ly.jpg', N'Mì Hảo Hảo ly nóng', N'F')
INSERT [dbo].[Product] ( [name], [price], [image], [description], [type]) VALUES (N'Sting', 10000.0000, N'sting.jpg', N'Nước tăng lực Sting', N'D')
INSERT [dbo].[Product] ( [name], [price], [image], [description], [type]) VALUES (N'Red Bull', 12000.0000, N'redbull.jpg', N'Bò húc Red Bull', N'D')
INSERT [dbo].[Product] ( [name], [price], [image], [description], [type]) VALUES (N'Coca-Cola', 10000.0000, N'coca.jpg', N'Nước ngọt Coca-Cola', N'D')
INSERT [dbo].[Product] ( [name], [price], [image], [description], [type]) VALUES (N'Snack', 12000.0000, N'snack.jpg', N'Bánh snack khoai tây', N'F')
INSERT [dbo].[Product] ( [name], [price], [image], [description], [type]) VALUES (N'Bánh mì', 20000.0000, N'banhmi.jpg', N'Bánh mì thịt', N'F')
GO
ALTER TABLE [dbo].[Computer]  WITH CHECK ADD FOREIGN KEY([pc_type])
REFERENCES [dbo].[Computer_Type] ([ct_id])
GO
ALTER TABLE [dbo].[Computer_Session]  WITH CHECK ADD FOREIGN KEY([pc_id])
REFERENCES [dbo].[Computer] ([pc_id])
GO
ALTER TABLE [dbo].[Computer_Session]  WITH CHECK ADD FOREIGN KEY([a_id])
REFERENCES [dbo].[Account] ([a_id])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([product_id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([a_id])
REFERENCES [dbo].[Account] ([a_id])
GO
USE [master]
GO
ALTER DATABASE [projectPRN222] SET  READ_WRITE 
GO
