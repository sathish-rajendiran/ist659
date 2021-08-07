USE [IST659_M406_srajendi]
GO

/*
	Title	:	Lab 08 - SQL Scripts
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	March 2020
		
*/  

 /*

**************************************************************************
				Introduction to Variables
example: 
    Declare a variable and return values respective to the parameter values
***************************************************************************
*/ 
 DECLARE @isThisNull varchar(30) -- Starts out as NULL
 
 SELECT 
	  @isThisNull as Value_of_Variable
	, ISNULL(@isThisNull, 'Yep, It is NULL') as Is_Result_NULL
 
---- Set the variable to something other than NULL
	 SET @isThisNull = 'Nope. It is not NULL'
 SELECT 
	  @isThisNull as Value_of_Variable
	, ISNULL(@isThisNull, 'Nope. It is not NULLl') as Is_Result_NULL 
 GO

/*

**************************************************************************
				Introduction to User Defined Functions
example: 
    Define a scalar function to Add 2 Integers
***************************************************************************
*/ 
----Function to Add 2 Integers
----Define Function
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='AddtwoInts')
BEGIN
	DROP FUNCTION AddtwoInts
END
GO

CREATE FUNCTION 
	dbo.AddtwoInts(@firstnumber int, @secondnumbr int)
RETURNS Int 
AS
 BEGIN
		--First, declare the variable to temporarily hold the results
		DECLARE @returnValue int  -- data type matches RETURN Value

		SET @returnValue=@firstnumber+@secondnumbr
		RETURN @returnValue
 END
GO
----Validate the function
	SELECT dbo.AddTwoInts(5, 10) as Sum_of_2_Numbers
	GO

/*

***************************************************************************
				Lab 8 - "Function"
To-Do: 
    1. Function to count the VidCasts made by a given User 
	2. Function to retrieve the vc_TagID for a given tag's text
****************************************************************************
*/ 
-----1. Function to count the VidCasts made by a given User
-----Define function to Count the VidCasts made by a given User

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='vc_VidCastCount')
BEGIN
	DROP FUNCTION vc_VidCastCount
END
GO

CREATE FUNCTION 
	dbo.vc_VidCastCount(@userid int)
RETURNS Int 
AS
 BEGIN
		DECLARE @returnValue int  -- data type matches RETURN Value
		/*
		Get the count of VidCasts for the provided UserID and assign that return value to variable @returnvalue.
		Note that we use @userid parameter in the WHERE clause to limit our count to that user's VidCast records
		*/
		Select @returnValue= COUNT(VC.vc_UserID) FROM vc_VidCast VC
		Where VC.vc_UserID = @userid

		--Return @returnvalue to the calling code
		RETURN @returnValue
 END
GO
----Validate the function
	SELECT TOP 10 
		  USR.*
		, dbo.vc_VidCastCount(USR.vc_UserID) as VidCastCount
	FROM dbo.vc_User USR
	ORDER BY VidCastCount Desc
	GO

-----2. Function to retrieve the vc_TagID for a given tag's text
-----Define Function to retrieve the vc_TagID for a given tag's text

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='vc_TagIDLookup')
BEGIN
	DROP FUNCTION vc_TagIDLookup
END
GO

CREATE FUNCTION 
	dbo.vc_TagIDLookup(@tagText varchar(20))
RETURNS Int 
AS
 BEGIN
		DECLARE @returnValue int  -- data type matches RETURN Value
		/*
		Get the vc_TagID of the vc_Tag record whose tagText matches the provided parameter and assign that return value to variable @returnvalue.
		*/
		Select @returnValue= vc_TagID FROM vc_Tag T
		Where T.TagText = @tagText

		--Return @returnvalue to the calling code
		RETURN @returnValue
 END
GO
----Validate the function
	SELECT dbo.vc_TagIDLookup ('Music') as vc_TagID
	SELECT dbo.vc_TagIDLookup ('Tunes') as vc_TagID
	GO
----View all records from vc_Tag to validate the above function results
	Select * FROM vc_Tag 
	Where TagText in ('Music','Tunes')

/*
***************************************************************************
				Lab 8 - "Views"
To Do: 
    1. Create a View to retrieve top 10 vc_Users and thier VidCast counts  
****************************************************************************
*/ 

-----1. Create a View to retrieve top 10 vc_Users and thier VidCast counts 
-----Define View 

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='vc_MostProlificUsers')
BEGIN
	DROP VIEW vc_MostProlificUsers
END
GO

