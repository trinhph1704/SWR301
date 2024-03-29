USE [master]
GO
/****** Object:  Database [ARTWORKPLATFORM]    Script Date: 3/11/2024 1:59:19 PM ******/
CREATE DATABASE [ARTWORKPLATFORM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ARTWORKPLATFORM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ARTWORKPLATFORM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ARTWORKPLATFORM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ARTWORKPLATFORM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ARTWORKPLATFORM] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ARTWORKPLATFORM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ARTWORKPLATFORM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET ARITHABORT OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET RECOVERY FULL 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET  MULTI_USER 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ARTWORKPLATFORM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ARTWORKPLATFORM] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ARTWORKPLATFORM] SET QUERY_STORE = OFF
GO
USE [ARTWORKPLATFORM]
GO
/****** Object:  Table [dbo].[Artwork]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artwork](
	[ArtworkID] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[ImageURL] [nvarchar](max) NULL,
	[Title] [nvarchar](255) NULL,
	[Description] [text] NULL,
	[Price] [decimal](10, 2) NULL,
	[GenreID] [nvarchar](50) NULL,
	[LinkShare] [nvarchar](255) NULL,
	[Like_times] [int] NULL,
	[Time] [datetime] NULL,
	[Reason] [nvarchar](255) NULL,
	[Status_Processing] [bit] NULL,
	[Time_Processing] [datetime] NULL,
	[ImageURL2] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ArtworkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[ArtworkID] [nvarchar](50) NULL,
	[Timestamp] [datetime] NULL,
	[Text] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genre]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[GenreID] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Like_Collection]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Like_Collection](
	[UserID] [nvarchar](50) NOT NULL,
	[ArtworkID] [nvarchar](50) NOT NULL,
	[Time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[ArtworkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_Premium]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Premium](
	[Order_PremiumID] [nvarchar](255) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[PremiumID] [nvarchar](50) NULL,
	[Status] [bit] NULL,
	[OrderDate] [date] NULL,
	[Total] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[Order_PremiumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_premium_log]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_premium_log](
	[Order_Premium_LogID] [nvarchar](255) NOT NULL,
	[Order_PremiumID] [nvarchar](255) NULL,
	[Status] [bit] NULL,
	[LogDate] [datetime] NULL,
	[Total] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[Order_Premium_LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ordertb]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ordertb](
	[OrderID] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[ArtworkID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[Status] [bit] NULL,
	[Total] [decimal](10, 0) NULL,
	[StatusCancel] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentID] [nvarchar](50) NOT NULL,
	[OrderID] [nvarchar](50) NULL,
	[Status] [bit] NULL,
	[Amount] [decimal](10, 2) NULL,
	[CreateDate] [datetime] NULL,
	[TransactionCode] [nvarchar](50) NULL,
	[VnpTransDate] [datetime] NULL,
	[StatusCancle] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment_Log]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_Log](
	[PaymentLogID] [nvarchar](50) NOT NULL,
	[PaymentID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[Status] [bit] NULL,
	[TransactionCode] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Premium]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Premium](
	[PremiumID] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[Day_expire] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PremiumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[ReportID] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[ArtworkID] [nvarchar](50) NULL,
	[ReportDate] [datetime] NULL,
	[Description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Role_Id] [nvarchar](50) NOT NULL,
	[RoleName] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Role_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction_Log]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction_Log](
	[TransactionID] [nvarchar](50) NOT NULL,
	[OrderID] [nvarchar](50) NULL,
	[Status] [bit] NULL,
	[CreateDate] [datetime] NULL,
	[FeedbackID] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Role]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Role](
	[UserID] [nvarchar](50) NOT NULL,
	[Role_Id] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[Role_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usertb]    Script Date: 3/11/2024 1:59:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usertb](
	[UserID] [nvarchar](50) NOT NULL,
	[Role_Id] [nvarchar](50) NULL,
	[ImageURL] [nvarchar](max) NULL,
	[Username] [nvarchar](255) NULL,
	[Password] [nvarchar](255) NULL,
	[Fullname] [nvarchar](255) NULL,
	[Sex] [nvarchar](10) NULL,
	[DateOfBirth] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[Noti] [nvarchar](50) NULL,
	[PremiumID] [nvarchar](50) NULL,
	[Money] [decimal](18, 0) NULL,
	[Status_Post] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Artwork] ([ArtworkID], [UserID], [ImageURL], [Title], [Description], [Price], [GenreID], [LinkShare], [Like_times], [Time], [Reason], [Status_Processing], [Time_Processing], [ImageURL2]) VALUES (N'1', N'1', N'https://d7hftxdivxxvm.cloudfront.net/?height=626&quality=80&resize_to=fit&src=https%3A%2F%2Fd32dm0rphc51dk.cloudfront.net%2FudkbL2AB8JJqt57cr4k44g%2Flarger.jpg&width=445', N'Pintura de aguja, 2019', N'Description 1', CAST(9300.00 AS Decimal(10, 2)), N'GenreID1', N'https://www.artsy.net/artwork/belen-rodriguez-gonzalez-pintura-de-aguja', 0, CAST(N'2024-02-20T16:55:39.860' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Artwork] ([ArtworkID], [UserID], [ImageURL], [Title], [Description], [Price], [GenreID], [LinkShare], [Like_times], [Time], [Reason], [Status_Processing], [Time_Processing], [ImageURL2]) VALUES (N'2', N'2', N'https://d7hftxdivxxvm.cloudfront.net/?height=626&quality=80&resize_to=fit&src=https%3A%2F%2Fd32dm0rphc51dk.cloudfront.net%2FudkbL2AB8JJqt57cr4k44g%2Flarger.jpg&width=445', N'Monochrome Blue Abstract Painting, Homage to Yves Klein, Diptych Abstract Painting, Blue, Dark Blue, Deep Blue, Ultramarine, Royal Blue, Yves Klein, Blue Artwork, Blue Square Painting, Textured Abstract Painting, 2024', N'Description 2', CAST(650.00 AS Decimal(10, 2)), N'GenreID2', N'https://www.artsy.net/artwork/leon-grossmann-monochrome-blue-abstract-painting-homage-to-yves-klein-diptych-abstract-painting-blue-dark-blue-deep-blue-ultramarine-royal-blue-yves-klein-blue-artwork-blue-square-painting-textured-abstract-painting', 0, CAST(N'2024-02-20T16:55:39.860' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Artwork] ([ArtworkID], [UserID], [ImageURL], [Title], [Description], [Price], [GenreID], [LinkShare], [Like_times], [Time], [Reason], [Status_Processing], [Time_Processing], [ImageURL2]) VALUES (N'3', N'6', N'https://d7hftxdivxxvm.cloudfront.net/?height=626&quality=80&resize_to=fit&src=https%3A%2F%2Fd32dm0rphc51dk.cloudfront.net%2FudkbL2AB8JJqt57cr4k44g%2Flarger.jpg&width=445', N'Impudens Venus. The Proclaimer I ( Grab Back), 2018', N'Description 3', CAST(2450.00 AS Decimal(10, 2)), N'GenreID3', N'https://www.artsy.net/artwork/ira-lombardia-impudens-venus-the-proclaimer-i-grab-back', 0, CAST(N'2024-02-20T16:55:39.860' AS DateTime), NULL, 0, NULL, NULL)
INSERT [dbo].[Artwork] ([ArtworkID], [UserID], [ImageURL], [Title], [Description], [Price], [GenreID], [LinkShare], [Like_times], [Time], [Reason], [Status_Processing], [Time_Processing], [ImageURL2]) VALUES (N'4', N'7', N'https://d7hftxdivxxvm.cloudfront.net/?height=626&quality=80&resize_to=fit&src=https%3A%2F%2Fd32dm0rphc51dk.cloudfront.net%2FudkbL2AB8JJqt57cr4k44g%2Flarger.jpg&width=445', N'Untitled, 2023', N'Description 4', CAST(100.00 AS Decimal(10, 2)), N'GenreID4', N'https://www.artsy.net/artwork/nene-untitled-28', 0, CAST(N'2024-02-20T16:55:39.860' AS DateTime), NULL, 0, NULL, NULL)
INSERT [dbo].[Artwork] ([ArtworkID], [UserID], [ImageURL], [Title], [Description], [Price], [GenreID], [LinkShare], [Like_times], [Time], [Reason], [Status_Processing], [Time_Processing], [ImageURL2]) VALUES (N'A377bc', N'7', N'string', N'Van Gohhhhhhhh', N'string', CAST(23420.00 AS Decimal(10, 2)), N'GenreID2', NULL, NULL, CAST(N'2024-03-09T14:03:30.170' AS DateTime), N'string', 0, NULL, N'string')
INSERT [dbo].[Artwork] ([ArtworkID], [UserID], [ImageURL], [Title], [Description], [Price], [GenreID], [LinkShare], [Like_times], [Time], [Reason], [Status_Processing], [Time_Processing], [ImageURL2]) VALUES (N'A775bb', NULL, N'string', N'abc', N'string', CAST(1220.00 AS Decimal(10, 2)), N'GenreID1', NULL, NULL, CAST(N'2024-02-24T16:30:58.610' AS DateTime), N'da duyet', 1, CAST(N'2024-02-24T16:31:47.327' AS DateTime), NULL)
GO
INSERT [dbo].[Comment] ([CommentID], [UserID], [ArtworkID], [Timestamp], [Text]) VALUES (N'C1a466', N'1', N'4', CAST(N'2024-02-29T23:24:50.137' AS DateTime), N'string')
INSERT [dbo].[Comment] ([CommentID], [UserID], [ArtworkID], [Timestamp], [Text]) VALUES (N'CommentID5', N'5', N'1', CAST(N'2024-02-20T16:55:39.860' AS DateTime), N'Beautiful work!')
INSERT [dbo].[Comment] ([CommentID], [UserID], [ArtworkID], [Timestamp], [Text]) VALUES (N'CommentID6', N'6', N'2', CAST(N'2024-02-20T16:55:39.860' AS DateTime), N'I love the texture.')
INSERT [dbo].[Comment] ([CommentID], [UserID], [ArtworkID], [Timestamp], [Text]) VALUES (N'CommentID7', N'7', N'3', CAST(N'2024-02-20T16:55:39.860' AS DateTime), N'Captivating!')
INSERT [dbo].[Comment] ([CommentID], [UserID], [ArtworkID], [Timestamp], [Text]) VALUES (N'CommentID8', N'1', N'4', CAST(N'2024-02-20T16:55:39.860' AS DateTime), N'Amazing details.')
GO
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (N'GenreID1', N'Abstract')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (N'GenreID2', N'Contemporary')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (N'GenreID3', N'Modern')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (N'GenreID4', N'Impressionism')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (N'GenreID5', N'Expressionism')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (N'GenreID6', N'Realism')
INSERT [dbo].[Genre] ([GenreID], [Name]) VALUES (N'GenreID7', N'Surrealism')
GO
INSERT [dbo].[Like_Collection] ([UserID], [ArtworkID], [Time]) VALUES (N'1', N'2', NULL)
INSERT [dbo].[Like_Collection] ([UserID], [ArtworkID], [Time]) VALUES (N'2', N'3', NULL)
INSERT [dbo].[Like_Collection] ([UserID], [ArtworkID], [Time]) VALUES (N'3', N'4', NULL)
INSERT [dbo].[Like_Collection] ([UserID], [ArtworkID], [Time]) VALUES (N'4', N'1', NULL)
INSERT [dbo].[Like_Collection] ([UserID], [ArtworkID], [Time]) VALUES (N'US52659', N'A775bb', CAST(N'2024-02-28T05:25:57.597' AS DateTime))
GO
INSERT [dbo].[Order_Premium] ([Order_PremiumID], [UserID], [PremiumID], [Status], [OrderDate], [Total]) VALUES (N'OP1', N'1', N'PremiumID', 1, CAST(N'2024-02-20' AS Date), NULL)
INSERT [dbo].[Order_Premium] ([Order_PremiumID], [UserID], [PremiumID], [Status], [OrderDate], [Total]) VALUES (N'OP2', N'2', N'PremiumID', 1, CAST(N'2024-02-20' AS Date), NULL)
GO
INSERT [dbo].[Ordertb] ([OrderID], [UserID], [ArtworkID], [CreateDate], [Status], [Total], [StatusCancel]) VALUES (N'Of71328', N'1', N'1', CAST(N'2024-02-21T07:11:42.470' AS DateTime), 1, CAST(9300 AS Decimal(10, 0)), 1)
INSERT [dbo].[Ordertb] ([OrderID], [UserID], [ArtworkID], [CreateDate], [Status], [Total], [StatusCancel]) VALUES (N'OrderID1', N'1', N'2', CAST(N'2024-02-20T16:55:39.860' AS DateTime), 0, CAST(10000 AS Decimal(10, 0)), 1)
INSERT [dbo].[Ordertb] ([OrderID], [UserID], [ArtworkID], [CreateDate], [Status], [Total], [StatusCancel]) VALUES (N'OrderID2', N'2', N'3', CAST(N'2024-02-20T16:55:39.860' AS DateTime), 1, CAST(10000 AS Decimal(10, 0)), 1)
INSERT [dbo].[Ordertb] ([OrderID], [UserID], [ArtworkID], [CreateDate], [Status], [Total], [StatusCancel]) VALUES (N'OrderID3', N'3', N'4', CAST(N'2024-02-20T16:55:39.860' AS DateTime), 1, CAST(10000 AS Decimal(10, 0)), 1)
INSERT [dbo].[Ordertb] ([OrderID], [UserID], [ArtworkID], [CreateDate], [Status], [Total], [StatusCancel]) VALUES (N'OrderID4', N'4', N'1', CAST(N'2024-02-20T16:55:39.860' AS DateTime), 1, CAST(10000 AS Decimal(10, 0)), NULL)
GO
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [Status], [Amount], [CreateDate], [TransactionCode], [VnpTransDate], [StatusCancle]) VALUES (N'P18af7ccf', N'OrderID4', 1, CAST(10000.00 AS Decimal(10, 2)), CAST(N'2024-03-01T11:35:51.207' AS DateTime), N'638448981432294166', NULL, 1)
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [Status], [Amount], [CreateDate], [TransactionCode], [VnpTransDate], [StatusCancle]) VALUES (N'P470905d5', N'Of71328', 0, CAST(9300.00 AS Decimal(10, 2)), CAST(N'2024-02-21T14:52:44.247' AS DateTime), N'638448979235939090', NULL, 1)
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [Status], [Amount], [CreateDate], [TransactionCode], [VnpTransDate], [StatusCancle]) VALUES (N'P583183f5', N'OrderID1', 1, CAST(10000.00 AS Decimal(10, 2)), CAST(N'2024-03-01T11:40:08.500' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [Status], [Amount], [CreateDate], [TransactionCode], [VnpTransDate], [StatusCancle]) VALUES (N'PaymentID1', N'OrderID1', 1, CAST(650.00 AS Decimal(10, 2)), CAST(N'2024-02-20T16:55:39.860' AS DateTime), N'638442799305680770', NULL, 1)
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [Status], [Amount], [CreateDate], [TransactionCode], [VnpTransDate], [StatusCancle]) VALUES (N'PaymentID2', N'OrderID2', 1, CAST(2450.00 AS Decimal(10, 2)), CAST(N'2024-02-20T16:55:39.860' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [Status], [Amount], [CreateDate], [TransactionCode], [VnpTransDate], [StatusCancle]) VALUES (N'PaymentID3', N'OrderID3', 1, CAST(100.00 AS Decimal(10, 2)), CAST(N'2024-02-20T16:55:39.860' AS DateTime), N'638443562204308740', NULL, 1)
INSERT [dbo].[Payment] ([PaymentID], [OrderID], [Status], [Amount], [CreateDate], [TransactionCode], [VnpTransDate], [StatusCancle]) VALUES (N'PaymentID4', N'OrderID4', 1, CAST(9300.00 AS Decimal(10, 2)), CAST(N'2024-02-20T16:55:39.860' AS DateTime), N'638444695272852310', NULL, 1)
GO
INSERT [dbo].[Payment_Log] ([PaymentLogID], [PaymentID], [CreateDate], [Status], [TransactionCode]) VALUES (N'PaymentLogID1', N'PaymentID1', CAST(N'2024-02-20T16:55:39.860' AS DateTime), 1, N'ABC123')
INSERT [dbo].[Payment_Log] ([PaymentLogID], [PaymentID], [CreateDate], [Status], [TransactionCode]) VALUES (N'PaymentLogID2', N'PaymentID2', CAST(N'2024-02-20T16:55:39.860' AS DateTime), 1, N'XYZ456')
INSERT [dbo].[Payment_Log] ([PaymentLogID], [PaymentID], [CreateDate], [Status], [TransactionCode]) VALUES (N'PaymentLogID3', N'PaymentID3', CAST(N'2024-02-20T16:55:39.860' AS DateTime), 1, N'123DEF')
INSERT [dbo].[Payment_Log] ([PaymentLogID], [PaymentID], [CreateDate], [Status], [TransactionCode]) VALUES (N'PaymentLogID4', N'PaymentID4', CAST(N'2024-02-20T16:55:39.860' AS DateTime), 1, N'456GHI')
GO
INSERT [dbo].[Premium] ([PremiumID], [Name], [price], [Day_expire]) VALUES (N'PremiumID', N'Pro', CAST(29.99 AS Decimal(10, 2)), N'Feb 20 2024  4:55PM')
GO
INSERT [dbo].[Report] ([ReportID], [UserID], [ArtworkID], [ReportDate], [Description]) VALUES (N'R68d5c', N'1', N'2', CAST(N'2024-03-06T16:52:03.527' AS DateTime), N'ádfsadefdsfsdfdsfsdfdsfds')
GO
INSERT [dbo].[Role] ([Role_Id], [RoleName]) VALUES (N'1', N'User')
INSERT [dbo].[Role] ([Role_Id], [RoleName]) VALUES (N'2', N'Moderator')
INSERT [dbo].[Role] ([Role_Id], [RoleName]) VALUES (N'3', N'Admin')
GO
INSERT [dbo].[Transaction_Log] ([TransactionID], [OrderID], [Status], [CreateDate], [FeedbackID]) VALUES (N'TransactionID1', N'OrderID1', 1, CAST(N'2024-02-20T16:55:39.860' AS DateTime), N'FeedbackID1')
INSERT [dbo].[Transaction_Log] ([TransactionID], [OrderID], [Status], [CreateDate], [FeedbackID]) VALUES (N'TransactionID2', N'OrderID2', 1, CAST(N'2024-02-20T16:55:39.860' AS DateTime), N'FeedbackID2')
INSERT [dbo].[Transaction_Log] ([TransactionID], [OrderID], [Status], [CreateDate], [FeedbackID]) VALUES (N'TransactionID3', N'OrderID3', 1, CAST(N'2024-02-20T16:55:39.860' AS DateTime), N'FeedbackID3')
INSERT [dbo].[Transaction_Log] ([TransactionID], [OrderID], [Status], [CreateDate], [FeedbackID]) VALUES (N'TransactionID4', N'OrderID4', 1, CAST(N'2024-02-20T16:55:39.860' AS DateTime), N'FeedbackID4')
GO
INSERT [dbo].[User_Role] ([UserID], [Role_Id]) VALUES (N'1', N'1')
INSERT [dbo].[User_Role] ([UserID], [Role_Id]) VALUES (N'2', N'1')
INSERT [dbo].[User_Role] ([UserID], [Role_Id]) VALUES (N'3', N'1')
INSERT [dbo].[User_Role] ([UserID], [Role_Id]) VALUES (N'4', N'1')
INSERT [dbo].[User_Role] ([UserID], [Role_Id]) VALUES (N'5', N'2')
INSERT [dbo].[User_Role] ([UserID], [Role_Id]) VALUES (N'6', N'1')
INSERT [dbo].[User_Role] ([UserID], [Role_Id]) VALUES (N'7', N'1')
GO
INSERT [dbo].[Usertb] ([UserID], [Role_Id], [ImageURL], [Username], [Password], [Fullname], [Sex], [DateOfBirth], [Address], [PhoneNumber], [Noti], [PremiumID], [Money], [Status_Post]) VALUES (N'1', N'1', N'ImageURL1', N'creator1', N'password1', N'Creator One', N'Male', N'1990-01-01', N'123 Street, City', N'1234567890', N'Yes', N'PremiumID', NULL, 1)
INSERT [dbo].[Usertb] ([UserID], [Role_Id], [ImageURL], [Username], [Password], [Fullname], [Sex], [DateOfBirth], [Address], [PhoneNumber], [Noti], [PremiumID], [Money], [Status_Post]) VALUES (N'2', N'1', N'ImageURL2', N'creator2', N'password2', N'Creator Two', N'Female', N'1995-05-05', N'456 Street, City', N'9876543210', N'Yes', N'PremiumID', NULL, 1)
INSERT [dbo].[Usertb] ([UserID], [Role_Id], [ImageURL], [Username], [Password], [Fullname], [Sex], [DateOfBirth], [Address], [PhoneNumber], [Noti], [PremiumID], [Money], [Status_Post]) VALUES (N'3', N'2', N'ImageURL5', N'audience1', N'password3', N'Audience One', N'Male', N'1985-10-10', N'789 Street, City', N'1112223333', N'No', NULL, NULL, 1)
INSERT [dbo].[Usertb] ([UserID], [Role_Id], [ImageURL], [Username], [Password], [Fullname], [Sex], [DateOfBirth], [Address], [PhoneNumber], [Noti], [PremiumID], [Money], [Status_Post]) VALUES (N'4', N'3', N'ImageURL6', N'moderator1', N'password4', N'Moderator One', N'Female', N'1980-12-12', N'987 Street, City', N'5556667777', N'No', NULL, NULL, 1)
INSERT [dbo].[Usertb] ([UserID], [Role_Id], [ImageURL], [Username], [Password], [Fullname], [Sex], [DateOfBirth], [Address], [PhoneNumber], [Noti], [PremiumID], [Money], [Status_Post]) VALUES (N'5', N'4', N'ImageURL7', N'admin1', N'password5', N'Admin One', N'Male', N'1975-06-06', N'654 Street, City', N'9990001111', N'No', NULL, NULL, 1)
INSERT [dbo].[Usertb] ([UserID], [Role_Id], [ImageURL], [Username], [Password], [Fullname], [Sex], [DateOfBirth], [Address], [PhoneNumber], [Noti], [PremiumID], [Money], [Status_Post]) VALUES (N'6', N'1', N'ImageURL3', N'creator3', N'password3', N'Creator three', N'Female', N'1995-05-06', N'456 Street, City', N'8876543210', N'Yes', N'PremiumID', NULL, 1)
INSERT [dbo].[Usertb] ([UserID], [Role_Id], [ImageURL], [Username], [Password], [Fullname], [Sex], [DateOfBirth], [Address], [PhoneNumber], [Noti], [PremiumID], [Money], [Status_Post]) VALUES (N'7', N'1', N'ImageURL4', N'creator4', N'password4', N'Creator four', N'Male', N'1997-05-05', N'456 Street, City', N'9876543219', N'Yes', N'PremiumID', NULL, 0)
INSERT [dbo].[Usertb] ([UserID], [Role_Id], [ImageURL], [Username], [Password], [Fullname], [Sex], [DateOfBirth], [Address], [PhoneNumber], [Noti], [PremiumID], [Money], [Status_Post]) VALUES (N'US52659', N'1', N'string', N'string', N'$2a$11$e3OD1yRNOKWG4z.71vT2Z.5eepa2iC0W3qpGBgcHFArMxdrpRX1Qm', N'nguyen gia huy', N'nam', N'2024-03-06', NULL, N'212312314', NULL, NULL, CAST(5000000 AS Decimal(18, 0)), 0)
GO
ALTER TABLE [dbo].[Artwork]  WITH CHECK ADD FOREIGN KEY([GenreID])
REFERENCES [dbo].[Genre] ([GenreID])
GO
ALTER TABLE [dbo].[Artwork]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Usertb] ([UserID])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([ArtworkID])
REFERENCES [dbo].[Artwork] ([ArtworkID])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Usertb] ([UserID])
GO
ALTER TABLE [dbo].[Like_Collection]  WITH CHECK ADD FOREIGN KEY([ArtworkID])
REFERENCES [dbo].[Artwork] ([ArtworkID])
GO
ALTER TABLE [dbo].[Like_Collection]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Usertb] ([UserID])
GO
ALTER TABLE [dbo].[Order_Premium]  WITH CHECK ADD FOREIGN KEY([PremiumID])
REFERENCES [dbo].[Premium] ([PremiumID])
GO
ALTER TABLE [dbo].[Order_Premium]  WITH CHECK ADD  CONSTRAINT [FK_Order_Premium_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[Usertb] ([UserID])
GO
ALTER TABLE [dbo].[Order_Premium] CHECK CONSTRAINT [FK_Order_Premium_UserID]
GO
ALTER TABLE [dbo].[order_premium_log]  WITH CHECK ADD FOREIGN KEY([Order_PremiumID])
REFERENCES [dbo].[Order_Premium] ([Order_PremiumID])
GO
ALTER TABLE [dbo].[Ordertb]  WITH CHECK ADD FOREIGN KEY([ArtworkID])
REFERENCES [dbo].[Artwork] ([ArtworkID])
GO
ALTER TABLE [dbo].[Ordertb]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Usertb] ([UserID])
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Ordertb] ([OrderID])
GO
ALTER TABLE [dbo].[Payment_Log]  WITH CHECK ADD FOREIGN KEY([PaymentID])
REFERENCES [dbo].[Payment] ([PaymentID])
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([ArtworkID])
REFERENCES [dbo].[Artwork] ([ArtworkID])
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Usertb] ([UserID])
GO
ALTER TABLE [dbo].[Transaction_Log]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Ordertb] ([OrderID])
GO
ALTER TABLE [dbo].[User_Role]  WITH CHECK ADD FOREIGN KEY([Role_Id])
REFERENCES [dbo].[Role] ([Role_Id])
GO
ALTER TABLE [dbo].[User_Role]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Usertb] ([UserID])
GO
ALTER TABLE [dbo].[Usertb]  WITH CHECK ADD FOREIGN KEY([PremiumID])
REFERENCES [dbo].[Premium] ([PremiumID])
GO
USE [master]
GO
ALTER DATABASE [ARTWORKPLATFORM] SET  READ_WRITE 
GO
