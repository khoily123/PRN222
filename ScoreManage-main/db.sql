USE [master]
GO
/****** Object:  Database [Project_PRN222]    Script Date: 18/03/2025 8:14:35 CH ******/
CREATE DATABASE [Project_PRN222]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Project_PRN222', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Project_PRN222.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Project_PRN222_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Project_PRN222_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Project_PRN222] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Project_PRN222].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Project_PRN222] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Project_PRN222] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Project_PRN222] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Project_PRN222] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Project_PRN222] SET ARITHABORT OFF 
GO
ALTER DATABASE [Project_PRN222] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Project_PRN222] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Project_PRN222] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Project_PRN222] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Project_PRN222] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Project_PRN222] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Project_PRN222] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Project_PRN222] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Project_PRN222] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Project_PRN222] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Project_PRN222] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Project_PRN222] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Project_PRN222] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Project_PRN222] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Project_PRN222] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Project_PRN222] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Project_PRN222] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Project_PRN222] SET RECOVERY FULL 
GO
ALTER DATABASE [Project_PRN222] SET  MULTI_USER 
GO
ALTER DATABASE [Project_PRN222] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Project_PRN222] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Project_PRN222] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Project_PRN222] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Project_PRN222] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Project_PRN222] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Project_PRN222] SET QUERY_STORE = OFF
GO
USE [Project_PRN222]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 18/03/2025 8:14:35 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](256) NOT NULL,
	[Role] [nvarchar](20) NOT NULL,
	[Avatar] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClassCourses]    Script Date: 18/03/2025 8:14:35 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassCourses](
	[ClassCourseId] [int] IDENTITY(1,1) NOT NULL,
	[ClassId] [int] NULL,
	[CourseId] [int] NULL,
	[LecturerId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 18/03/2025 8:14:35 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[ClassId] [int] IDENTITY(1,1) NOT NULL,
	[ClassCode] [nvarchar](10) NULL,
	[SemesterId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 18/03/2025 8:14:35 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseCode] [nvarchar](10) NULL,
	[CourseName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grades]    Script Date: 18/03/2025 8:14:35 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grades](
	[GradeId] [int] IDENTITY(1,1) NOT NULL,
	[StudentCourseId] [int] NULL,
	[Assignment1] [float] NULL,
	[Assignment2] [float] NULL,
	[Assignment3] [float] NULL,
	[ProgressTest1] [float] NULL,
	[ProgressTest2] [float] NULL,
	[ProgressTest3] [float] NULL,
	[FinalExam] [float] NULL,
	[AverageScore] [float] NULL,
	[Status] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[GradeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lecturers]    Script Date: 18/03/2025 8:14:35 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lecturers](
	[LecturerId] [int] IDENTITY(1,1) NOT NULL,
	[LecturerName] [nvarchar](100) NULL,
	[AccountId] [int] NULL,
	[Dob] [date] NULL,
	[Gender] [bit] NULL,
	[Address] [nvarchar](255) NULL,
	[PhoneNumber] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[LecturerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Majors]    Script Date: 18/03/2025 8:14:35 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Majors](
	[MajorId] [int] IDENTITY(1,1) NOT NULL,
	[MajorCode] [nvarchar](10) NULL,
	[MajorName] [nvarchar](100) NOT NULL,
	[Image] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[MajorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Semesters]    Script Date: 18/03/2025 8:14:35 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Semesters](
	[SemesterId] [int] IDENTITY(1,1) NOT NULL,
	[SemesterCode] [nvarchar](10) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[SemesterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentClasses]    Script Date: 18/03/2025 8:14:35 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentClasses](
	[StudentClassId] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[ClassId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 18/03/2025 8:14:35 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentId] [int] IDENTITY(1,1) NOT NULL,
	[StudentCode] [nvarchar](10) NOT NULL,
	[FullName] [nvarchar](100) NULL,
	[MajorId] [int] NULL,
	[Dob] [date] NULL,
	[Gender] [bit] NULL,
	[Address] [nvarchar](255) NULL,
	[PhoneNumber] [nvarchar](15) NULL,
	[AccountId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentsCourses]    Script Date: 18/03/2025 8:14:35 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentsCourses](
	[StudentCourseId] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[CourseId] [int] NULL,
	[ClassId] [int] NULL,
	[SemesterId] [int] NULL,
	[LecturerId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (1, N'admin', N'123', N'ADMIN', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (3, N'truonganh@fpt.edu.vn', N'123', N'LECTURER', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (8, N'minhthuy@fpt.edu.vn', N'123', N'LECTURER', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (9, N'tienlen@fpt.edu.vn', N'123', N'LECTURER', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (10, N'manhme@fpt.edu.vn', N'123', N'LECTURER', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (11, N'taloan@fpt.edu.vn', N'123', N'LECTURER', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (12, N'phipham@fpt.edu.vn', N'123', N'LECTURER', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (13, N'giangvien7', N'123', N'LECTURER', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (14, N'giangvien8', N'123', N'LECTURER', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (15, N'giangvien9', N'123', N'LECTURER', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (16, N'giangvien10', N'123', N'LECTURER', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (17, N'thiBSE170002@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (19, N'vanASE170004@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (21, N'vanAnSE170005@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (22, N'vanboSE170006@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (23, N'ducboSE170007@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (24, N'trandanSE170008@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (25, N'tulongSE170009@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (26, N'vanvuSE170010@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (27, N'luboSE170011@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (28, N'luubiSE170012@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (29, N'hoangcaiSE170013@fpt.edu', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (30, N'doandaihiepSE170014@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (31, N'khabanhSE170015@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (32, N'sontungmtpSE170016@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (33, N'jack5cuSE170017@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (34, N'lieunhuyenSE170018@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (35, N'vanBSE170019@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (36, N'phamnhungSE170020@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (37, N'quynhtrangDAD170021@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (38, N'lythithuDAD170022@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (39, N'GiangDAD170022@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (40, N'phaoDAD170024@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (41, N'thangDAD170025@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (42, N'soDAD170026@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (43, N'nhiDAD170027@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (44, N'chuongAI170028@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (45, N'huySE170029@fpt.edu.vn', N'123', N'STUDENT', NULL)
INSERT [dbo].[Accounts] ([AccountId], [Username], [PasswordHash], [Role], [Avatar]) VALUES (46, N'test1', N'123', N'STUDENT', NULL)
SET IDENTITY_INSERT [dbo].[Accounts] OFF
GO
SET IDENTITY_INSERT [dbo].[ClassCourses] ON 

INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (1, 1, 1, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (2, 1, 2, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (3, 1, 3, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (4, 1, 4, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (5, 1, 5, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (6, 1, 6, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (7, 2, 7, 4)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (8, 3, 8, 5)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (9, 4, 9, 6)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (10, 7, 10, 7)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (11, 8, 11, 8)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (12, 9, 12, 7)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (13, 10, 13, 7)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (14, 11, 14, 8)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (15, 12, 15, 4)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (16, 13, 16, 7)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (17, 14, 17, 4)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (18, 15, 18, 8)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (19, 16, 19, 6)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (20, 16, 20, 6)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (21, 16, 21, 4)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (22, 16, 22, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (23, 17, 24, 5)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (24, 17, 25, 8)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (25, 17, 26, 7)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (26, 17, 27, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (27, 17, 28, 7)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (28, 19, 29, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (29, 19, 30, 8)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (30, 19, 32, 7)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (31, 19, 33, 5)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (32, 19, 34, 5)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (33, 20, 35, 5)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (34, 20, 37, 5)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (35, 20, 38, 8)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (36, 20, 39, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (37, 22, 40, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (38, 22, 41, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (39, 22, 42, 5)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (40, 22, 43, 3)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (41, 22, 44, 5)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (42, 23, 45, 4)
INSERT [dbo].[ClassCourses] ([ClassCourseId], [ClassId], [CourseId], [LecturerId]) VALUES (43, 24, 46, 8)
SET IDENTITY_INSERT [dbo].[ClassCourses] OFF
GO
SET IDENTITY_INSERT [dbo].[Classes] ON 

INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (1, N'SE1747', 3)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (2, N'DAD1734', 1)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (3, N'AI1765', 2)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (4, N'ST11.M', 4)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (7, N'Greenfire3', 4)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (8, N'PC1734.P2', 4)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (9, N'Heatwave5', 5)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (10, N'Thunderbo5', 5)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (11, N'PC1725.P2', 5)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (12, N'DSA102', 5)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (13, N'Rocksky2', 6)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (14, N'TRS601', 6)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (15, N'VOV134', 6)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (16, N'SE1773', 7)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (17, N'SE1768', 8)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (19, N'SE1768SU23', 9)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (20, N'Se1768Fa23', 10)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (21, N'SE1759', 10)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (22, N'SE1756-NET', 1)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (23, N'ENW492C', 2)
INSERT [dbo].[Classes] ([ClassId], [ClassCode], [SemesterId]) VALUES (24, N'OJT_SU224', 2)
SET IDENTITY_INSERT [dbo].[Classes] OFF
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (1, N'MLN111', N'Philosophy of Marxism – Leninism')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (2, N'MLN122', N'	Political economics of Marxism – Leninism')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (3, N'PRN222', N'Advanced Cross-Platform Application Programming With .NET')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (4, N'EXE101', N'Experiential Entrepreneurship 1')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (5, N'SWD392', N'SW Architecture and Design')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (6, N'PRU212', N'C# Programming and Unity')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (7, N'DS101', N'Thiết kế 1')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (8, N'CG101', N'Chat GPT')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (9, N'GDQP', N'Military training')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (10, N'LUK2', N'Level 2')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (11, N'VOV114', N'Vovinam 1')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (12, N'LUK3', N'Level 3')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (13, N'LUK4', N'Level 4')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (14, N'VOV124', N'Vovinam 2')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (15, N'DSA102', N'Sao Truc')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (16, N'LUK5', N'LUK Global 5')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (17, N'TRS601', N'Transition')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (18, N'VOV134', N'Vovinam 3')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (19, N'CEA201', N'Computer Organization and Architecture')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (20, N'CSI104', N'Introduction to Computer Science')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (21, N'MAE101', N'Mathematics for Engineering')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (22, N'PRF192', N'Programming Fundamentals')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (23, N'SSL101c', N'Academic Skills for University Success')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (24, N'MAD101', N'Discrete mathematics')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (25, N'NWC203c', N'Computer Networking')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (26, N'OSG202', N'Operating Systems')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (27, N'PRO192', N'Object-Oriented Programming')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (28, N'SSG104', N'Communication and In-Group Working Skills')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (29, N'CSD201', N'Data Structures and Algorithms')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (30, N'DBI202', N'Introduction to Databases')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (32, N'JPD113', N'Elementary Japanese 1-A1.1 ')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (33, N'LAB211', N'OOP with Java Lab')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (34, N'WED201c', N'Web Design')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (35, N'IOT102', N'Internet vạn vật')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (36, N'JPD123', N'Elementary Japanese 1-A1.2')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (37, N'MAS291', N'Statistics and Probability')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (38, N'PRJ301', N'Java Web Application Development')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (39, N'SWE201c', N'Introduction to Software Engineering')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (40, N'ITE302c', N'Ethics in IT')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (41, N'PRN211', N'Basic Cross-Platform Application Programming With .NET')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (42, N'SWP391', N'Application development project ')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (43, N'SWR302', N'Software Requirement')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (44, N'SWT301', N'Software Testing')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (45, N'ENW492c', N'Writing Research Papers ')
INSERT [dbo].[Courses] ([CourseId], [CourseCode], [CourseName]) VALUES (46, N'OJT202', N'On the job training')
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[Grades] ON 

INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (1, 1, 4, 6, 2, 4, 5, 6, 0, 2.7, N'Not Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (2, 13, 6, 7, 5, 4, 6, 3, 8, 6.3, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (3, 2, 4, 5, 6, 1, 3, 7, 7, 5.4, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (4, 29, 6, 5, 8, 9, 2, 3, 7.9, 6.4600000000000009, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (6, 30, 5, 9, 1, 2, 5, 7, 7, 5.7000000000000011, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (7, 31, 8, 7, 9, 6, 6, 6, 4, 5.8000000000000007, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (8, 32, 7, 7, 7, 7, 7, 7, 4, 5.8000000000000007, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (9, 33, 5, 5, 5, 5, 5, 5, 8, 6.2, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (10, 34, 9, 8, 8, 7, 8, 7, 7, 7.5, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (11, 35, 3, 3, 3, 6, 6, 6, 9, 6.3000000000000007, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (12, 35, 1, 1, 1, 1, 1, 1, 2, 1.4, N'Not Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (13, 36, 9, 9, 9, 8, 8, 9, 9, 8.8, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (14, 37, 2, 5, 7, 9, 7, 8, 9, 7.4, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (15, 38, 2, 4, 6, 4, 7, 5, 7, 5.6000000000000005, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (16, 39, 6, 7, 6, 7, 6, 7, 6, 6.3000000000000007, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (17, 39, 8, 7, 8, 8, 7, 6, 9, 8, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (18, 40, 9, 9, 7, 8, 7, 8, 8, 8, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (19, 41, 8, 7, 8, 7, 8, 7, 8, 7.7, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (20, 42, 5, 7, 5, 7, 6, 5, 8, 6.7000000000000011, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (21, 42, 6, 6, 5, 6, 5, 6, 8, 6.6000000000000005, N'Pass')
INSERT [dbo].[Grades] ([GradeId], [StudentCourseId], [Assignment1], [Assignment2], [Assignment3], [ProgressTest1], [ProgressTest2], [ProgressTest3], [FinalExam], [AverageScore], [Status]) VALUES (22, 43, 7, 7, 6, 6, 7, 7, 8, 7.2, N'Pass')
SET IDENTITY_INSERT [dbo].[Grades] OFF
GO
SET IDENTITY_INSERT [dbo].[Lecturers] ON 

INSERT [dbo].[Lecturers] ([LecturerId], [LecturerName], [AccountId], [Dob], [Gender], [Address], [PhoneNumber]) VALUES (3, N'Nguyễn Trường Anh', 3, CAST(N'1989-09-07' AS Date), 1, N'Hà Nội', N'094358765')
INSERT [dbo].[Lecturers] ([LecturerId], [LecturerName], [AccountId], [Dob], [Gender], [Address], [PhoneNumber]) VALUES (4, N'Phạm Minh Thùy', 8, CAST(N'1999-06-04' AS Date), 0, N'Hà Nội', N'093454343')
INSERT [dbo].[Lecturers] ([LecturerId], [LecturerName], [AccountId], [Dob], [Gender], [Address], [PhoneNumber]) VALUES (5, N'Hoàng Tiến Lên', 9, CAST(N'1979-04-03' AS Date), 1, N'Hà Nội', N'09348734')
INSERT [dbo].[Lecturers] ([LecturerId], [LecturerName], [AccountId], [Dob], [Gender], [Address], [PhoneNumber]) VALUES (6, N'Trần Mạnh Mẽ', 10, CAST(N'1987-07-09' AS Date), 1, N'Hà Nội', N'094387232')
INSERT [dbo].[Lecturers] ([LecturerId], [LecturerName], [AccountId], [Dob], [Gender], [Address], [PhoneNumber]) VALUES (7, N'Tạ Thị Loan', 11, CAST(N'1999-12-12' AS Date), 0, N'Thái Bình', N'038712983')
INSERT [dbo].[Lecturers] ([LecturerId], [LecturerName], [AccountId], [Dob], [Gender], [Address], [PhoneNumber]) VALUES (8, N'Nguyễn Phi Phàm', 12, CAST(N'1990-09-12' AS Date), 1, N'Vĩnh Phúc', N'032981234')
SET IDENTITY_INSERT [dbo].[Lecturers] OFF
GO
SET IDENTITY_INSERT [dbo].[Majors] ON 

INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (3, N'SE', N'Kỹ thuật phần mềm', NULL)
INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (4, N'ASE', N'Công nghệ ô tô số', NULL)
INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (5, N'AI', N'Trí tuệ nhân tạo', NULL)
INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (6, N'DAD', N'Thiết kế mỹ thuật số', NULL)
INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (7, N'KDQT', N'Kinh doanh quốc tế', NULL)
INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (8, N'QTKS', N'Quản trị khách sạn', NULL)
INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (9, N'MCM', N'Truyền thông đa phương tiện', NULL)
INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (10, N'QHCC', N'Quan hệ công chúng', NULL)
INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (11, N'NNA', N'Ngôn ngữ Anh', NULL)
INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (12, N'NNN', N'Ngôn ngữ Nhật', NULL)
INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (13, N'NNH', N'Ngôn ngữ Hàn', NULL)
INSERT [dbo].[Majors] ([MajorId], [MajorCode], [MajorName], [Image]) VALUES (14, N'NNTQ', N'Ngôn ngữ Trung Quốc', NULL)
SET IDENTITY_INSERT [dbo].[Majors] OFF
GO
SET IDENTITY_INSERT [dbo].[Semesters] ON 

INSERT [dbo].[Semesters] ([SemesterId], [SemesterCode], [StartDate], [EndDate]) VALUES (1, N'Spring2024', CAST(N'2024-01-01' AS Date), CAST(N'2024-03-01' AS Date))
INSERT [dbo].[Semesters] ([SemesterId], [SemesterCode], [StartDate], [EndDate]) VALUES (2, N'Summer2024', CAST(N'2024-04-01' AS Date), CAST(N'2024-07-01' AS Date))
INSERT [dbo].[Semesters] ([SemesterId], [SemesterCode], [StartDate], [EndDate]) VALUES (3, N'Fall2024', CAST(N'2024-08-01' AS Date), CAST(N'2024-11-01' AS Date))
INSERT [dbo].[Semesters] ([SemesterId], [SemesterCode], [StartDate], [EndDate]) VALUES (4, N'Fall2021', CAST(N'2021-10-18' AS Date), CAST(N'2021-12-16' AS Date))
INSERT [dbo].[Semesters] ([SemesterId], [SemesterCode], [StartDate], [EndDate]) VALUES (5, N'Spring2022', CAST(N'2022-01-04' AS Date), CAST(N'2022-04-29' AS Date))
INSERT [dbo].[Semesters] ([SemesterId], [SemesterCode], [StartDate], [EndDate]) VALUES (6, N'Summer2022', CAST(N'2022-05-09' AS Date), CAST(N'2022-08-26' AS Date))
INSERT [dbo].[Semesters] ([SemesterId], [SemesterCode], [StartDate], [EndDate]) VALUES (7, N'Fall2022', CAST(N'2022-09-05' AS Date), CAST(N'2022-12-08' AS Date))
INSERT [dbo].[Semesters] ([SemesterId], [SemesterCode], [StartDate], [EndDate]) VALUES (8, N'Spring2023', CAST(N'2023-01-04' AS Date), CAST(N'2023-03-24' AS Date))
INSERT [dbo].[Semesters] ([SemesterId], [SemesterCode], [StartDate], [EndDate]) VALUES (9, N'Summer2023', CAST(N'2023-05-08' AS Date), CAST(N'2023-08-25' AS Date))
INSERT [dbo].[Semesters] ([SemesterId], [SemesterCode], [StartDate], [EndDate]) VALUES (10, N'Fall2023', CAST(N'2023-09-05' AS Date), CAST(N'2023-11-25' AS Date))
SET IDENTITY_INSERT [dbo].[Semesters] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentClasses] ON 

INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (1, 3, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (2, 4, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (3, 5, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (4, 6, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (5, 7, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (6, 8, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (7, 9, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (8, 10, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (9, 11, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (10, 12, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (11, 13, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (12, 14, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (13, 15, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (14, 16, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (15, 17, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (16, 18, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (17, 19, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (18, 20, 1)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (19, 21, 2)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (20, 22, 2)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (21, 23, 2)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (22, 24, 2)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (23, 25, 2)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (24, 26, 2)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (25, 27, 2)
INSERT [dbo].[StudentClasses] ([StudentClassId], [StudentId], [ClassId]) VALUES (26, 28, 3)
SET IDENTITY_INSERT [dbo].[StudentClasses] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (3, N'SE170002', N'Nguyễn Thị B', 3, CAST(N'2003-12-12' AS Date), 0, N'Hà Nội', N'098768754', 17)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (4, N'SE170004', N'Nguyễn Văn A', 3, CAST(N'2003-01-01' AS Date), 1, N'Hà Giang', N'091283721', 19)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (5, N'SE170005', N'Nguyễn Văn An', 3, CAST(N'2003-01-02' AS Date), 1, N'Cao Bằng', N'091238743', 21)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (6, N'SE170006', N'Nguyễn Văn Bo', 3, CAST(N'2003-02-09' AS Date), 1, N'Hà Giang', N'032981234', 22)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (7, N'SE170007', N'Trần Đức Bo', 3, CAST(N'2000-08-07' AS Date), 0, N'Bình Định', N'098763243', 23)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (8, N'SE170008', N'Trần Văn Dần', 3, CAST(N'1968-05-12' AS Date), 1, N'Califonia', N'013985644', 24)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (9, N'SE170009', N'Triệu Tử Long', 3, CAST(N'1300-12-22' AS Date), 1, N'Vũ Hán', N'067432765', 25)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (10, N'SE170010', N'Quan Văn Vũ', 3, CAST(N'1279-11-30' AS Date), 1, N'Bắc Kinh', N'092387432', 26)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (11, N'SE170011', N'Lữ Bố', 3, CAST(N'1305-03-12' AS Date), 1, N'Vũ Hán', N'092348712', 27)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (12, N'SE170012', N'Nguyễn Lưu Bị', 3, CAST(N'1302-02-12' AS Date), 1, N'Trùng Khánh', N'023871234', 28)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (13, N'SE170013', N'Hoàng Cái', 3, CAST(N'1400-03-06' AS Date), 1, N'Đảo dược sư', N'093219834', 29)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (14, N'SE170014', N'Doãn Chí Bình', 3, CAST(N'1587-05-04' AS Date), 1, N'Yên Kinh', N'092343547', 30)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (15, N'SE170015', N'Ngô Bá Khá', 3, CAST(N'1995-04-03' AS Date), 1, N'Thái Bình', N'092345093', 31)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (16, N'SE170016', N'Nguyễn Thanh Tùng', 3, CAST(N'1994-07-05' AS Date), 1, N'Thái Bình', N'093487234', 32)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (17, N'SE170017', N'Jack 5 Củ', 3, CAST(N'1997-09-07' AS Date), 1, N'Bến Tre', N'032984754', 33)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (18, N'SE170018', N'Liễu Như Yên', 3, CAST(N'2002-09-06' AS Date), 1, N'Trung Quốc', N'023459835', 34)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (19, N'SE170019', N'Trần Văn B', 3, CAST(N'2003-09-04' AS Date), 1, N'Hà Nội', N'093729834', 35)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (20, N'SE170020', N'Phan Thị Nhung', 3, CAST(N'2003-05-04' AS Date), 0, N'Hà Nội', N'093487234', 36)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (21, N'DAD170021', N'Nguyễn Quỳnh Trang', 6, CAST(N'2003-12-04' AS Date), 0, N'Hà Nội', N'092384098', 37)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (22, N'DAD170022', N'Lý Thị Thu', 6, CAST(N'2003-09-08' AS Date), 0, N'Hà Nội', N'092384354', 38)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (23, N'DAD170023', N'Nguyễn Hà Giang', 6, CAST(N'2002-09-06' AS Date), 0, N'Hà Giang', N'092349854', 39)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (24, N'DAD170024', N'Giàng A Pháo', 6, CAST(N'2003-06-05' AS Date), 1, N'Điện Biên Phủ', N'092384356', 40)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (25, N'DAD170025', N'Trần Hán Thăng', 6, CAST(N'2003-09-07' AS Date), 1, N'Tuyên Quang', N'093487234', 41)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (26, N'DAD170026', N'Thẩm Ấu Sở', 6, CAST(N'2003-05-04' AS Date), 0, N'Bắc Cạn', N'023984345', 42)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (27, N'DAD170027', N'Liễu Ngư Nhi', 6, CAST(N'2003-09-04' AS Date), 0, N'Nam Định', N'093454343', 43)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (28, N'AI170028', N'Lò Văn Chưởng', 5, CAST(N'2003-08-07' AS Date), 1, N'Hà Nội', N'023847345', 44)
INSERT [dbo].[Students] ([StudentId], [StudentCode], [FullName], [MajorId], [Dob], [Gender], [Address], [PhoneNumber], [AccountId]) VALUES (29, N'SE170029', N'Nguyễn Quang Huy', 3, CAST(N'2003-12-13' AS Date), 1, N'Tuyên Quang', N'092387543', 45)
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentsCourses] ON 

INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (1, 3, 1, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (2, 4, 1, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (3, 5, 1, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (4, 6, 1, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (5, 7, 1, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (7, 8, 1, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (8, 9, 2, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (9, 10, 2, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (10, 11, 2, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (11, 12, 2, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (12, 13, 2, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (13, 3, 3, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (14, 4, 3, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (15, 5, 3, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (16, 6, 3, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (17, 7, 3, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (18, 8, 3, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (19, 9, 3, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (20, 10, 3, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (21, 11, 3, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (22, 12, 3, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (23, 13, 3, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (24, 25, 7, 2, 1, 4)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (25, 26, 7, 2, 1, 4)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (26, 27, 7, 2, 1, 4)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (27, 28, 8, 3, 2, 5)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (29, 3, 4, 1, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (30, 3, 9, 4, 4, 6)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (31, 3, 10, 7, 4, 7)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (32, 3, 11, 8, 4, 8)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (33, 3, 12, 9, 5, 7)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (34, 3, 14, 11, 5, 8)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (35, 3, 15, 12, 5, 4)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (36, 3, 16, 13, 6, 7)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (37, 3, 17, 14, 6, 4)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (38, 3, 19, 16, 7, 6)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (39, 3, 20, 17, 8, 6)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (40, 3, 30, 19, 9, 8)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (41, 3, 35, 20, 10, 5)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (42, 3, 41, 22, 1, 3)
INSERT [dbo].[StudentsCourses] ([StudentCourseId], [StudentId], [CourseId], [ClassId], [SemesterId], [LecturerId]) VALUES (43, 3, 46, 24, 9, 8)
SET IDENTITY_INSERT [dbo].[StudentsCourses] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Accounts__536C85E4723942DA]    Script Date: 18/03/2025 8:14:35 CH ******/
ALTER TABLE [dbo].[Accounts] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Classes__2ECD4A5538B66450]    Script Date: 18/03/2025 8:14:35 CH ******/
ALTER TABLE [dbo].[Classes] ADD UNIQUE NONCLUSTERED 
(
	[ClassCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Courses__FC00E00082815756]    Script Date: 18/03/2025 8:14:35 CH ******/
ALTER TABLE [dbo].[Courses] ADD UNIQUE NONCLUSTERED 
(
	[CourseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Majors__64E58F941B22BBA1]    Script Date: 18/03/2025 8:14:35 CH ******/
ALTER TABLE [dbo].[Majors] ADD UNIQUE NONCLUSTERED 
(
	[MajorCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Semester__513151C9FC9A2F8D]    Script Date: 18/03/2025 8:14:35 CH ******/
ALTER TABLE [dbo].[Semesters] ADD UNIQUE NONCLUSTERED 
(
	[SemesterCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Students__1FC88604A4D81460]    Script Date: 18/03/2025 8:14:35 CH ******/
ALTER TABLE [dbo].[Students] ADD UNIQUE NONCLUSTERED 
(
	[StudentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClassCourses]  WITH CHECK ADD FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([ClassId])
GO
ALTER TABLE [dbo].[ClassCourses]  WITH CHECK ADD FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([CourseId])
GO
ALTER TABLE [dbo].[ClassCourses]  WITH CHECK ADD FOREIGN KEY([LecturerId])
REFERENCES [dbo].[Lecturers] ([LecturerId])
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD FOREIGN KEY([SemesterId])
REFERENCES [dbo].[Semesters] ([SemesterId])
GO
ALTER TABLE [dbo].[Grades]  WITH CHECK ADD FOREIGN KEY([StudentCourseId])
REFERENCES [dbo].[StudentsCourses] ([StudentCourseId])
GO
ALTER TABLE [dbo].[Lecturers]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([AccountId])
GO
ALTER TABLE [dbo].[StudentClasses]  WITH CHECK ADD FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([ClassId])
GO
ALTER TABLE [dbo].[StudentClasses]  WITH CHECK ADD FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([StudentId])
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([AccountId])
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD FOREIGN KEY([MajorId])
REFERENCES [dbo].[Majors] ([MajorId])
GO
ALTER TABLE [dbo].[StudentsCourses]  WITH CHECK ADD FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([ClassId])
GO
ALTER TABLE [dbo].[StudentsCourses]  WITH CHECK ADD FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([CourseId])
GO
ALTER TABLE [dbo].[StudentsCourses]  WITH CHECK ADD FOREIGN KEY([LecturerId])
REFERENCES [dbo].[Lecturers] ([LecturerId])
GO
ALTER TABLE [dbo].[StudentsCourses]  WITH CHECK ADD FOREIGN KEY([SemesterId])
REFERENCES [dbo].[Semesters] ([SemesterId])
GO
ALTER TABLE [dbo].[StudentsCourses]  WITH CHECK ADD FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([StudentId])
GO
ALTER TABLE [dbo].[Grades]  WITH CHECK ADD CHECK  (([Assignment1]>=(0) AND [Assignment1]<=(10)))
GO
ALTER TABLE [dbo].[Grades]  WITH CHECK ADD CHECK  (([Assignment2]>=(0) AND [Assignment2]<=(10)))
GO
ALTER TABLE [dbo].[Grades]  WITH CHECK ADD CHECK  (([Assignment3]>=(0) AND [Assignment3]<=(10)))
GO
ALTER TABLE [dbo].[Grades]  WITH CHECK ADD CHECK  (([FinalExam]>=(0) AND [FinalExam]<=(10)))
GO
ALTER TABLE [dbo].[Grades]  WITH CHECK ADD CHECK  (([ProgressTest1]>=(0) AND [ProgressTest1]<=(10)))
GO
ALTER TABLE [dbo].[Grades]  WITH CHECK ADD CHECK  (([ProgressTest2]>=(0) AND [ProgressTest2]<=(10)))
GO
ALTER TABLE [dbo].[Grades]  WITH CHECK ADD CHECK  (([ProgressTest3]>=(0) AND [ProgressTest3]<=(10)))
GO
USE [master]
GO
ALTER DATABASE [Project_PRN222] SET  READ_WRITE 
GO