CREATE VIEW dbo.vc_MostProlificUsers
AS
	SELECT TOP 10 
		  USR.*
		, dbo.vc_VidCastCount(USR.vc_UserID) as VidCastCount
	FROM dbo.vc_User USR
	ORDER BY VidCastCount Desc
GO

----Retrive values from the vc_MostProlificUsers View 

SELECT * FROM dbo.vc_MostProlificUsers
GO

/*
***************************************************************************
				Lab 8 - "Stored Procedures"
To Do: 
    1. Create a Procedure to update a vc_User's email address by passing 
	   two parameters
			i.e Username and Email Address
	2. @@identity - using this global variable in Stored Procedure
****************************************************************************
*/ 

-----To Do 1. Create a Procedure to update a vc_User's email address
-----Define Procedure
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='vc_ChangeUserEmail')
BEGIN
	DROP PROCEDURE vc_ChangeUserEmail
END
GO

CREATE PROCEDURE dbo.vc_ChangeUserEmail (@userName varchar(20),@newEmail varchar(50))
AS
BEGIN
	UPDATE  USR
		  SET USR.EmailAddress = @newEmail
	FROM dbo.vc_User USR
	WHERE USR.UserName=@userName
END
----Execute vc_ChangeUserEmail Stored procedure
EXEC dbo.vc_ChangeUserEmail 'tardy','kmstudent@syr.edu'
GO
----Retrive values from the vc_Users table
SELECT * FROM dbo.vc_User Where UserName ='tardy'
GO

-----To do 2. @@identity - using this global variable in Stored Procedure

IF (SELECT dbo.vc_TagIDLookup ('Cat Videos')) IS NULL

BEGIN
	INSERT INTO dbo.vc_Tag(TagText) Values ('Cat Videos')
	SELECT * FROM vc_Tag WHERE vc_TagID = @@IDENTITY
END

SELECT * FROM vc_Tag WHERE TagText ='Cat Videos'
GO

/*
To do 3. Create a procedure that adds row into UserLogin table
This procedure is run when a user logs in and we need to record
who they are and from where they're logged in.

*/
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='vc_AddUserLogin')
BEGIN
	DROP PROCEDURE vc_AddUserLogin
END
GO

CREATE PROCEDURE dbo.vc_AddUserLogin (@userName varchar(20),@loginFrom varchar(50))
AS
BEGIN
    --We have UserName but we need the ID for the Login table
	--First, decare a variable to hold the ID
	DECLARE @userID int

	--Get the vc_UserID for the UserName provided and store it in @userID
	SELECT @userID = USR.vc_UserID
	FROM dbo.vc_User USR
	WHERE USR.UserName=@userName

	--Now we can add the row using an INSERT Statement
	INSERT INTO dbo.vc_UserLogin(vc_UserID,LoginLocation)
	VALUES (@userID,@loginFrom)

	--Now return the @@identity so the calling code knows where the data ended up
	RETURN @@identity
END
GO

--select * from dbo.vc_UserLogin
--select * from dbo.vc_User
----Execute vc_AddUserLogin Stored procedure

DECLARE @addedvalue int

EXEC @addedvalue = dbo.vc_AddUserLogin 'tardy','localhost'

----Retrive values from the vc_Users table
SELECT 
	 USR.vc_UserID
	,USR.UserName
	,UL.UserLoginTimestamp
	,UL.LoginLocation
FROM dbo.vc_User USR
JOIN dbo.vc_UserLogin UL on USR.vc_UserID=UL.vc_UserID
Where UL.vc_UserLoginID=@addedvalue
GO

-----Alternative version of the above stored procedure
-- define the procedure
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='vc_AddUserLogin_v1')
BEGIN
	DROP PROCEDURE vc_AddUserLogin_v1
END
GO

CREATE PROCEDURE dbo.vc_AddUserLogin_v1 (@userName varchar(20),@loginFrom varchar(50))
AS
BEGIN
   
    --We have UserName but we need the ID for the Login table
    --Check if User is available in vc_Users table then get the UserID dynamically. We might as well create a function for this.   
    --LoginLocation is part of the variable
    --vc_UserLoginID is an identity value; so it can be retrived by calling @@identity global variable
    --LoginTimstamp has default value if its missing in the insert statement.
	IF (SELECT vc_UserID FROM dbo.vc_User WHERE UserName=@userName) IS NOT NULL
	BEGIN
		INSERT INTO dbo.vc_UserLogin(vc_UserID,LoginLocation)
		VALUES
		 ((SELECT vc_UserID FROM dbo.vc_User WHERE UserName=@userName), @loginFrom)
	END
	--- Select the recently added value.
	---if the existing Username doesnt not exist in the User table; then it returns the most recent value added in this session.
	SELECT * FROM dbo.vc_UserLogin WHERE vc_UserLoginID = @@IDENTITY

