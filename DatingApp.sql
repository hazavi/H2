USE MASTER
IF DB_ID('DatingAppDb') IS NOT NULL
BEGIN
	ALTER DATABASE DatingAppDb SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE DatingAppDb
END

create database DatingAppDb
use DatingAppDb
go

drop database DatingAppDb

Create Table Postal(
	Id int primary key not null,
	[PostalCode] int not null,
	[City] nvarchar(50) not null,
)

Create Table Country(
	[CountryCode] char(2) unique not null,
	[CountryName] nvarchar(50) unique not null,
)

Create Table Gender(
	Id int unique identity(1,1) not null,
	[Name] nvarchar(50) primary key not null,
)

Create Table Person(
	Id int primary key identity(1,1) not null,
	[FirstName] nvarchar(50) not null,
	[LastName] nvarchar(50) not null,
	[BirthDate] date not null,
	[PostalCode] int foreign key references Postal(Id),
	[CountryCode] char(2) foreign key references Country(CountryCode),
	[Gender] nvarchar(50) foreign key references Gender([Name]),
	[Bio] nvarchar(150),
	[Likes] int not null,
)