USE MASTER

IF DB_ID('DatingAppDb') IS NOT NULL
BEGIN
	ALTER DATABASE DatingAppDb SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE DatingAppDb
END

Create Database DatingAppDb
Use DatingAppDb
Go

Create Table Logins(
	LoginID int primary key identity(1,1) not null,
	[Username] nvarchar(20) unique not null,
	[Password] nvarchar(20) not null,

)

Create Table Profiles(
	ProfileId int primary key identity(1,1) not null,
	LoginId int foreign key references Logins(LoginID),

)

Create Table Countries(
	CountryCode char(2) unique not null,
	CountryName nvarchar(20) not null,
	CityName nvarchar(50) not null,
)

Create Table Gender(
	GenderId int unique identity(1,1) not null,
	[Name] nvarchar(50) primary key not null,
)

Create Table ProfileDetails(
	DetailsId int primary key identity(1,1) not null,
	ProfileId int foreign key references Profiles(ProfileId),
	[FirstName] nvarchar(50) not null,
	[LastName] nvarchar(50) not null,
	[BirthDate] date not null,
	[Country] char(2) foreign key references Countries(CountryCode),
	[Gender] nvarchar(50) foreign key references Gender([Name]),
	[Bio] nvarchar(150),

)

Create Table [Messages](
	MessageId int primary key identity(1,1) not null,
	SenderId int foreign key references Profiles(ProfileId),
	ReceiverId int foreign key references Profiles(ProfileId),
	MessageText nvarchar(200) not null,
	isRead int not null,
	CreateDate date not null,
)

Create Table Likes(
	LikeId int primary key identity(1,1) not null,
	LikerId int foreign key references Profiles(ProfileId),
	LikedId int foreign key references Profiles(ProfileId),
	[Status] int not null default 0
	
)

Alter table Likes
add CONSTRAINT UC_Likes UNIQUE (LikerId,LikedId)