END
GO

----Execute vc_AddUserLogin_v1 Stored procedure
EXEC dbo.vc_AddUserLogin_v1 'camel8','localhost'

/*

***************************************************************************
				Part 2 - "Function"
To-Do: 
    1. Function to retrive vc_UserID for the given User 
	2. Function to calculate count of vc_VidCastIDs for a given vc_TagID
	3. Function to calculate VidCasts Counts
****************************************************************************
*/ 
----- 1.Function to retrieve the vc_UserID for a given UserName

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='vc_UserIDLookup')
BEGIN
	DROP FUNCTION vc_UserIDLookup
END
GO

CREATE FUNCTION 
	dbo.vc_UserIDLookup(@userName varchar(20))
RETURNS Int 
AS
 BEGIN
		DECLARE @returnValue int  -- data type matches RETURN Value
		/*
		Get the vc_UserID of the vc_User record whose userName matches the provided parameter and assign that return value to variable @returnvalue.
		*/
		Select @returnValue= vc_UserID FROM vc_User U
		Where U.UserName = @userName

		--Return @returnvalue to the calling code
		RETURN @returnValue
 END
GO
----Validate the function
	SELECT 'Trying the vc_UserIDLookup function.' as Label, dbo.vc_UserIDLookup('tardy') as vc_UserID
	SELECT 'Trying the vc_UserIDLookup function.' as Label, dbo.vc_UserIDLookup('sathish') as vc_UserID
	GO


-----2. Create a function that calculates the count of vc_VidCastIDs for a given vc_TagID

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='vc_TagVidCastCount')
BEGIN
	DROP FUNCTION vc_TagVidCastCount
END
GO

CREATE FUNCTION 
	dbo.vc_TagVidCastCount(@tagID int)
RETURNS Int 
AS
 BEGIN
		DECLARE @returnValue int  -- data type matches RETURN Value
		/*
		Get the count of VidCasts for the provided tagID and assign that return value to variable @returnvalue.
		Note that we use @@tagID parameter in the WHERE clause to limit our count to that user's vc_Tags records
		*/
		SELECT 
		 @returnValue = Count(VC.vc_VidCastID) 
		FROM vc_Tag T
		LEFT JOIN vc_VidCastTagList VCT ON T.vc_TagID=VCT.vc_TagID
		LEFT JOIN vc_VidCast VC on VC.vc_VidCastID=VCT.vc_VidCastID
		Where T.vc_TagID = @tagID
		Order by Count(VC.vc_VidCastID)  desc
		--Return @returnvalue to the calling code
		RETURN @returnValue
 END
GO
----Validate the function
	 SELECT
	  TagText
     , dbo.vc_TagVidCastCount(vc_TagID) as VidCasts
     FROM dbo.vc_Tag



-----3. Function to calculate the VidCast duration as a number of minutes for each individual vc_VidCast record 

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='vc_VidCastDuration')
BEGIN
	DROP FUNCTION vc_VidCastDuration
END
GO

CREATE FUNCTION 
	dbo.vc_VidCastDuration(@userID int)
RETURNS Int 
AS
 BEGIN
		DECLARE @returnValue int  -- data type matches RETURN Value
		/*
		Calculate the count of vc_VidCastIDs for a given vc_TagID and assign that return value to variable @returnvalue.
		Note that we use @@tagID parameter in the WHERE clause to limit our count
		*/
		SELECT  
			@returnValue=Sum(DateDiff(n,StartDatetime,EndDateTime)) 
		FROM dbo.vc_VidCast as VidCast
		Join dbo.vc_User as USR ON USR.vc_UserID=VidCast.vc_UserID
		Where USR.vc_UserID = @userID

		--Return @returnvalue to the calling code
		RETURN @returnValue
 END
GO
----Validate the function
		SELECT *
		, dbo.vc_VidCastDuration(vc_UserID) as TotalMinutes
		FROM dbo.vc_User

		
/*
***************************************************************************
				Part2 - "Views"
To Do: 
    1. Create a view called vc_TagReport 
	2. Modify vc_MostProlificUsers view
****************************************************************************
*/ 

-----1. Create a view called vc_TagReport
-----Define View 

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='vc_TagReport')
BEGIN
	DROP VIEW vc_TagReport
END
GO

CREATE VIEW dbo.vc_TagReport
AS
	 SELECT T.TagText
		,dbo.vc_TagVidCastCount(vc_TagID) as VidCasts
	FROM  dbo.vc_Tag T
	
 GO

