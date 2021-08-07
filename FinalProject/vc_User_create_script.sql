/*
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	January, 2020
*/

--Creating the User table
CREATE TABLE vc_User (
	--Columns for the User table
	vc_userID int identity,
	UserName varchar(20) not null,
	EmailAddress varchar(50) not null,
	UserDescription varchar(200),
	WebSiteURL varchar(50),
	UserRegisteredDate datetime not null default GetDate(),
	--Constraints on the User Table
	CONSTRAINT PK_vc_User PRIMARY KEY (vc_UserID),
	CONSTRAINT U1_vc_User UNIQUE (UserName),
	CONSTRAINT U2_vc_User UNIQUE (EmailAddress)
)
--End Creating the User table
