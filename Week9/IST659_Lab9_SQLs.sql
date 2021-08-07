USE [IST659_M406_srajendi]
GO

/*
	Title	:	Lab 09 - Data Security - SQL Scripts
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	March 2020


****************** 1 - Securing Data Objects *************************/

/* Creating a Database User   


1. Creating a guestuser database user       */

-- Check SQL Server Login
IF SUSER_ID('guestuser') IS NULL
    CREATE LOGIN guestuser WITH PASSWORD = 'SU2orange!';

-- Check database user
IF USER_ID('guestuser') IS NULL
    CREATE USER guestuser FOR LOGIN guestuser;


/*
2. Login as guestuser to query the database */

--- First SQL Querying for guestuser

Select * from dbo.vc_User   --- fails as object level access not been granted yet.



/* Managing user permissions

2. Grant user guestuser READ permission to the dbo.vc_User TABLE */

    GRANT SELECT ON dbo.vc_User to guestuser

/*
3. Revoke the Select permission to the user guestuser on dbo.vc_User TABLE */

    REVOKE SELECT ON dbo.vc_User to guestuser
/*
4. Grant user guestuser READ permission to the VIEW dbo.vc_MostProlificUsers */

    GRANT SELECT ON dbo.vc_MostProlificUsers to guestuser

/*
4. Allow user guestuser EXECUTE permission to the STORED PROCEDURES */

    GRANT EXECUTE ON dbo.vc_AddUserLogin to guestuser
    GRANT EXECUTE ON dbo.vc_FinishVidCast to guestuser

    GRANT SELECT ON dbo.vc_VidCast to guestuser


/*
    EXECUTE the STORED PROCEDURES on guestuser tab

5.  Execute Stored Procedure to Add records to vc_UserLogin table  */

    EXEC dbo.vc_AddUserLogin 'TheDoctor','Gallifrey'
/*

6.  Execute Stored Procedure to Update vc_VidCast table  */

    IF EXISTS( select distinct VidCastTitle from dbo.vc_VidCast where VidCastTitle ='Rock Your Way To Success')
        BEGIN
            
            DECLARE @vc_VidCastID int
            Select @vc_VidCastID =  vc_VidCastID from dbo.vc_VidCast where VidCastTitle ='Rock Your Way To Success'
            ---Print @vc_VidCastID
            EXEC vc_FinishVidCast @vc_VidCastID
        END
  
/* Retrive  records 

7. Select all records from dbo.vc_UserLogin table   */
    
    SELECT * from dbo.vc_UserLogin

/*  

8.  Select all modified records from vc_VidCast by guestuser */

    Select * from dbo.vc_VidCast where VidCastTitle ='Rock Your Way To Success'

/******* Part 2: Data Intergrity through Transactions*/

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='lab_Test')
	BEGIN
		DROP TABLE lab_Test
	END
	GO

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='lab_Log')
	BEGIN
		DROP TABLE lab_Log
	END
	GO

-----Creating the lab_Test table

	CREATE TABLE lab_Test (
		--Columns for the lab_Test table
		lab_TestID int identity PRIMARY KEY,
		lab_TestText varchar(20) not null CONSTRAINT U1_lab_Test UNIQUE (lab_TestText)
	)
	GO

-----Creating the lab_Log table
    ---- This table will keep a log of created lab_Test records.
    ---- We dont want to add new records if thier insert fails into lab_Test table.

	CREATE TABLE lab_Log (
		--Columns for the lab_Log table
		lab_LogID int identity PRIMARY KEY,
		lab_TestInt int not null CONSTRAINT U1_lab_Log UNIQUE (lab_TestInt)
	)
GO


----Adding Data to lab_Test & lab_Log tables
	INSERT INTO lab_Test(lab_TestText)
		VALUES
			('One'),('Two'),('Three')
	GO

    INSERT INTO lab_Log(lab_TestInt)
	SELECT lab_TestID
	From dbo.lab_Test 
	GO
BEGIN TRY

    BEGIN TRANSACTION
            ----Step 2: Assess the state of the things
            Declare @rc int
            SET @rc = @@ROWCOUNT  --Intitially 0

            ----Step 3: Make the change
            ----On Success, @@ROWCOUNT is incremented by 1
            ----On Failure, @@ROWCOUNT does not change

            INSERT INTO lab_Test(lab_TestText)
            VALUES
                ('One')
            
            ----Step 4: Check the new state of things
            IF ( @rc = @@ROWCOUNT) ---If @@ROWCOUNT was not changed , fail
            BEGIN
                ----Step 5, if failed
                SELECT 'Bail out! It Failed!'
                ROLLBACK
            END
            ELSE ----Success! Continue.
            BEGIN
                ----Step 5, if Succeeded
                SELECT 'Yay! It Worked!'
                INSERT INTO lab_Log(lab_TestInt) VALUES (@@identity)
                COMMIT
    END
END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION
    SELECT 'Bail out! It Failed!'
END CATCH

    SELECT * FROM lab_Log go;
    SELECT * FROM lab_Test go;

USE [IST659_M406_srajendi]
GO

/*
	Title	:	Lab 09 - Data Security - SQL Scripts
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	March 2020

	User	:	AD\srajendi / Windows Authentication AD User


****************** 1 - Securing Data Objects *************************/

/* Creating a Database User   

1. Creating a guestuser database user       */

-- Check SQL Server Login
	IF SUSER_ID('guestuser') IS NULL
    CREATE LOGIN guestuser WITH PASSWORD = 'SU2orange!';

-- Check database user
	IF USER_ID('guestuser') IS NULL
    CREATE USER guestuser FOR LOGIN guestuser;