----Retrive values from the vc_TagReport View 

	SELECT * FROM dbo.vc_TagReport
	Order by VidCasts desc
	GO

-----2. Alter the vc_MostProlificUsers View to include TotalMinutes that calls the vc_VidCastDuration function
-----Modify View 

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='vc_MostProlificUsers')
BEGIN
	EXECUTE('CREATE VIEW dbo.vc_MostProlificUsers
			 AS
			SELECT TOP 10 
					USR.*
				, dbo.vc_VidCastCount(USR.vc_UserID) as VidCastCount
				, dbo.vc_VidCastDuration(USR.vc_UserID) as TotalMinutes
			FROM dbo.vc_User USR
			ORDER BY VidCastCount Desc')
END
GO

ALTER VIEW dbo.vc_MostProlificUsers
AS
	SELECT TOP 10 
		  USR.*
		, dbo.vc_VidCastCount(USR.vc_UserID) as VidCastCount
		, dbo.vc_VidCastDuration(USR.vc_UserID) as TotalMinutes
	FROM dbo.vc_User USR
	ORDER BY VidCastCount Desc
GO
----Retrive values from the vc_MostProlificUsers View 

SELECT UserName, VidCastCount, TotalMinutes 
FROM vc_MostProlificUsers
GO

/*
*********************************
Part 2  - Stored Procedures
*********************************
*/

/*
Create a procedure to add a new Tag to the database
Inputs: 
@tagText : The text of the new tag
@description : a brief description of the tag (nullable)

Returns: @@identity with the value inserted

*/
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='vc_AddTag')
BEGIN
	DROP PROCEDURE vc_AddTag
END
GO

CREATE PROCEDURE dbo.vc_AddTag (@tagText varchar(20),@description varchar(100)=NULL)
AS

IF NOT EXISTS( SELECT * FROM dbo.vc_Tag WHERE TagText = @tagText)
	BEGIN
     
		--Now we can add the row using an INSERT Statement
		INSERT INTO dbo.vc_Tag(TagText,TagDescription)
		VALUES (@tagText,@description);
		RETURN @@IDENTITY
	END

ELSE
	
	--BEGIN
	--	SELECT  * FROM dbo.vc_Tag Where TagText = @tagText	
	----Now return the @@identity so the calling code knows where the data ended up
	--END

	RETURN (SELECT vc_TagID FROM dbo.vc_Tag Where TagText = @tagText)

GO

----Execute vc_AddTag Stored procedure

DECLARE @newTagID int

EXEC @newTagID = dbo.vc_AddTag 'SQL','Finally, a SQL Tag'

----Retrive values from the vc_Tag table
SELECT 
	 *
FROM dbo.vc_Tag
Where vc_TagID = @newTagID
GO


/*
Create a procedure that accepts vc_VidCastID and update its status as "Finished"; meaning  change its EndDateTime to be the current Date and Time
Input: 
@vidCastID : int parameter

Outputs:
vc_StatusID  --> to have the respective StatusID for "Finished"Status
EndDateTime  --> Getdate()

Returns: @@identity with the value inserted

*/
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='vc_FinishVidCast')
BEGIN
	DROP PROCEDURE vc_FinishVidCast
END
GO

CREATE PROCEDURE dbo.vc_FinishVidCast (@vidCastID int)
AS
BEGIN
    
	UPDATE VC
	SET 
	 VC.vc_StatusID = (SELECT vc_StatusID FROM vc_Status WHERE StatusText='Finished')
	,VC. EndDateTime = GETDATE()
	FROM dbo.vc_VidCast VC
	Where VC.vc_VidCastID= @vidCastID
	
	--Now return the @@identity so the calling code knows where the data ended up
	RETURN @@identity
END
GO

----Execute vc_FinishVidCast Stored procedure


DECLARE @newVC int

INSERT INTO dbo.vc_VidCast 
(VidCastTitle, StartDateTime, ScheduleDurationMinutes, vc_UserID,vc_StatusID)
VALUES (
 'Finally done with sprocs'
, DATEADD(n, -45, GETDATE())
, 45
, (SELECT vc_UserID FROM vc_User WHERE UserName = 'tardy')
, (SELECT vc_StatusID FROM vc_Status WHERE StatusText='Started')
 )
 SET @newVC = @@identity

 SELECT * FROM vc_VidCast WHERE vc_VidCastID = @newVC

 EXEC vc_FinishVidCast @newVC
 EXEC vc_FinishVidCast @newVC
 
 SELECT * FROM vc_VidCast WHERE vc_VidCastID = @newVC





