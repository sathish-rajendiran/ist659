USE [IST659_M406_srajendi]
GO

/*
	Title	:	Lab 05 -SQL Scripts
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	January, 2020

	
*/


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='vc_UserLogin')
BEGIN
	DROP TABLE vc_UserLogin
END
Go


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='vc_FollowerList')
BEGIN
	DROP TABLE vc_FollowerList
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='vc_VidCastTagList')
BEGIN
	DROP TABLE vc_VidCastTagList
END
GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='vc_UserTagList')
BEGIN
	DROP TABLE vc_UserTagList
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='vc_VidCast')
BEGIN
	DROP TABLE vc_VidCast
END
GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='vc_Tag')
BEGIN
	DROP TABLE vc_Tag
END
GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='vc_User')
BEGIN
	DROP TABLE vc_User
END
GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='vc_Status')
BEGIN
	DROP TABLE vc_Status
END
GO


--Creating the User table
CREATE TABLE vc_User (
	--Columns for the User table
	vc_UserID int identity CONSTRAINT PK_vc_User PRIMARY KEY (vc_UserID),
	UserName varchar(20) not null CONSTRAINT U1_vc_User UNIQUE (UserName),
	EmailAddress varchar(50) not null CONSTRAINT U2_vc_User UNIQUE (EmailAddress),
	UserDescription varchar(200),
	WebSiteURL varchar(50),
	UserRegisteredDate datetime not null default GetDate()	
)
GO

--End Creating the User table


--Creating the UserLogin table
CREATE TABLE vc_UserLogin (
	--Columns for the UserLogin table
	vc_UserLoginID int identity CONSTRAINT PK_vc_UserLogin PRIMARY KEY (vc_UserLoginID),
	vc_UserID int not null CONSTRAINT FK1_vc_UserLogin FOREIGN KEY (vc_UserID) REFERENCES vc_User(vc_UserID),
	UserLoginTimestamp datetime not null default GetDate(),
	LoginLocation varchar(50) not null
)
GO

--End Creating the User Login table

--Adding Data to the User table
INSERT INTO vc_User(UserName,EmailAddress,UserDescription)
	VALUES
		  ('RDwight','rdwight@nodomain.xyz','Piano Teacher'),
		  ('SaulHudson','slash@nodomain.xyz','I Like Les Paul guitars'),
		  ('Gordon','sumner@nodomain.xyz','Former cop')
GO

--SELECT * FROM vc_User

--Creating the Follower List table
CREATE TABLE vc_FollowerList (
	--Columns for the Follower List table
	vc_FollowerListID int identity CONSTRAINT PK_vc_FollowerList PRIMARY KEY (vc_FollowerListID),
	FollowerID int not null CONSTRAINT FK1_vc_FollowerList FOREIGN KEY (FollowerID) REFERENCES vc_User(vc_UserID),
	FollowedID int not null CONSTRAINT FK2_vc_FollowerList FOREIGN KEY (FollowedID) REFERENCES vc_User(vc_UserID),
	FollowerSince datetime not null CONSTRAINT DF1_FollowerList DEFAULT GETDATE(),
)
GO

--End Creating the User table

--Add unique constraints on FollowerList table
ALTER TABLE vc_FollowerList
ADD CONSTRAINT U1_vc_FollowerList UNIQUE (FollowerID,FollowedID)
GO

--End adding unique constraints to FollowerList table


--Creating the Tag table
CREATE TABLE vc_Tag (
	--Columns for the Tag table
	vc_TagID int identity CONSTRAINT PK_vc_Tag PRIMARY KEY (vc_TagID),
	TagText varchar(20) not null CONSTRAINT U1_vc_Tag UNIQUE (TagText),
	TagDescription varchar(100)
)
GO

--End Creating the Tag table

--Creating the Status table
CREATE TABLE vc_Status (
	--Columns for the Status table
	vc_StatusID int identity CONSTRAINT PK_vc_Status PRIMARY KEY (vc_StatusID),
	StatusText varchar(20) not null CONSTRAINT U1_vc_Status UNIQUE (StatusText)
)
GO

--End Creating the Status table


--Creating the VidCast table
CREATE TABLE vc_VidCast (
	--Columns for the VidCast table
	vc_VidCastID int identity CONSTRAINT PK_vc_VidCast PRIMARY KEY (vc_VidCastID),
	VidCastTitle varchar(50) not null,
	StartDateTime datetime,
	EndDateTime datetime,
	ScheduledDurationMinutes int,
	RecordingURL varchar(50) not null,
	vc_UserID int not null CONSTRAINT FK1_vc_VidCast FOREIGN KEY (vc_UserID) REFERENCES vc_User(vc_UserID),
	vc_StatusID int not null CONSTRAINT FK2_vc_VidCast FOREIGN KEY (vc_StatusID) REFERENCES vc_Status(vc_StatusID)
)
GO

--End Creating the VidCast table

--Creating the VidCastTagList table
CREATE TABLE vc_VidCastTagList (
	--Columns for the VidCastTagList table
	vc_VidCastTagListID int identity CONSTRAINT PK_vc_VidCastTagList PRIMARY KEY (vc_VidCastTagListID),
	vc_TagID int not null CONSTRAINT FK1_vc_VidCastTagList FOREIGN KEY (vc_TagID) REFERENCES vc_Tag(vc_TagID),
	vc_VidCastID int not null CONSTRAINT FK2_vc_VidCastTagList FOREIGN KEY (vc_VidCastID) REFERENCES vc_VidCast(vc_VidCastID)
)
GO

--End Creating the VidCastTagList table

--Add unique constraints on VidCastTagList table
ALTER TABLE vc_VidCastTagList
ADD CONSTRAINT U1_vc_VidCastTagList UNIQUE (vc_TagID,vc_VidCastID)
GO
--End adding unique constraints to VidCastTagList table

--Creating the UserTagList table
CREATE TABLE vc_UserTagList (
	--Columns for the UserTagList table
	vc_UserTagListID int identity CONSTRAINT PK_vc_UserTagList PRIMARY KEY (vc_UserTagListID),
	vc_TagID int not null CONSTRAINT FK1_vc_UserTagList FOREIGN KEY (vc_TagID) REFERENCES vc_Tag(vc_TagID),
	vc_UserID int not null CONSTRAINT FK2_vc_UserTagList FOREIGN KEY (vc_UserID) REFERENCES vc_User(vc_UserID)
)
GO
--End Creating the UserTagList table

--Add unique constraints on UserTagList table
ALTER TABLE vc_UserTagList
ADD CONSTRAINT U1_vc_UserTagList UNIQUE (vc_TagID,vc_UserID)
GO
--End adding unique constraints to UserTagList table
	