/* Managing user permissions
2. Grant user guestuser READ permission to the dbo.vc_User TABLE */
    GRANT SELECT ON dbo.vc_User to guestuser

/*
3. REVOKE  guestuser's access from dbo.vc_User TABLE */
    REVOKE SELECT ON dbo.vc_User to guestuser

/*	
4. Grant user guestuser READ permission to the dbo.vc_MostProlificUsers TABLE */
    GRANT SELECT ON dbo.vc_MostProlificUsers to guestuser

/*
5. Allow user guestuser EXECUTE permission to the STORED PROCEDURES */

    GRANT EXECUTE ON dbo.vc_AddUserLogin to guestuser
    GRANT EXECUTE ON dbo.vc_FinishVidCast to guestuser

	GRANT SELECT ON dbo.vc_VidCast to guestuser  -- to be able to set query valdiation; Optional statement included only to make the execute statement repeateable.

/* Retrive  records 

6. Select all records from dbo.vc_UserLogin table   */
   SELECT * from dbo.vc_UserLogin

/*  
7.  Select all modified records from vc_VidCast by guestuser */
    Select * from dbo.vc_VidCast where VidCastTitle ='Rock Your Way To Success'
/* REVOKE Permissions for guestuser on all objects
8.  REVOKE Permission on Strored Procedure, View and Tables */	

	REVOKE SELECT ON vc_MostProlificUsers to guestuser
	REVOKE SELECT ON vc_UserLogin to guestuser
	REVOKE EXECUTE ON vc_AddUserLogin TO guestuser
	REVOKE EXECUTE ON vc_FinishVidCast TO guestuser

	

/******* Part 2: Data Intergrity through Transactions*/

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='lab_Test')
	BEGIN
		DROP TABLE lab_Test
	END
	GO

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='lab_Log')
	BEGIN
		DROP TABLE lab_Log
	END
	GO

-----Creating the lab_Test table

	CREATE TABLE lab_Test (
		--Columns for the lab_Test table
		lab_TestID int identity PRIMARY KEY,
		lab_TestText varchar(20) not null CONSTRAINT U1_lab_Test UNIQUE (lab_TestText)
	)
	GO

-----Creating the lab_Log table
    ---- This table will keep a log of created lab_Test records.
    ---- We dont want to add new records if thier insert fails into lab_Test table.

	CREATE TABLE lab_Log (
		--Columns for the lab_Log table
		lab_LogID int identity PRIMARY KEY,
		lab_TestInt int not null CONSTRAINT U1_lab_Log UNIQUE (lab_TestInt)
	)
GO


----Adding Data to lab_Test & lab_Log tables
	INSERT INTO lab_Test(lab_TestText)
		VALUES
			('One'),('Two'),('Three')
	GO

    INSERT INTO lab_Log(lab_TestInt)
	SELECT lab_TestID
	From dbo.lab_Test 
	GO
	
BEGIN TRY
	BEGIN TRANSACTION
			Declare @rc int
			SET @rc = @@ROWCOUNT 

			IF  NOT EXISTS ( Select count(*) from dbo.lab_Test where lab_TestText ='srajendi' )
				BEGIN
				SET @rc = @@ROWCOUNT +1
				END
			INSERT into dbo.lab_Test(lab_TestText) VALUES('srajendi')
			
			----Step 4: Check the new state of things
			IF ( @rc = @@ROWCOUNT) ---If @@ROWCOUNT was not changed , fail
				BEGIN
					SELECT 'Bail out! It Failed!'
				    ROLLBACK
				END
			ELSE ----Success! Continue.
				BEGIN
					----Step 5, if Succeeded	
					SELECT 'Yay! It Worked!'
					INSERT INTO lab_Log(lab_TestInt) VALUES (@@identity)
					COMMIT
				END
END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION
    SELECT 'Bail out! It Failed!'
END CATCH


    SELECT * FROM lab_Log go;
    SELECT * FROM lab_Test go;



    USE [IST659_M406_srajendi]
    GO

    /*
        Title	:	Lab 09 - Data Security - SQL Scripts
        Author	:	Sathish Kumar Rajendiran
        Course	:	IST659	M406
        Term	:	March 2020

        User	:	guestuser / SQL User


    ****************** 1 - Securing Data Objects *************************/
    --- First SQL Querying for guestuser
    Select * from dbo.vc_User   ---- fails as object level access not been granted yet.

    --- After the GRANT statement on the vc_User's table for guestuser
    Select * from dbo.vc_User   ---- returns data from vc_User's table.

    --- After the REVOKE statement on the vc_User's table for guestuser
    Select * from dbo.vc_User   --- fails as object level access has been revoked.

    /*
    Msg 229, Level 14, State 5, Line 21
    The SELECT permission was denied on the object 'vc_User', database 'IST659_M406_srajendi', schema 'dbo'.
    */

    --- After the GRANT statement on the vc_MostProlificUsers's View for guestuser
    Select * from dbo.vc_MostProlificUsers   ---- returns data from vc_MostProlificUsers's view.


    /*
        EXECUTE the STORED PROCEDURES 

    Execute Stored Procedure to Add records to vc_UserLogin table  */
        EXEC dbo.vc_AddUserLogin 'TheDoctor','Gallifrey'
    /*
    Execute Stored Procedure to Update vc_VidCast table  */

        IF EXISTS( select distinct VidCastTitle from dbo.vc_VidCast where VidCastTitle ='Rock Your Way To Success')
            BEGIN
                
                DECLARE @vc_VidCastID int
                Select @vc_VidCastID =  vc_VidCastID from dbo.vc_VidCast where VidCastTitle ='Rock Your Way To Success'
                ---Print @vc_VidCastID
                EXEC vc_FinishVidCast @vc_VidCastID
            END

