USE [IST659_M406_srajendi]
GO

/*****************************************************************************************************

	Title	:	WikiChannel - Main Project
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	March, 2020
	
	Database Name: IST659_M406_srajendi

	SQL Objects:

		Tables: (In the Order of DROP Sequence) - Primary is available on All Tables
			1. dbo.w_Author_Followers  			| FKey Contraints:  2    UKey Contraints: 1 (Composite)
			2. dbo.w_Channel_User_Activity		| FKey Contraints:  3    UKey Contraints: 1 (Composite)
			3. dbo.w_Channel_Articles			| FKey Contraints:  2    UKey Contraints: 1
			4. dbo.w_Channel_Authors			| FKey Contraints:  2    UKey Contraints: 1
			5. dbo.w_Channel_Users				| FKey Contraints:  0    UKey Contraints: 2
			6. dbo.w_Article_Category			| FKey Contraints:  0    UKey Contraints: 1
			7. dbo.w_Author_Social_Profile		| FKey Contraints:  0    UKey Contraints: 1
			8. dbo.w_Author_Tier_Level			| FKey Contraints:  0    UKey Contraints: 1
			9. dbo.w_Channel_VisitorType		| FKey Contraints:  0    UKey Contraints: 1
		
		Views: 
			1. dbo.w_vw_Most_Viewed_Articles_by_Category  			
			2. dbo.w_vw_Authors_by_TierLevel		
			3. dbo.w_vw_Nbr_Of_Articles_by_Category			
			4. dbo.w_vw_Top_5_Viewers			
			5. dbo.w_vw_Topline_Contributors				
			6. dbo.w_vw_YTD_Articles_Trend		
			7. dbo.w_vw_QTD_Articles_Trend		
			8. dbo.w_vw_Monthly_Articles_Trend			
			9. dbo.w_vw_Daily_Published_vs_Viewed_Trend		

		Functions:
			1. dbo.w_fn_UserIDLookup
			2. dbo.w_fn_AuthorIDLookup
			3. dbo.w_fn_FindDateSince
			4. dbo.w_fn_DoesSubscriberExist
			5. dbo.w_fn_CategoryIDLookup
			6. dbo.w_fn_ArticleIDLookup
			7. dbo.w_fn_VisitorTypeIDLookup
		
		Stored Procedures:
			1. dbo.w_sp_AddAuthors
			2. dbo.w_sp_AddAuthorFollowers
			3. dbo.w_sp_AddArticles
			4. dbo.w_sp_AddUserActivity
			5. dbo.w_sp_Update_Tier_Level
			6. dbo.w_sp_Update_Author_TierLevel


			Additional Stored Procedures for BULK Data Entry
			1. dbo.w_sp_AddAuthorFollowers_BULK
			2. dbo.w_sp_AddArticles_BULK
			3. dbo.w_sp_AddUserActivitys_BULK

**********************************************************************************************************

************************   Real Fun Begins   *************************************************************

**********************************************************************************************************
							Drop all user tables if exist
*********************************************************************************************************/

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='w_Author_Followers')
	BEGIN
		DROP TABLE w_Author_Followers
	END
	GO

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='w_Channel_User_Activity')
	BEGIN
		DROP TABLE w_Channel_User_Activity
	END
	GO

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='w_Channel_Articles')
	BEGIN
		DROP TABLE w_Channel_Articles
	END
	GO

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='w_Channel_Authors')
	BEGIN
		DROP TABLE w_Channel_Authors
	END
	GO

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='w_Channel_Users')
	BEGIN
		DROP TABLE w_Channel_Users
	END
	GO

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='w_Article_Category')
	BEGIN
		DROP TABLE w_Article_Category
	END
	GO

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='w_Author_Social_Profile')
	BEGIN
		DROP TABLE w_Author_Social_Profile
	END
	GO

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='w_Author_Tier_Level')
	BEGIN
		DROP TABLE w_Author_Tier_Level
	END
	GO

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='w_Channel_VisitorType')
	BEGIN
		DROP TABLE w_Channel_VisitorType
	END
	GO


/*************************************************************************************************************
						Time to Create all the Tables needed for this Project

		Tables: (In the Order of DROP Sequence) - Primary is available on All Tables
			1. dbo.w_Author_Followers  			| FKey Contraints:  2    UKey Contraints: 1 (Composite)
			2. dbo.w_Channel_User_Activity		| FKey Contraints:  3    UKey Contraints: 1 (Composite)
			3. dbo.w_Channel_Articles			| FKey Contraints:  2    UKey Contraints: 1
			4. dbo.w_Channel_Authors			| FKey Contraints:  2    UKey Contraints: 1
			5. dbo.w_Channel_Users				| FKey Contraints:  0    UKey Contraints: 2
			6. dbo.w_Article_Category			| FKey Contraints:  0    UKey Contraints: 1
			7. dbo.w_Author_Social_Profile		| FKey Contraints:  0    UKey Contraints: 1
			8. dbo.w_Author_Tier_Level			| FKey Contraints:  0    UKey Contraints: 1
			9. dbo.w_Channel_VisitorType		| FKey Contraints:  0    UKey Contraints: 1
**************************************************************************************************************

***********************   Table Creation - Begins  ***********************************************************/

----- Creating the User table
	----- This Table hosts all User information
	----- Both Author and User Profile is managed here; Boolean Flag to differentiate User Type
	----- UserName and EmailAddress are expected to have Unique values

	CREATE TABLE w_Channel_Users (
		--Columns for the User table
		UserID int identity CONSTRAINT PK_w_Channel_Users PRIMARY KEY (UserID),
		UserName varchar(40) not null CONSTRAINT U1_w_Channel_Users UNIQUE (UserName),
		EmailAddress varchar(50) not null CONSTRAINT U2_w_Channel_Users UNIQUE (EmailAddress),
		FirstName varchar(20),
		LastName varchar(20),
		State varchar(20),
		City varchar(50),
		DateCreated datetime not null default GetDate(),
		IsAuthor bit not null default 'true'
	)
	GO
-----End Creating the User table

-----Creating the w_Article_Category table
	----- This Table hosts Category Type of an Article
	----- CategoryName expected to have Unique value

	CREATE TABLE w_Article_Category (
		--Columns for the w_Article_Category table
		CategoryID int identity CONSTRAINT PK_w_Article_Category PRIMARY KEY (CategoryID),
		CategoryName varchar(50) not null CONSTRAINT U1_w_Article_Category UNIQUE (CategoryName),
		Description varchar(100) 
	)
	GO
-----End Creating the w_Article_Category table


-----Creating the w_Author_Social_Profile table
	----- This Table hosts Social Profile Values of Author
	----- ProfileName expected to have Unique value

	CREATE TABLE w_Author_Social_Profile (
		--Columns for the w_Author_Social_Profile table
		ProfileID int identity CONSTRAINT PK_w_Author_Social_Profile PRIMARY KEY (ProfileID),
		ProfileName varchar(50) not null CONSTRAINT U1_w_Author_Social_Profile UNIQUE (ProfileName),
		Description varchar(100) 
	)
	GO
-----End Creating the w_Author_Social_Profile table

---Creating the w_Author_Tier_Level table
	----- This Table hosts TierLevel Information for Authors based on the followers count
	----- TierLevelName expected to have Unique value

	CREATE TABLE w_Author_Tier_Level (
		--Columns for the w_Author_Tier_Level table
		TierLevelID int identity CONSTRAINT PK_w_Author_Tier_Level PRIMARY KEY (TierLevelID),
		TierLevelName varchar(50) not null CONSTRAINT U1_w_Author_Tier_Level UNIQUE (TierLevelName),
		Minimum_Followers varchar(100) 
	)
	GO
---End Creating the w_Author_Tier_Level table

---Creating the w_Channel_VisitorType table
	----- This Table hosts Various User Classification Who access this WikiChannel
	----- VisitorTypeName expected to have Unique value

	CREATE TABLE w_Channel_VisitorType (
		--Columns for the w_Channel_VisitorType table
		VisitorTypeID int identity CONSTRAINT PK_w_Channel_VisitorType PRIMARY KEY (VisitorTypeID),
		VisitorTypeName varchar(50) not null CONSTRAINT U1_w_Channel_VisitorType UNIQUE (VisitorTypeName),
		Description varchar(100) 
	)
	GO
---End Creating the w_Channel_VisitorType table

-----Creating the w_Channel_Authors table
	----- This Table hosts Authors into thier respective table allowing them segmented by Tiers
	----- This Table has Foreign key references to w_Channel_Users & w_Author_Tier_Level tables
	----- UserID expected to have Unique Constraint thus avoiding duplicate Author profiles getting created

	CREATE TABLE w_Channel_Authors(
		--Columns for the w_Channel_Authors table
		AuthorID int identity CONSTRAINT PK_w_Channel_Authors PRIMARY KEY (AuthorID),
		UserID int not null CONSTRAINT FK1_w_Channel_Authors FOREIGN KEY (UserID) REFERENCES w_Channel_Users(UserID),
		TierLevelID int not null CONSTRAINT FK2_w_Channel_Authors FOREIGN KEY (TierLevelID) REFERENCES w_Author_Tier_Level(TierLevelID) default 1
	)
	GO

	----Add unique constraints on w_Channel_Authors table
	ALTER TABLE w_Channel_Authors
	ADD CONSTRAINT U1_w_Channel_Authors UNIQUE (UserID)
	GO

-----End Creating the w_Channel_Authors table

-----Creating the w_Channel_Articles table
	----- This Table hosts information about All Articles posted in WikiChannel
	----- This Table has Foreign key references to w_Channel_Authors & w_Article_Category tables
	----- ArticleName expected to have Unique value

	CREATE TABLE w_Channel_Articles (
		--Columns for the w_Channel_Articles table
		ArticleID int identity CONSTRAINT PK_w_Channel_Articles PRIMARY KEY (ArticleID),
		ArticleName varchar(100) not null CONSTRAINT U1_w_Channel_Articles UNIQUE (ArticleName),
		Description varchar(100),
		DatePublished datetime not null default GetDate(),
		LastModifiedOn datetime,
		AuthorID int not null CONSTRAINT FK1_w_Channel_Articles FOREIGN KEY (AuthorID) REFERENCES w_Channel_Authors(AuthorID),
		CategoryID int not null CONSTRAINT FK2_w_Channel_Articles FOREIGN KEY (CategoryID) REFERENCES w_Article_Category(CategoryID),
		ReferenceURL varchar(100)
	)
	GO
-----End Creating the w_Channel_Articles table

-----Creating the w_Channel_User_Activity table
	----- This Table hosts information about various articles user may have viewed over time 
	----- This Table has Foreign key references to w_Channel_Users,w_Channel_Articles & w_Channel_VisitorType tables
	----- This table also contains a composite key to avoid duplicates.

	CREATE TABLE w_Channel_User_Activity (
		--Columns for the w_Channel_User_Activity table
		UserActivityID int identity CONSTRAINT PK_w_Channel_User_Activity PRIMARY KEY (UserActivityID),
		UserID int not null CONSTRAINT FK1_w_Channel_User_Activity FOREIGN KEY (UserID) REFERENCES w_Channel_Users(UserID),
		ArticleID int not null CONSTRAINT FK2_w_Channel_User_Activity FOREIGN KEY (ArticleID) REFERENCES w_Channel_Articles(ArticleID),
		VisitorTypeID int not null CONSTRAINT FK3_w_Channel_User_Activity FOREIGN KEY (VisitorTypeID) REFERENCES w_Channel_VisitorType(VisitorTypeID),
		DateTimeViewedOn datetime not null default GetDate(),
		Page_Time_In_Minutes int
	)
	GO

	----Add unique constraints on w_Channel_Authors table
	ALTER TABLE w_Channel_User_Activity
	ADD CONSTRAINT U1_w_Channel_User_Activity UNIQUE (UserID,ArticleID,VisitorTypeID,DateTimeViewedOn,Page_Time_In_Minutes)
	GO


-----End Creating the w_Channel_User_Activity table

-----Creating the w_Author_Followers table
	----- This Table hosts information about Users for differnt authors of thier interest
	----- This Table has Foreign key references to w_Channel_Users,w_Channel_Authors tables
	----- This table also has a Composite key on UserID and AuthorID Combination to avoid duplicates

	CREATE TABLE w_Author_Followers(
		--Columns for the w_Author_Followers table
		FollowerID int identity CONSTRAINT PK_w_Author_Followers PRIMARY KEY (FollowerID),
		UserID int not null CONSTRAINT FK1_w_Author_Followers FOREIGN KEY (UserID) REFERENCES w_Channel_Users(UserID),
		AuthorID int not null CONSTRAINT FK2_w_Author_Followers FOREIGN KEY (AuthorID) REFERENCES w_Channel_Authors(AuthorID),
		DateSince datetime not null default GetDate()
	)
	GO

	-----Add unique constraints on w_Author_Followers table
	ALTER TABLE w_Author_Followers
	ADD CONSTRAINT U1_w_Author_Followers UNIQUE (UserID,AuthorID)
	GO

-----End Creating the w_Author_Followers table

/* **********************   Lets See if the Tables have been Created   *********************************  */

-----Simple Select Statements to find recourd count 
	Select count(*) as w_Author_Tier_Level from w_Author_Tier_Level GO;
	Select count(*) as w_Author_Social_Profile From dbo.w_Author_Social_Profile GO;
	Select count(*) as w_Channel_VisitorType from w_Channel_VisitorType GO;
	Select count(*) as w_Article_Category From dbo.w_Article_Category GO;
	Select count(*) as w_Channel_Users From dbo.w_Channel_Users GO;
	Select count(*) as w_Channel_Authors from w_Channel_Authors Go;
	Select count(*) as w_Channel_Articles from w_Channel_Articles GO;
	Select count(*) as w_Channel_User_Activity from w_Channel_User_Activity Go;
	Select count(*) as w_Author_Followers from w_Author_Followers Go;

/*-----Yeah - You're right; 0 records means, No data is available yet.

---Now that Tables are created, lets see what they got them; Look to see if all table has all fields as expected

	Select * from w_Author_Tier_Level GO;
	Select * from w_Author_Social_Profile GO;
	Select * from w_Channel_VisitorType GO;
	Select * from w_Article_Category Go;
	Select * from w_Channel_Users GO;
	Select *  from w_Channel_Authors Go;
	Select * from w_Author_Followers Go;
	Select * from w_Channel_Articles Go;
	Select * from w_Channel_User_Activity Go;

-----End of smoke testing 

************************   Table Creation - Ends  ***********************************************************

***************************************************************************************************************
							Data Entry - Phase I 
		Objective:
				> Insert data into tables that doesnt have any Foreign Key Constraints on them

		Tables in Scope:
			1. dbo.w_Author_Tier_Level				
			2. dbo.w_Author_Social_Profile			
			3. dbo.w_Article_Category		
			4. dbo.w_Channel_VisitorType			
			5. dbo.w_Channel_Users		
***************************************************************************************************************

***************************	Data Entry - Phase I - Begins  ****************************************************/

----Adding Data to the w_Author_Tier_Level table
	INSERT INTO w_Author_Tier_Level(TierLevelName,Minimum_Followers)
		VALUES
			('Bronze','0 to 9'),
			('Silver','10 to 24'),
			('Gold','25 to 49'),
			('Platinum','50 to 74'),
			('Diamond','75 and above')
	GO

----Adding Data to the w_Author_Social_Profile table
	INSERT INTO w_Author_Social_Profile(ProfileName,Description)
		VALUES
			('LinkedIn','LinkedIn Profile info'),
			('Facebook','Link to Facebook Page'),
			('Twitter','Twitter feed info')
	GO
----Adding Data to the w_Article_Category table
	INSERT INTO w_Article_Category(CategoryName,Description)
		VALUES
			('Database Management','Covers Articles including various Database management tools, concepts, best practices etc.'),
			('Business Intelligence','Covers Articles on Business Intelligence'),
			('Datascience','Covers Articles on DataScience tools, technology, ML and AI landscape'),
			('Information Security','Covers Articles on Need for Data and Information security, Compliance Policies'),
			('Data Analysis','Covers Articles on DMAIC Framework, Hypothesis Testing, Control Flow, Time Series Analysis etc.'),
			('UnAssigned','Un Assigned category - either new category creation or possible update required')
	GO
----Adding Data to the w_Channel_VisitorType table
	INSERT INTO w_Channel_VisitorType(VisitorTypeName,Description)
		VALUES
			('SiteAdmin','Site Level Access'),
			('PageAdmin','Page Level Access'),
			('Subscriber','Valid User - Subscribed to Articles'),
			('Author','Publisher/Author'),
			('Viewer','View Level Access')
	GO
-----Adding Data to the w_Channel_Users table
	----Populate Authors data first
	INSERT INTO w_Channel_Users(UserName,EmailAddress,FirstName,LastName,State,City,DateCreated,IsAuthor)
		VALUES
			('Chris.Evans','Chris.Evans@nomail.com','Chris','Evans','Alabama','Brook Highland','10/12/2019','true')
			,('Mark.Ruffalo','Mark.Ruffalo@nomail.com','Mark','Ruffalo','Alabama','Theodore','10/17/2019','true')
			,('Jeremy.Renner','Jeremy.Renner@nomail.com','Jeremy','Renner','Alabama','Meridianville','1/18/2019','true')
			,('Tom.Hill','Tom.Hill@nomail.com','Tom','Hill','Alabama','Grayson Valley','1/19/2019','true')
			,('Girish.Dengi','Girish.Dengi@nomail.com','Girish','Dengi','Alabama','Pine Level','1/23/2019','true')
			,('Kaushlendra.Pandey','Kaushlendra.Pandey@nomail.com','Kaushlendra','Pandey','Arizona','Catalina Foothills','2/5/2019','true')
			,('Keyurkumar.Bhat','Keyurkumar.Bhat@nomail.com','Keyurkumar','Bhat','Arizona','Sun City','2/6/2019','true')
			,('Mahesh.Nayak','Mahesh.Nayak@nomail.com','Mahesh','Nayak','Arizona','Green Valley','2/11/2019','true')
			,('Mamata.Puswar','Mamata.Puswar@nomail.com','Mamata','Puswar','Arizona','Rio Rico','2/12/2019','true')
			,('Clark.Gregg','Clark.Gregg@nomail.com','Clark','Gregg','Arizona','Tucson Estates','3/11/2019','true')
			,('Brett.Dalton','Brett.Dalton@nomail.com','Brett','Dalton','California','San Francisco','3/15/2019','true')
			,('Emilia.Clarke','Emilia.Clarke@nomail.com','Emilia','Clarke','California','Fremont','4/26/2019','true')
			,('Kit.Harington','Kit.Harington@nomail.com','Kit','Harington','California','Irvine','5/31/2019','true')
			,('Sophie.Turner','Sophie.Turner@nomail.com','Sophie','Turner','California','San Bernardino','6/7/2019','true')
			,('Maisie.Williams','Maisie.Williams@nomail.com','Maisie','Williams','California','Modesto','7/15/2019','true')
			,('Peter.Dinklage','Peter.Dinklage@nomail.com','Peter','Dinklage','Arizona','Anthem','7/16/2019','true')
			,('Lena.Headley','Lena.Headley@nomail.com','Lena','Headley','Arizona','Green Valley','11/5/2019','true')
			,('Nikolaj.Costa','Nikolaj.Costa@nomail.com','Nikolaj','Costa','Arizona','Rio Rico','1/16/2020','true')
			,('Isaac.Hemstad','Isaac.Hemstad@nomail.com','Isaac','Hemstad','Alabama','Forestdale','10/15/2019','true')
			,('Gwen.Christie','Gwen.Christie@nomail.com','Gwen','Christie','Alabama','Meadowbrook','1/21/2019','true')
			,('Iain.Glen','Iain.Glen@nomail.com','Iain','Glen','Alabama','Brook Highland','2/12/2019','true')
			,('Nathalie.Emmanuel','Nathalie.Emmanuel@nomail.com','Nathalie','Emmanuel','Alabama','Theodore','3/9/2019','true')
			,('Alfie.Allen','Alfie.Allen@nomail.com','Alfie','Allen','Alabama','Meridianville','3/15/2019','true')
			,('Carice.Houten','Carice.Houten@nomail.com','Carice','Houten','Missouri','Independence','7/14/2019','true')
			,('Conleth.Hill','Conleth.Hill@nomail.com','Conleth','Hill','Missouri','Lee''s Summit','9/15/2019','true')
			,('John.Bradley','John.Bradley@nomail.com','John','Bradley','California','Oakland','1/14/2020','true')
			,('Rory.Meccan','Rory.Meccan@nomail.com','Rory','Meccan','California','Bakersfield','5/30/2019','true')
			,('Liam.Cunningham','Liam.Cunningham@nomail.com','Liam','Cunningham','California','San Jose','5/31/2019','true')
			,('Aidan.Gillan','Aidan.Gillan@nomail.com','Aidan','Gillan','California','San Francisco','6/1/2019','true')
			,('Jerome.Flynn','Jerome.Flynn@nomail.com','Jerome','Flynn','California','Fresno','06/02/2019','true')
	GO

-----Adding Data to the w_Channel_Users table
	INSERT INTO w_Channel_Users(UserName,FirstName,LastName,EmailAddress,State,City,DateCreated,IsAuthor)
		VALUES
			('Amitesh.Kumar','Amitesh','Kumar','Amitesh.Kumar@nomail.com','Alabama','Tillmans Corner','10/12/2019',0)
			,('Anjali.Baranwal','Anjali','Baranwal','Anjali.Baranwal@nomail.com','Alabama','Saks','10/13/2019',0)
			,('Anshuman.Mishra','Anshuman','Mishra','Anshuman.Mishra@nomail.com','Alabama','Forestdale','10/14/2019',0)
			,('Scarlett.Johnson','Scarlett','Johnson','Scarlett.Johnson@nomail.com','Alabama','Meadowbrook','10/15/2019',0)
			,('Deepthi.Kumar','Deepthi','Kumar','Deepthi.Kumar@nomail.com','Alabama','Moores Mill','01/20/2019',0)
			,('Dhanasekara.Pandian','Dhanasekara','Pandian','Dhanasekara.Pandian@nomail.com','Alabama','Harvest','01/21/2019',0)
			,('Fathima.Zahera','Fathima','Zahera','Fathima.Zahera@nomail.com','Alabama','Fort Rucker','01/22/2019',0)
			,('Jai.Ganesh','Jai','Ganesh','Jai.Ganesh@nomail.com','Alabama','Holtville','01/24/2019',0)
			,('Joseph.Gonsalves','Joseph','Gonsalves','Joseph.Gonsalves@nomail.com','Alabama','Mount Olive','01/25/2019',0)
			,('Kamalakkannan.Kandswamy','Kamalakkannan','Kandswamy','Kamalakkannan.Kandswamy@nomail.com','Arizona','San Tan Valley','01/26/2019',0)
			,('Karthik.Ramani','Karthik','Ramani','Karthik.Ramani@nomail.com','Arizona','Casa Adobes','01/26/2019',0)
			,('Kishore.Kumar','Kishore','Kumar','Kishore.Kumar@nomail.com','Arizona','Drexel Heights','02/07/2019',0)
			,('Krishna.Swamy','Krishna','Swamy','Krishna.Swamy@nomail.com','Arizona','Fortuna Foothills','02/08/2019',0)
			,('Kumar.Anupam','Kumar','Anupam','Kumar.Anupam@nomail.com','Arizona','Sun City West','02/09/2019',0)
			,('Madhuri.Dixit','Madhuri','Dixit','Madhuri.Dixit@nomail.com','Arizona','Anthem','02/10/2019',0)
			,('Manish.Patel','Manish','Patel','Manish.Patel@nomail.com','Arizona','Tanque Verde','02/13/2019',0)
			,('Manodip.Acharya','Manodip','Acharya','Manodip.Acharya@nomail.com','Arizona','Flowing Wells','03/06/2019',0)
			,('Manu.Jayaraj','Manu','Jayaraj','Manu.Jayaraj@nomail.com','Arizona','New River','03/07/2019',0)
			,('Mathew.Varghese','Mathew','Varghese','Mathew.Varghese@nomail.com','Arizona','Sierra Vista Southeast','03/08/2019',0)
			,('Mitul.Kumar','Mitul','Kumar','Mitul.Kumar@nomail.com','Arizona','Fort Mohave','03/09/2019',0)
			,('Chloe.Bennet','Chloe','Bennet','Chloe.Bennet@nomail.com','Arizona','Sun Lakes','03/10/2019',0)
			,('Ming.Wen','Ming','Wen','Ming.Wen@nomail.com','California','Los Angeles','03/12/2019',0)
			,('Elizabeth.Hegde','Elizabeth','Hegde','Elizabeth.Hegde@nomail.com','California','San Diego','03/13/2019',0)
			,('Henry.Simmons','Henry','Simmons','Henry.Simmons@nomail.com','California','San Jose','03/14/2019',0)
			,('Jeff.Ward','Jeff','Ward','Jeff.Ward@nomail.com','California','Fresno','03/16/2019',0)
			,('Stan.Lee','Stan','Lee','Stan.Lee@nomail.com','California','Sacramento','03/17/2019',0)
			,('Nick.Blood','Nick','Blood','Nick.Blood@nomail.com','California','Long Beach','03/18/2019',0)
			,('Luke.Mitchell','Luke','Mitchell','Luke.Mitchell@nomail.com','California','Oakland','04/19/2019',0)
			,('Nirmala.Ramani','Nirmala','Ramani','Nirmala.Ramani@nomail.com','California','Bakersfield','04/20/2019',0)
			,('Nishit.Rai','Nishit','Rai','Nishit.Rai@nomail.com','California','Anaheim','04/21/2019',0)
			,('Padmini.Rangam','Padmini','Rangam','Padmini.Rangam@nomail.com','California','Santa Ana','04/22/2019',0)
			,('Paritosh.Kumar','Paritosh','Kumar','Paritosh.Kumar@nomail.com','California','Riverside','04/23/2019',0)
			,('Parmar.Singh','Parmar','Singh','Parmar.Singh@nomail.com','California','Stockton','04/24/2019',0)
			,('Patraksha.Sarkar','Patraksha','Sarkar','Patraksha.Sarkar@nomail.com','California','Chula Vista','04/25/2019',0)
			,('Pavithra.Prem','Pavithra','Prem','Pavithra.Prem@nomail.com','California','Fremont','04/26/2019',0)
			,('PavithraManjunath.Manjunath','PavithraManjunath','Manjunath','PavithraManjunath.Manjunath@nomail.com','California','Irvine','04/27/2019',0)
			,('Piyush.Goyal','Piyush','Goyal','Piyush.Goyal@nomail.com','California','San Bernardino','04/28/2019',0)
			,('Piyush.Kantilal','Piyush','Kantilal','Piyush.Kantilal@nomail.com','California','Modesto','05/29/2019',0)
			,('Ponnammal.Ramachandran','Ponnammal','Ramachandran','Ponnammal.Ramachandran@nomail.com','California','Oxnard','05/30/2019',0)
			,('Prabath.Kantilal','Prabath','Kantilal','Prabath.Kantilal@nomail.com','California','Fontana','05/31/2019',0)
			,('Pradeep.Diwanji','Pradeep','Diwanji','Pradeep.Diwanji@nomail.com','California','Moreno Valley','06/02/2019',0)
			,('PradeepKumar.Kumar','PradeepKumar','Kumar','PradeepKumar.Kumar@nomail.com','Arizona','Flowing Wells','06/02/2019',0)
			,('Pragya.Jha','Pragya','Jha','Pragya.Jha@nomail.com','Arizona','New River','06/03/2019',0)
			,('Rajshekhar.Aurade','Rajshekhar','Aurade','Rajshekhar.Aurade@nomail.com','Arizona','Sierra Vista Southeast','06/05/2019',0)
			,('Rohith.Kumar','Rohith','Kumar','Rohith.Kumar@nomail.com','Arizona','Fort Mohave','06/06/2019',0)
			,('Sandeep.Ramesh','Sandeep','Ramesh','Sandeep.Ramesh@nomail.com','Arizona','Sun Lakes','06/07/2019',0)
			,('Sharat.Patel','Sharat','Patel','Sharat.Patel@nomail.com','Arizona','Tucson Estates','06/08/2019',0)
			,('Shriman.Mishra','Shriman','Mishra','Shriman.Mishra@nomail.com','California','Los Angeles','06/09/2019',0)
			,('Siddhartha.Moghe','Siddhartha','Moghe','Siddhartha.Moghe@nomail.com','California','San Diego','06/10/2019',0)
			,('Sobhan.Mahapatra','Sobhan','Mahapatra','Sobhan.Mahapatra@nomail.com','California','San Jose','06/11/2019',0)
			,('Sovan.Pratihar','Sovan','Pratihar','Sovan.Pratihar@nomail.com','California','San Francisco','06/11/2019',0)
			,('Sreejith.Kumar','Sreejith','Kumar','Sreejith.Kumar@nomail.com','California','Fresno','07/13/2019',0)
			,('SREENIVASALU.Rao','SREENIVASALU','Rao','SREENIVASALU.Rao@nomail.com','California','Sacramento','07/14/2019',0)
			,('Srikanth.Mallya','Srikanth','Mallya','Srikanth.Mallya@nomail.com','California','Long Beach','07/15/2019',0)
			,('SRIKANTHA.Reddy','SRIKANTHA','Reddy','SRIKANTHA.Reddy@nomail.com','California','Oakland','07/16/2019',0)
			,('Subramanya.Rao','Subramanya','Rao','Subramanya.Rao@nomail.com','Alabama','Moores Mill','07/17/2019',0)
			,('Subramonian.Swamy','Subramonian','Swamy','Subramonian.Swamy@nomail.com','Alabama','Harvest','07/18/2019',0)
			,('Sudeep.Kumar','Sudeep','Kumar','Sudeep.Kumar@nomail.com','Alabama','Fort Rucker','07/19/2019',0)
			,('Sudhir.Prabhu','Sudhir','Prabhu','Sudhir.Prabhu@nomail.com','Alabama','Pine Level','07/20/2019',0)
			,('Sugeesh.Chandran','Sugeesh','Chandran','Sugeesh.Chandran@nomail.com','Alabama','Holtville','07/21/2019',0)
			,('Suhas.Kini','Suhas','Kini','Suhas.Kini@nomail.com','Alabama','Mount Olive','07/22/2019',0)
			,('Sukeshini.Kumari','Sukeshini','Kumari','Sukeshini.Kumari@nomail.com','Arizona','San Tan Valley','09/10/2019',0)
			,('Suma.Meda','Suma','Meda','Suma.Meda@nomail.com','Arizona','Casa Adobes','09/11/2019',0)
			,('Sumanth.Rao','Sumanth','Rao','Sumanth.Rao@nomail.com','Arizona','Catalina Foothills','09/12/2019',0)
			,('Sunand.Sahu','Sunand','Sahu','Sunand.Sahu@nomail.com','Arizona','Sun City','09/13/2019',0)
			,('Sunil.Narayan','Sunil','Narayan','Sunil.Narayan@nomail.com','Arizona','Drexel Heights','09/14/2019',0)
			,('Sunil.Sharma','Sunil','Sharma','Sunil.Sharma@nomail.com','Arizona','Fortuna Foothills','09/15/2019',0)
			,('Supriya.Prasad','Supriya','Prasad','Supriya.Prasad@nomail.com','California','Long Beach','10/14/2019',0)
			,('Suresh.Kumar','Suresh','Kumar','Suresh.Kumar@nomail.com','California','Oakland','10/15/2019',0)
			,('Sushma.Numula','Sushma','Numula','Sushma.Numula@nomail.com','California','Bakersfield','10/16/2019',0)
			,('Tejendra.Gupta','Tejendra','Gupta','Tejendra.Gupta@nomail.com','California','Anaheim','10/17/2019',0)
			,('Thulasidhar.Reddy','Thulasidhar','Reddy','Thulasidhar.Reddy@nomail.com','California','Santa Ana','10/18/2019',0)
			,('TUSHAR.Tamboli','TUSHAR','Tamboli','TUSHAR.Tamboli@nomail.com','California','Riverside','11/03/2019',0)
			,('Udayasree.Narayan','Udayasree','Narayan','Udayasree.Narayan@nomail.com','California','Stockton','11/04/2019',0)
			,('Usha.Sharma','Usha','Sharma','Usha.Sharma@nomail.com','California','Chula Vista','11/05/2019',0)
			,('Vaibhav.Kumar','Vaibhav','Kumar','Vaibhav.Kumar@nomail.com','California','Fremont','11/06/2019',0)
			,('Vaibhav.Saxena','Vaibhav','Saxena','Vaibhav.Saxena@nomail.com','California','Irvine','11/07/2019',0)
			,('Vasant.Ghooli','Vasant','Ghooli','Vasant.Ghooli@nomail.com','California','San Bernardino','11/08/2019',0)
			,('Veena.Mehta','Veena','Mehta','Veena.Mehta@nomail.com','California','Modesto','01/09/2020',0)
			,('Vijay.Kumar','Vijay','Kumar','Vijay.Kumar@nomail.com','California','Oxnard','01/10/2020',0)
			,('Vijaya.Kumar','Vijaya','Kumar','Vijaya.Kumar@nomail.com','Missouri','St. Louis','01/11/2020',0)
			,('Vijaykumar.Peddibhotla','Vijaykumar','Peddibhotla','Vijaykumar.Peddibhotla@nomail.com','Missouri','Springfield','01/12/2020',0)
			,('Vijaykumar.Sadhana','Vijaykumar','Sadhana','Vijaykumar.Sadhana@nomail.com','Missouri','Columbia','01/13/2020',0)
			,('Vinayak.Kumashi','Vinayak','Kumashi','Vinayak.Kumashi@nomail.com','Missouri','Independence','01/14/2020',0)
			,('Vinayaka.Venkat','Vinayaka','Venkat','Vinayaka.Venkat@nomail.com','Missouri','Lee''s Summit','01/15/2020',0)
			,('Vishal.Tyagi','Vishal','Tyagi','Vishal.Tyagi@nomail.com','Missouri','O''Fallon','01/16/2020',0)
			,('Vishnu.Reddy','Vishnu','Reddy','Vishnu.Reddy@nomail.com','Missouri','St. Joseph','01/17/2020',0)
			,('Vishwas.Kumar','Vishwas','Kumar','Vishwas.Kumar@nomail.com','Missouri','St. Charles','01/18/2020',0)
			,('Sachin.Yadav','Sachin','Yadav','Sachin.Yadav@nomail.com','Missouri','St. Peters','01/19/2020',0)

/*---That was easy! Lets see if our data got into the tables correctly.
	Select * from dbo.w_Author_Tier_Level GO;
	Select * from dbo.w_Author_Social_Profile GO;
	Select * from dbo.w_Channel_VisitorType GO;
	Select * from dbo.w_Article_Category Go;
	
	Select *
	from dbo.w_Channel_Users USR 
	where IsAuthor = 0     ---- Filter only Regular Users (non-authors)

-----End of smoke testing 

******************************	Data Entry - Phase I - Ends  ***********************************************


*************************************************************************************************************
								User Defined Functions
		Functions:
			1. dbo.w_fn_UserIDLookup
			2. dbo.w_fn_AuthorIDLookup
			3. dbo.w_fn_FindDateSince
			4. dbo.w_fn_DoesSubscriberExist
			5. dbo.w_fn_CategoryIDLookup
			6. dbo.w_fn_ArticleIDLookup
			7. dbo.w_fn_VisitorTypeIDLookup
*************************************************************************************************************


***************************   UDFs Creation - Begins  *******************************************************/

----- 1. dbo.w_fn_UserIDLookup  - Creation
	----- This Scalar function should return UserID for the give UserName
	----- Input value: @UserName
	----- Output value: UserID from dbo.w_Channel_Users table

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_fn_UserIDLookup')
	BEGIN
		DROP FUNCTION w_fn_UserIDLookup
	END
	GO

	CREATE FUNCTION 
		dbo.w_fn_UserIDLookup(@UserName varchar(40))
	RETURNS Int 
	AS
	BEGIN
			DECLARE @returnValue int  -- data type matches RETURN Value
			/*
			Get UserID from the w_Channel_Authors record whose UserName matches the provided parameter and assign that return value to variable @returnvalue.
			*/
			SELECT 
			@returnValue= USR.UserID 
			FROM dbo.w_Channel_Users USR
			Where 
			USR.UserName = @UserName
			----AND USR.IsAuthor =0

			--Return @returnvalue to the calling code
			RETURN @returnValue
	END
	GO

	----- Validation: 
	----- Select dbo.w_fn_UserIDLookup('Scarlett.Johnson') as UserID


----- 2. dbo.w_fn_AuthorIDLookup  - Creation
	----- This Scalar function should return UserID(AuthorID) for the give UserName
	----- Input value: @UserName 
	----- Output value: AuthorID from dbo.w_Channel_Authors 

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_fn_AuthorIDLookup')
	BEGIN
		DROP FUNCTION w_fn_AuthorIDLookup
	END
	GO

	CREATE FUNCTION 
		dbo.w_fn_AuthorIDLookup(@authorName varchar(40))
	RETURNS Int 
	AS
	BEGIN
			DECLARE @returnValue int  -- data type matches RETURN Value
			/*
			Get AuthorID of the w_Channel_Authors record whose UserName matches the provided parameter and assign that return value to variable @returnvalue.
			*/

			SELECT 
			@returnValue= AU.AuthorID 
			FROM dbo.w_Channel_Users USR
			JOIN dbo.w_Channel_Authors AU on USR.UserID = AU.UserID
			Where 
			USR.UserName = @authorName
			AND USR.IsAuthor ='true'

			--Return @returnvalue to the calling code
			RETURN @returnValue
	END
	GO

	----- Validation: Please note that No data has been inserted into dbo.w_Channel_Authors table, yet.So, running below may return NULL
	----- Select dbo.w_fn_AuthorIDLookup('Clark.Gregg') as AuthorID

----- 3. dbo.w_fn_FindDateSince  - Creation
	----- This Scalar function should return Max of DateCreated between User and Author Whom that User Follows
	----- This function also provides a example for using CTEs.
	----- Input value: @UserName ,@AuthorName
	----- Output value: DateCreated - Datetime value from dbo.w_Channel_Users table ; Defaults to getdate() if neither (User/Author) of them exist

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_fn_FindDateSince')
	BEGIN
		DROP FUNCTION w_fn_FindDateSince
	END
	GO

	CREATE FUNCTION 
		dbo.w_fn_FindDateSince(@UserName varchar(40),@AuthorName varchar(40))
	RETURNS datetime 
	AS
	BEGIN
			DECLARE @returnValue datetime;  -- data type matches RETURN Value
			/*
			Get AuthorID of the w_Channel_Authors record whose UserName matches the provided parameter and assign that return value to variable @returnvalue.
			*/

			WITH CTE
			AS
				--Select  max(DateCreated) as DateCreated,  max(DateCreated)+10 as DateCreated_10  from 
			(
			select USR.DateCreated  As DateCreated
			from dbo.w_Channel_Users USR 
			where  
					USR.UserName = @UserName ----'Scarlett.Johnson'  
				and USR.IsAuthor = 0  

			UNION ALL

			select USR.DateCreated  As DateCreated
			from dbo.w_Channel_Authors AU
			Join dbo.w_Channel_Users USR on AU.UserID=USR.UserID
			where 
					USR.UserName = @AuthorName  ----'Chris.Evans'
				--)  a
			)

			Select @returnValue= ISNULL(max(DateCreated),Getdate()) from CTE
			--Return @returnvalue to the calling code
			RETURN @returnValue
	END
	GO

	-----Validation: 
	-----select dbo.w_fn_FindDateSince('Scarlett.Johnson','Chris.Evans') as DateSince


----- 4. dbo.w_fn_DoesSubscriberExist  - Creation
	----- This Scalar function should return FollowerID of User who follows an Author
	----- Please note that this function also calls other two functions we have created already. Test of Nested function calls.May add performance issue
	-----	;howver, for learning purpose it might be good enough
	----- Input value: @UserName ,@AuthorName
	----- Output value: FollowerID - from dbo.w_Author_Followers table

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_fn_DoesSubscriberExist')
	BEGIN
		DROP FUNCTION w_fn_DoesSubscriberExist
	END
	GO

	CREATE FUNCTION 
		dbo.w_fn_DoesSubscriberExist(@UserName varchar(40),@AuthorName varchar(40))
	RETURNS int 
	AS
	BEGIN
			DECLARE @returnValue int, @UserID int, @AuthorID int  -- data type matches RETURN Value
			/*
			Get FollowerID of the w_Author_Followers whose UserName & AuthorName matches the provided parameters and assign that return value to variable @returnvalue.
			*/

			Select @userID = dbo.w_fn_UserIDLookup(@UserName) 
			Select @AuthorID = dbo.w_fn_AuthorIDLookup(@AuthorName) 
			
			Select @returnValue = FollowerID 
			From dbo.w_Author_Followers where UserID=@userID and AuthorID=@AuthorID
			
			--Return @returnvalue to the calling code
			RETURN @returnValue
	END
	GO

	----- Validation: Please note that No data has been inserted into dbo.w_Channel_Authors & w_Author_Followers tables, yet.So, running below may return NULL
	----- select dbo.w_fn_DoesSubscriberExist('Scarlett.Johnson','Chris.Evans') as FollowerID


----- 5. dbo.w_fn_CategoryIDLookup  - Creation
	----- This Scalar function should return CategoryID for the CategoryName input
	----- Input value: @CategoryName
	----- Output value: CategoryID - from dbo.w_Article_Category table; If this function is called during Article creation then a default 
	------ value is assigned.

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_fn_CategoryIDLookup')
	BEGIN
		DROP FUNCTION w_fn_CategoryIDLookup
	END
	GO

	CREATE FUNCTION 
		dbo.w_fn_CategoryIDLookup(@CategoryName varchar(40))
	RETURNS Int 
	AS
	BEGIN
			DECLARE @returnValue int  -- data type matches RETURN Value
			/*
			Get CategoryID of the w_Article_Category record whose CategoryName matches the provided parameter and assign that return value to variable @returnvalue.
			*/
			SELECT 
			@returnValue= C.CategoryID 
			FROM dbo.w_Article_Category  C
			Where 
			C.CategoryName = @CategoryName
			
			IF @returnValue IS NULL  ---If @Category is not found then return UnAssigned by defualt)
				BEGIN
					SELECT 
					@returnValue= C.CategoryID 
					FROM dbo.w_Article_Category  C
					Where 
					C.CategoryName = 'UnAssigned'
				END

			--Return @returnvalue to the calling code
			RETURN @returnValue
	END
	GO

	---Validation
	----select dbo.w_fn_CategoryIDLookup('Database Management') as for_ValidCategoryName
	----select dbo.w_fn_CategoryIDLookup('Database Management1') as for_InvalidValidCategoryName  -- returning UnAssigned CategoryID

----- 6. dbo.w_fn_ArticleIDLookup  - Creation
	----- This Scalar function should return ArticleID for the ArticleName input
	----- Input value: @ArticleName
	----- Output value: ArticleID - from dbo.w_Channel_Articles table

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_fn_ArticleIDLookup')
	BEGIN
		DROP FUNCTION w_fn_ArticleIDLookup
	END
	GO

	CREATE FUNCTION 
		dbo.w_fn_ArticleIDLookup(@ArticleName varchar(100))
	RETURNS Int 
	AS
	BEGIN
			DECLARE @returnValue int  -- data type matches RETURN Value
			/*
			Get ArticleID of the w_Channel_Articles record whose @ArticleName matches the provided parameter and assign that return value to variable @returnvalue.
			*/
			SELECT 
			@returnValue= A.ArticleID 
			FROM dbo.w_Channel_Articles  A
			Where 
			A.ArticleName = @ArticleName
			
			----Return @returnvalue to the calling code
			RETURN @returnValue
	END
	GO

	---Validation
	---select dbo.w_fn_ArticleIDLookup('Lean Six Sigma and Minitab') as ArticleID


----- 7. dbo.w_fn_VisitorTypeIDLookup  - Creation
	----- This Scalar function should return VisitorTypeID for the VisitorType input; Defaults to "Viewer" Type
	----- Input value: @VisitorType
	----- Output value: VisitorTypeID - from dbo.w_Channel_VisitorType table

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_fn_VisitorTypeIDLookup')
	BEGIN
		DROP FUNCTION w_fn_VisitorTypeIDLookup
	END
	GO

	CREATE FUNCTION 
		dbo.w_fn_VisitorTypeIDLookup(@VisitorType varchar(50))
	RETURNS Int 
	AS
	BEGIN
			DECLARE @returnValue int  -- data type matches RETURN Value
			/*
			Get VisitorTypeID of the w_Channel_VisitorType record whose @VisitorType matches the provided parameter and assign that return value to variable @returnvalue.
			*/
			SELECT 
			@returnValue= V.VisitorTypeID 
			FROM dbo.w_Channel_VisitorType  V
			Where 
			V.VisitorTypeName = @VisitorType

			IF @returnValue IS NULL  ---If @VisitorType is not found then return Viewer by defualt)
				BEGIN
					SELECT 
					@returnValue= V.VisitorTypeID 
					FROM dbo.w_Channel_VisitorType  V
					Where 
					V.VisitorTypeName = 'Viewer'
				END
			
			----Return @returnvalue to the calling code
			RETURN @returnValue
	END
	GO

	---Validation
	---select dbo.w_fn_VisitorTypeIDLookup('Subscriber') as VisitorTypeID

/* ***********************   UDFs Creation - Ends  *********************************************


************************************************************************************************
								Stored Procedures

		Stored Procedures:
			1. dbo.w_sp_AddAuthors
			2. dbo.w_sp_AddAuthorFollowers
			3. dbo.w_sp_AddArticles
			4. dbo.w_sp_AddUserActivity
			5. dbo.w_sp_Update_Tier_Level
			6. dbo.w_sp_Update_Author_TierLevel

			Additional Stored Procedures for BULK Data Entry
			1. dbo.w_sp_AddAuthorFollowers_BULK
			2. dbo.w_sp_AddArticles_BULK
			3. dbo.w_sp_AddUserActivitys_BULK
************************************************************************************************

********************************  Stored Procedures Creation - Begins ***************************/


----- 1. w_sp_AddAuthors - Creation
	----- This Stored procedure inserts data into  w_Channel_Authors on two modes as simple & bulk
	----- Input value: @loadtype,@userName
	----- Output : for simple mode, only one entry is made.However, for bulk or one time insert Bulk mode is helpful

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_sp_AddAuthors')
	BEGIN
		DROP PROCEDURE w_sp_AddAuthors
	END
	GO

	CREATE PROCEDURE dbo.w_sp_AddAuthors (@loadtype varchar(20), @userName varchar(20))
	AS
	BEGIN
		If (@loadtype ='simple')

			BEGIN
			--We have UserName but we need the ID for the Login table
			--First, decare a variable to hold the ID
				DECLARE @userID int

				IF (dbo.w_fn_AuthorIDLookup(@userName)) IS NULL
					BEGIN
						--Get the UserID for the UserName provided and store it in @userID
						SELECT @userID = (dbo.w_fn_UserIDLookup(@userName))

						--Now we can add the row using an INSERT Statement
						INSERT INTO dbo.w_Channel_Authors (UserID)
						VALUES (@userID)
					END

				--Now return the @@identity so the calling code knows where the data ended up
				--RETURN @@identity
			END

		If (@loadtype ='bulk')
		
			BEGIN
				IF (select count(UserID) from dbo.w_Channel_Authors) =0

					BEGIN

						INSERT INTO dbo.w_Channel_Authors (UserID)
						SELECT userID
						From dbo.w_Channel_Users 
						Where IsAuthor ='true'
					END
			END
	END
	GO

	------Bulk import into w_Channel_Authors table

	EXEC dbo.w_sp_AddAuthors 'bulk',''    -- for firt time bulk data load into w_Channel_Authors table.

----- 2. w_sp_AddAuthorFollowers - Creation
	----- This Stored procedure inserts data into  w_Author_Followers on two modes as simple & bulk
	----- Input value: @loadtype,@userName,@AuthorName
	----- Output : for simple mode, only one entry is made with default DateSince as getdate()
	-----		   for custom mode, only one entry is made with default DateSince dynamically driven by w_fn_FindDateSince function

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_sp_AddAuthorFollowers')
	BEGIN
		DROP PROCEDURE w_sp_AddAuthorFollowers
	END
	GO

	CREATE PROCEDURE dbo.w_sp_AddAuthorFollowers (@loadtype varchar(20), @UserName varchar(40),@AuthorName varchar(40))
	AS
	BEGIN
		DECLARE @userID int, @AuthorID int,@datesince datetime

		If (@loadtype ='Simple')

			BEGIN
			--We have UserName but we need the ID for the Login table
			--First, decare a variable to hold the ID
				

				IF (dbo.w_fn_DoesSubscriberExist(@UserName,@AuthorName)) IS NULL
					BEGIN
						--Get the UserID for the UserName provided and store it in @userID
						Select @userID = dbo.w_fn_UserIDLookup(@UserName) 
						Select @AuthorID = dbo.w_fn_AuthorIDLookup(@AuthorName) 
						--Now we can add the row using an INSERT Statement
						INSERT INTO dbo.w_Author_Followers (UserID,AuthorID)
						VALUES (@userID,@AuthorID)
					END

			END

		If (@loadtype ='custom')
		
			BEGIN
				
				IF (dbo.w_fn_DoesSubscriberExist(@UserName,@AuthorName)) IS NULL
					BEGIN
						--Get the UserID for the UserName provided and store it in @userID
						Select @userID = dbo.w_fn_UserIDLookup(@UserName) 
						Select @AuthorID = dbo.w_fn_AuthorIDLookup(@AuthorName)
						select @datesince = dbo.w_fn_FindDateSince(@UserName,@AuthorName)
						--Now we can add the row using an INSERT Statement
						INSERT INTO dbo.w_Author_Followers (UserID,AuthorID,DateSince)
						VALUES (@userID,@AuthorID,@datesince)
					END
			END
	END
	GO

	---Insert into w_sp_AddAuthorFollowers
	Exec dbo.w_sp_AddAuthorFollowers 'custom','Stan.Lee','Clark.Gregg'
	Exec dbo.w_sp_AddAuthorFollowers 'simple','Stan.Lee','Kit.Harington'
	
	---select * from dbo.w_Author_Followers
		
----- 3. w_sp_AddAuthorFollowers_BULK - Creation
	----- This Stored procedure executes w_sp_AddAuthorFollowers procedure on custom mode to perform Bulk Inserts into w_Author_Followers table
	----- Input Values were based on raw data prepared for better data analysis.

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_sp_AddAuthorFollowers_BULK')
	BEGIN
		DROP PROCEDURE w_sp_AddAuthorFollowers_BULK
	END
	GO

	Create Procedure [dbo].[w_sp_AddAuthorFollowers_BULK] 
	AS
	BEGIN

			Exec dbo.w_sp_AddAuthorFollowers  'custom','Amitesh.Kumar','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Anjali.Baranwal','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Anshuman.Mishra','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Scarlett.Johnson','John.Bradley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Deepthi.Kumar','Gwen.Christie'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Dhanasekara.Pandian','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Fathima.Zahera','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Jai.Ganesh','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Joseph.Gonsalves','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kamalakkannan.Kandswamy','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Karthik.Ramani','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kishore.Kumar','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Krishna.Swamy','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kumar.Anupam','John.Bradley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Madhuri.Dixit','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manish.Patel','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manodip.Acharya','Gwen.Christie'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manu.Jayaraj','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Mathew.Varghese','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Mitul.Kumar','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Chloe.Bennet','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Ming.Wen','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Elizabeth.Hegde','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Henry.Simmons','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Jeff.Ward','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Stan.Lee','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nick.Blood','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Luke.Mitchell','John.Bradley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nirmala.Ramani','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nishit.Rai','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Padmini.Rangam','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Paritosh.Kumar','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Parmar.Singh','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Patraksha.Sarkar','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pavithra.Prem','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','PavithraManjunath.Manjunath','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Piyush.Goyal','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Piyush.Kantilal','Peter.Dinklage'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Ponnammal.Ramachandran','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Prabath.Kantilal','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pradeep.Diwanji','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','PradeepKumar.Kumar','Peter.Dinklage'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pragya.Jha','John.Bradley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Rajshekhar.Aurade','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Rohith.Kumar','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sandeep.Ramesh','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sharat.Patel','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Shriman.Mishra','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Siddhartha.Moghe','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sobhan.Mahapatra','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sovan.Pratihar','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sreejith.Kumar','Sophie.Turner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','SREENIVASALU.Rao','Peter.Dinklage'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Srikanth.Mallya','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','SRIKANTHA.Reddy','John.Bradley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Subramanya.Rao','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Subramonian.Swamy','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sudeep.Kumar','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sudhir.Prabhu','John.Bradley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sugeesh.Chandran','Gwen.Christie'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suhas.Kini','Sophie.Turner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sukeshini.Kumari','Peter.Dinklage'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suma.Meda','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sumanth.Rao','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunand.Sahu','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunil.Narayan','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunil.Sharma','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Supriya.Prasad','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suresh.Kumar','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sushma.Numula','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Tejendra.Gupta','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Thulasidhar.Reddy','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','TUSHAR.Tamboli','Peter.Dinklage'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Udayasree.Narayan','Sophie.Turner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Usha.Sharma','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vaibhav.Kumar','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vaibhav.Saxena','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vasant.Ghooli','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Veena.Mehta','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijay.Kumar','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaya.Kumar','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaykumar.Peddibhotla','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaykumar.Sadhana','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vinayak.Kumashi','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vinayaka.Venkat','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishal.Tyagi','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishnu.Reddy','Sophie.Turner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishwas.Kumar','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sachin.Yadav','Lena.Headley'

			------Block 2  -------
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Amitesh.Kumar','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Anjali.Baranwal','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Anshuman.Mishra','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Scarlett.Johnson','Conleth.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Deepthi.Kumar','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Dhanasekara.Pandian','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Fathima.Zahera','Tom.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Jai.Ganesh','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Joseph.Gonsalves','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kamalakkannan.Kandswamy','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Karthik.Ramani','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kishore.Kumar','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Krishna.Swamy','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kumar.Anupam','Conleth.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Madhuri.Dixit','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manish.Patel','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manodip.Acharya','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manu.Jayaraj','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Mathew.Varghese','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Mitul.Kumar','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Chloe.Bennet','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Ming.Wen','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Elizabeth.Hegde','Tom.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Henry.Simmons','Gwen.Christie'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Jeff.Ward','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Stan.Lee','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nick.Blood','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Luke.Mitchell','Conleth.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nirmala.Ramani','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nishit.Rai','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Padmini.Rangam','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Paritosh.Kumar','Tom.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Parmar.Singh','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Patraksha.Sarkar','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pavithra.Prem','Tom.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','PavithraManjunath.Manjunath','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Piyush.Goyal','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Piyush.Kantilal','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Ponnammal.Ramachandran','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Prabath.Kantilal','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pradeep.Diwanji','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','PradeepKumar.Kumar','Brett.Dalton'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pragya.Jha','Conleth.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Rajshekhar.Aurade','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Rohith.Kumar','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sandeep.Ramesh','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sharat.Patel','Brett.Dalton'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Shriman.Mishra','Tom.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Siddhartha.Moghe','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sobhan.Mahapatra','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sovan.Pratihar','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sreejith.Kumar','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','SREENIVASALU.Rao','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Srikanth.Mallya','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','SRIKANTHA.Reddy','Conleth.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Subramanya.Rao','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Subramonian.Swamy','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sudeep.Kumar','Brett.Dalton'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sudhir.Prabhu','Conleth.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sugeesh.Chandran','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suhas.Kini','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sukeshini.Kumari','Aidan.Gillan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suma.Meda','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sumanth.Rao','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunand.Sahu','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunil.Narayan','Aidan.Gillan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunil.Sharma','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Supriya.Prasad','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suresh.Kumar','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sushma.Numula','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Tejendra.Gupta','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Thulasidhar.Reddy','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','TUSHAR.Tamboli','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Udayasree.Narayan','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Usha.Sharma','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vaibhav.Kumar','Tom.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vaibhav.Saxena','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vasant.Ghooli','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Veena.Mehta','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijay.Kumar','Tom.Hill'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaya.Kumar','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaykumar.Peddibhotla','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaykumar.Sadhana','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vinayak.Kumashi','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vinayaka.Venkat','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishal.Tyagi','Nikolaj.Costa'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishnu.Reddy','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishwas.Kumar','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sachin.Yadav','Gwen.Christie'

			-------Block 3 --------
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Amitesh.Kumar','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Anjali.Baranwal','Iain.Glen'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Anshuman.Mishra','Sophie.Turner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Scarlett.Johnson','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Deepthi.Kumar','Sophie.Turner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Dhanasekara.Pandian','Iain.Glen'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Fathima.Zahera','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Jai.Ganesh','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Joseph.Gonsalves','Sophie.Turner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kamalakkannan.Kandswamy','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Karthik.Ramani','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kishore.Kumar','Iain.Glen'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Krishna.Swamy','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kumar.Anupam','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Madhuri.Dixit','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manish.Patel','Sophie.Turner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manodip.Acharya','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manu.Jayaraj','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Mathew.Varghese','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Mitul.Kumar','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Chloe.Bennet','Sophie.Turner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Ming.Wen','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Elizabeth.Hegde','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Henry.Simmons','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Jeff.Ward','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Stan.Lee','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nick.Blood','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Luke.Mitchell','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nirmala.Ramani','Sophie.Turner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nishit.Rai','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Padmini.Rangam','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Paritosh.Kumar','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Parmar.Singh','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Patraksha.Sarkar','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pavithra.Prem','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','PavithraManjunath.Manjunath','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Piyush.Goyal','Iain.Glen'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Piyush.Kantilal','Peter.Dinklage'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Ponnammal.Ramachandran','Sophie.Turner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Prabath.Kantilal','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pradeep.Diwanji','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','PradeepKumar.Kumar','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pragya.Jha','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Rajshekhar.Aurade','Brett.Dalton'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Rohith.Kumar','Iain.Glen'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sandeep.Ramesh','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sharat.Patel','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Shriman.Mishra','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Siddhartha.Moghe','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sobhan.Mahapatra','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sovan.Pratihar','Brett.Dalton'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sreejith.Kumar','Gwen.Christie'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','SREENIVASALU.Rao','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Srikanth.Mallya','Brett.Dalton'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','SRIKANTHA.Reddy','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Subramanya.Rao','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Subramonian.Swamy','Iain.Glen'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sudeep.Kumar','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sudhir.Prabhu','Lena.Headley'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sugeesh.Chandran','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suhas.Kini','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sukeshini.Kumari','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suma.Meda','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sumanth.Rao','Iain.Glen'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunand.Sahu','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunil.Narayan','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunil.Sharma','Gwen.Christie'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Supriya.Prasad','Iain.Glen'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suresh.Kumar','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sushma.Numula','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Tejendra.Gupta','Iain.Glen'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Thulasidhar.Reddy','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','TUSHAR.Tamboli','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Udayasree.Narayan','Aidan.Gillan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Usha.Sharma','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vaibhav.Kumar','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vaibhav.Saxena','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vasant.Ghooli','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Veena.Mehta','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijay.Kumar','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaya.Kumar','Gwen.Christie'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaykumar.Peddibhotla','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaykumar.Sadhana','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vinayak.Kumashi','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vinayaka.Venkat','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishal.Tyagi','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishnu.Reddy','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishwas.Kumar','Iain.Glen'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sachin.Yadav','Aidan.Gillan'

			--------Block 4 --------
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Amitesh.Kumar','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Anjali.Baranwal','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Anshuman.Mishra','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Scarlett.Johnson','Isaac.Hemstad'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Deepthi.Kumar','Rory.Meccan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Dhanasekara.Pandian','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Fathima.Zahera','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Jai.Ganesh','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Joseph.Gonsalves','Gwen.Christie'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kamalakkannan.Kandswamy','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Karthik.Ramani','Clark.Gregg'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kishore.Kumar','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Krishna.Swamy','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Kumar.Anupam','Isaac.Hemstad'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Madhuri.Dixit','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manish.Patel','Emilia.Clarke'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manodip.Acharya','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Manu.Jayaraj','Keyurkumar.Bhat'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Mathew.Varghese','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Mitul.Kumar','Keyurkumar.Bhat'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Chloe.Bennet','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Ming.Wen','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Elizabeth.Hegde','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Henry.Simmons','Girish.Dengi'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Jeff.Ward','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Stan.Lee','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nick.Blood','Keyurkumar.Bhat'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Luke.Mitchell','Isaac.Hemstad'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nirmala.Ramani','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Nishit.Rai','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Padmini.Rangam','Keyurkumar.Bhat'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Paritosh.Kumar','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Parmar.Singh','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Patraksha.Sarkar','Keyurkumar.Bhat'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pavithra.Prem','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','PavithraManjunath.Manjunath','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Piyush.Goyal','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Piyush.Kantilal','Girish.Dengi'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Ponnammal.Ramachandran','Gwen.Christie'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Prabath.Kantilal','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pradeep.Diwanji','Girish.Dengi'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','PradeepKumar.Kumar','Girish.Dengi'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Pragya.Jha','Isaac.Hemstad'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Rajshekhar.Aurade','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Rohith.Kumar','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sandeep.Ramesh','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sharat.Patel','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Shriman.Mishra','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Siddhartha.Moghe','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sobhan.Mahapatra','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sovan.Pratihar','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sreejith.Kumar','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','SREENIVASALU.Rao','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Srikanth.Mallya','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','SRIKANTHA.Reddy','Isaac.Hemstad'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Subramanya.Rao','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Subramonian.Swamy','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sudeep.Kumar','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sudhir.Prabhu','Isaac.Hemstad'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sugeesh.Chandran','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suhas.Kini','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sukeshini.Kumari','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suma.Meda','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sumanth.Rao','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunand.Sahu','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunil.Narayan','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sunil.Sharma','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Supriya.Prasad','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Suresh.Kumar','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sushma.Numula','Aidan.Gillan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Tejendra.Gupta','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Thulasidhar.Reddy','Jerome.Flynn'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','TUSHAR.Tamboli','Nathalie.Emmanuel'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Udayasree.Narayan','Mark.Ruffalo'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Usha.Sharma','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vaibhav.Kumar','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vaibhav.Saxena','Keyurkumar.Bhat'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vasant.Ghooli','Aidan.Gillan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Veena.Mehta','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijay.Kumar','Jeremy.Renner'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaya.Kumar','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaykumar.Peddibhotla','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vijaykumar.Sadhana','Keyurkumar.Bhat'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vinayak.Kumashi','Aidan.Gillan'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vinayaka.Venkat','Keyurkumar.Bhat'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishal.Tyagi','Chris.Evans'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishnu.Reddy','Maisie.Williams'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Vishwas.Kumar','Kit.Harington'
			Exec dbo.w_sp_AddAuthorFollowers  'custom','Sachin.Yadav','Maisie.Williams'
	END
	GO
-----more record inserts can be found in below Procedure
	Exec dbo.w_sp_AddAuthorFollowers_BULK

----- 4. w_sp_AddArticles - Creation
	----- This Stored procedure inserts data into  w_Channel_Articles on two modes as simple & bulk
	----- Input value: @loadtype,@ArticleName,@AuthorName,@CategoryName,@ReferenceURL
	----- Output : for simple mode, only one entry is made with gedate() as default datecreated; making sure Article name is unique and has valid length & author assigned
	-----		   for custom mode, same as above except DatePublished is driven dynamically for historcal data analysis.

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_sp_AddArticles')
	BEGIN
		DROP PROCEDURE w_sp_AddArticles
	END
	GO

	CREATE PROCEDURE dbo.w_sp_AddArticles (@loadtype varchar(20),@ArticleName varchar(100),@AuthorName varchar(40), @CategoryName varchar(40),@ReferenceURL varchar(100))
	AS
	BEGIN
		--First, decare a variables to hold the IDs
		DECLARE  @AuthorID int, @CategoryID int, @DateCreated datetime

		Select @AuthorID = dbo.w_fn_AuthorIDLookup(@AuthorName)
		Select @CategoryID = dbo.w_fn_CategoryIDLookup(@CategoryName)
		
		Select @DateCreated  = USR.DateCreated
		from dbo.w_Channel_Users USR
		Where USR.IsAuthor ='true'   ---Only Authors allowed
		and USR.UserName =@AuthorName  ----@AuthorName

		If (@loadtype ='simple') 
		
			BEGIN
			--We have UserName but we need the ID for the Login table
				IF (dbo.w_fn_ArticleIDLookup(@ArticleName)) IS NULL and len(@ArticleName) >0 and @AuthorID IS NOT NULL
					BEGIN
						----Now we can add the row using an INSERT Statement
						INSERT INTO dbo.w_Channel_Articles (ArticleName,AuthorID,CategoryID,ReferenceURL)
						Select 
							@ArticleName as ArticleName
							,@AuthorID as AuthorID
							,@CategoryID as CategoryID
							,@ReferenceURL as ReferenceURL
					END

			END

		If (@loadtype ='custom')
		
			BEGIN
				IF (dbo.w_fn_ArticleIDLookup(@ArticleName)) IS NULL and len(@ArticleName) >0 and @AuthorID IS NOT NULL
				BEGIN
						----Now we can add the row using an INSERT Statement
						INSERT INTO dbo.w_Channel_Articles (ArticleName,AuthorID,DatePublished,CategoryID,ReferenceURL)
						Select 
							@ArticleName as ArticleName
							,@AuthorID as AuthorID
							,(@DateCreated + 5) as DatePublished
							,@CategoryID as CategoryID ----@CategoryName
							,@ReferenceURL as ReferenceURL
					END
			END
	END
	GO

	Exec dbo.w_sp_AddArticles 'simple','How Businesses are Using Machine Learning and AI','Jerome.Flynn','Business Intelligence',''
	Exec dbo.w_sp_AddArticles 'custom','Increased Operational Efficiencies','Jerome.Flynn','Business Intelligence',''

----- 5. w_sp_AddArticles_BULK - Creation
	----- This Stored procedure executes w_sp_AddArticles procedure on custom mode to perform Bulk Inserts into w_Channel_Articles table
	----- Input Values were based on raw data prepared for better data analysis.

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_sp_AddArticles_BULK')
	BEGIN
		DROP PROCEDURE w_sp_AddArticles_BULK
	END
	GO

	CREATE PROCEDURE [dbo].[w_sp_AddArticles_BULK] 
	AS
	BEGIN
			------Block 1  -------
			Exec dbo.w_sp_AddArticles  'custom','How Businesses are Using Machine Learning and AI','Jerome.Flynn','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Increased Operational Efficiencies','Jerome.Flynn','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Internet of Things (IoT), Big Data and Business Intelligence Update','Jerome.Flynn','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','IoT and the data-driven enterprise: How to dive into the data flood','Jerome.Flynn','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Lessons from Becoming a Data Driven organization','Jerome.Flynn','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Magic Quadrant for Business Intelligence and Analytics Platforms','Jerome.Flynn','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Predictive Analytics','Jerome.Flynn','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','A Cloud-Native Approach Democratizes Self-Service BI','Emilia.Clarke','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Apache Spark: A Unified Engine for Big Data Processing','Emilia.Clarke','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Augmented Analytics and Advanced Analytics','Emilia.Clarke','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Big Data Made Simple','Emilia.Clarke','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Big Data, Advanced Analytics, and Cloud Developer','Emilia.Clarke','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Self-service business intelligence','Sophie.Turner','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Strengthen Your Mobile BI Initiatives WIth These Ten Best Practices','Sophie.Turner','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Tableau Vs. Qlikview','Sophie.Turner','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','The Democratization of Business Intelligence','Sophie.Turner','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Visualization analytics helps utility provider escape Excel hell','Sophie.Turner','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','What is business intelligence? Transforming data into business insights','Sophie.Turner','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','What Is the Future of Data Warehousing?','Sophie.Turner','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','What makes IoT ransomware a different and more dangerous threat?','Sophie.Turner','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Why the Time-Tested Science of Data Visualization is So Powerful','Sophie.Turner','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','11 Tips For Successful Self-Service BI And Analytics','Clark.Gregg','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','6 key areas to examine in any BI solution','Clark.Gregg','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Building Actionable Insights','Clark.Gregg','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Business Intelligence and Analytics','Clark.Gregg','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Business intelligence software and systems','Clark.Gregg','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Business intelligence vs. business analytics','Clark.Gregg','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Critical Capabilities for Business Intelligence and Analytics Platforms','Clark.Gregg','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Data Storytelling: Why Visualization is Only Half the Story','Clark.Gregg','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Evaluation Criteria for Business Intelligence and Analytics Platforms','Clark.Gregg','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','Reinventing a Leading Edge in Cloud-Based Business Intelligence','Clark.Gregg','Business Intelligence',''
			Exec dbo.w_sp_AddArticles  'custom','The 4 aspects of the data and analytics framework','Rory.Meccan','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Too Big To Ignore: The Business Case for Big Data','Rory.Meccan','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','What is an Analytical Framework?','Rory.Meccan','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Intro to Data Analysis Framework','Nikolaj.Costa','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Lean Six Sigma and Minitab','Nikolaj.Costa','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Lean Six Sigma For Dummies','Nikolaj.Costa','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Microsoft Excel Data Analysis and Business Modeling','Nikolaj.Costa','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Data Strategy: How to Profit from a World of Big Data, Analytics and the Internet of Things','Nikolaj.Costa','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','A Guide to Six Sigma and Process Improvement','Gwen.Christie','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','A Practitioner’s Guide to Business Analytics','Gwen.Christie','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Statistical Models and Control Charts for High-Quality Processes','Gwen.Christie','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Stripping the Dread from the Data','Gwen.Christie','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Business Analytics: Data Analysis & Decision Making','Gwen.Christie','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Data Analysis and Decision Making','Gwen.Christie','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Data Analysis Using SQL and Excel','Gwen.Christie','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','Data Analytics Made Accessible','Gwen.Christie','Data Analysis',''
			Exec dbo.w_sp_AddArticles  'custom','A Comparison Of Relational Database Management Systems','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','An International Guide to Data Security and ISO27001/ISO27002','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','An Introduction To Database Systems','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Analytics & Data in a Microservices World','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Appropriate Systems For Your Dataset Size','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','SQL Server Management Studio Made easy','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','SQL, PL/SQL the Programming Language of Oracle','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Teach Yourself SQL','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','The Chief Data Officer Handbook for Data Governance','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','The Data Vault – What is it? – Why do we need it?','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','The Hard Thing About Hard Things','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Tools That Provide Sufficient Access','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Write once and run everywhere','Nathalie.Emmanuel','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Set up a basic Apache Cassandra architecturet','Alfie.Allen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','How to Reduce Costs and Improve Data Quality through the Implementation of IT Governance','Alfie.Allen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Implementing RDBMS using Oracle','Alfie.Allen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Introduction to Database Management Systems','Alfie.Allen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Leverage data against other data sources','Alfie.Allen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Master in Oracle RDBMS','Alfie.Allen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','MySQL For Dummies','Alfie.Allen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Non-Invasive Data Governance','Alfie.Allen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','NoSQL .vs. Row .vs. Column','Alfie.Allen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Principles of Database Systems','Alfie.Allen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Configure MongoDB servers for backup scripts','Iain.Glen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Database Design and Relational Theory','Iain.Glen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Database Management Systems','Iain.Glen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Database system concepts','Iain.Glen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','DATABASE SYSTEMS DESIGN, IMPLEMENTATION, AND MANAGEMENT','Iain.Glen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Extract-Transform-Load (ETL) Technologies – Part 1','Iain.Glen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Extract-Transform-Load (ETL) Technologies – Part 2','Iain.Glen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Best Database Management Systems','Iain.Glen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Column Oriented Database Technologies','Iain.Glen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Extract-Transform-Load (ETL) Technologies – Part 3','Iain.Glen','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','How to Raise an Exception in SQL Server User Defined Functions','John.Bradley','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Fundamentals of Database Systems','John.Bradley','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Getting in Front on Data','John.Bradley','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Head First SQL: Your Brain on SQL','John.Bradley','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','How to Create Autonomous Transactions in SQL Server','John.Bradley','Database Management',''
			Exec dbo.w_sp_AddArticles  'custom','Mathematics behind Machine Learning – The Core Concepts you Need to Know','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Natural Language Processing with Python','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Neural Networks and Deep Learning','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Paradigm of Artificial Intelligence Programming','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Pattern Recognition and Machine Learning','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Programming Collective Intelligence','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Python Machine Learning','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Python Machine Learning: A Technical Approach to Machine Learning for Beginners','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','The Elements of Statistical Learning','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','The Elements of Statistical Learning: Data Mining, Inference, and Prediction','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','The Most Comprehensive Guide to K-Means Clustering You’ll Ever Need','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Think Stats – Probability, and Statistics for Programmers','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Understanding Machine Learning','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Understanding Machine Learning: From Theory to Algorithms','Chris.Evans','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Introduction to Machine Learning with Python: A Guide for Data Scientists','Conleth.Hill','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Learn how to Build and Deploy a Chatbot in Minutes using Rasa','Conleth.Hill','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Learning from Data','Conleth.Hill','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Learning from Data: A Short Course','Conleth.Hill','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Machine Learning for Absolute Beginners: A Plain English Introduction','Conleth.Hill','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Machine Learning for Dummies','Conleth.Hill','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Machine Learning for Hackers','Conleth.Hill','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Machine Learning in Action','Conleth.Hill','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Machine Learning with TensorFlow','Conleth.Hill','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Machine Learning: a Probabilistic Perspective','Conleth.Hill','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Excellent Pretrained Models to get you Started with Natural Language Processing (NLP)','Kit.Harington','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Fundamentals of Machine Learning for Predictive Data Analytics','Kit.Harington','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Hands-On Machine Learning with Scikit-Learn and TensorFlow','Kit.Harington','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow','Kit.Harington','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Implementing Mask R-CNN for Image Segmentation (with Python Code)','Kit.Harington','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','ining of Massive Datasets','Kit.Harington','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Artificial Intelligence: A New Synthesis','Liam.Cunningham','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Bayesian Reasoning and Machine Learning','Liam.Cunningham','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Beginner-Friendly Techniques to Extract Features from Image Data using Python','Liam.Cunningham','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Being Human in the Age of Artificial Intelligence','Liam.Cunningham','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Build your First Image Classification Model in just 10 Minutes!','Liam.Cunningham','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Build your First Multi-Label Image Classification Model in Python','Liam.Cunningham','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Data Mining: Practical Machine Learning Tools and Techniques','Liam.Cunningham','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Artificial Intelligence for Humans','Liam.Cunningham','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Artificial Intelligence: A Modern Approach','Liam.Cunningham','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Deep Learning with Python','Liam.Cunningham','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','10 Powerful Python Tricks for Data Science you Need to Try Today','Mahesh.Nayak','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','11 Important Model Evaluation Metrics for Machine Learning Everyone should know','Mahesh.Nayak','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','6 Useful Programming Languages for Data Science You Should Learn (that are not R and Python)','Mahesh.Nayak','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','8 Useful R Packages for Data Science You Aren’t Using (But Should!)','Mahesh.Nayak','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','A Hands-On Introduction to Time Series Classification (with Python Code)','Mahesh.Nayak','DataScience',''
			Exec dbo.w_sp_AddArticles  'custom','Ransomware attacks on the Internet of Things (IoT) devices','Tom.Hill','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','Security Audit Findings Spurring Organizational Change','Tom.Hill','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','Security Monitoring for Internal Intrusions ','Tom.Hill','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','Sinful Seven - Online Activities at Work','Tom.Hill','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','The Ethical Hacker’s Handbook','Tom.Hill','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','Trouble In Authentication Land','Tom.Hill','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','Why Would Anyone Want to Be a CIO?','Tom.Hill','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','Government surveillance expose corporate secrets','Lena.Headley','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','My Adventures as the World’s Most Wanted Hacker','Lena.Headley','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','One Plus One Equals Three','Lena.Headley','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','Fighting Back Against Phishing','Lena.Headley','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','A Practical Guide to Pretexting','Carice.Houten','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','AI-powered chatbots manipulate information','Carice.Houten','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','An Insidious Threat to Financial Institutions','Carice.Houten','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','Compromised blockchain systems','Carice.Houten','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','Cryptocurrency hijacking attacks reach new levels','Carice.Houten','Information Security',''
			Exec dbo.w_sp_AddArticles  'custom','Cyber warfare influencing global trade','Carice.Houten','Information Security',''
	END
	GO

-----Execution as below
	Exec dbo.w_sp_AddArticles_BULK

---- 6. w_Channel_User_Activity - Creation
	----- This Stored procedure inserts data into  w_Channel_User_Activity on two modes as simple & bulk
	----- Input value: @loadtype,@ArticleName,@UserName,@VisitorType,@DateViewed,@ViewTime
	----- Output : for simple mode, only one entry is made with gedate() as default dateviewed when No dataview passed; 
	-----		   for custom mode, same as above except it loads all possible articles an User may have viewed based on theier author subscription.This is drive historcal data analysis with more data set.

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_sp_AddUserActivity')
	BEGIN
		DROP PROCEDURE w_sp_AddUserActivity
	END
	GO

	CREATE PROCEDURE dbo.w_sp_AddUserActivity (@loadtype varchar(20),@ArticleName varchar(100),@UserName varchar(40), @VisitorType varchar(50),@DateViewed datetime,@ViewTime int)
	AS
	BEGIN
		--First, decare a variables to hold the IDs
		DECLARE @UserID int, @ArticleID int, @VisitorTypeID int,@UserActivityCount int

		Select @UserID = dbo.w_fn_UserIDLookup(@UserName)
		Select @VisitorTypeID = dbo.w_fn_VisitorTypeIDLookup(@VisitorType)
		Select @ArticleID = dbo.w_fn_ArticleIDLookup(@ArticleName)
		--Select @UserActivityCount = count(*) from dbo.w_Channel_User_Activity where UserID=@UserID and VisitorTypeID = @VisitorTypeID
		
		If (@loadtype ='simple') 
		
			BEGIN
			--Insert into the w_Channel_User_Activity with all values includding getdate() as default datetimeviewedon
				IF @ArticleID IS NOT NULL and @UserID IS NOT NULL
					BEGIN
						----Now we can add the row using an INSERT Statement
						INSERT INTO dbo.w_Channel_User_Activity (UserID,ArticleID,VisitorTypeID,DateTimeViewedOn,Page_Time_In_Minutes)
						Select 
							@UserID as UserID
							,@ArticleID as ArticleID
							,@VisitorTypeID as VisitorTypeID
							,IsNULL(@DateViewed,Getdate()) as DateTimeViewedOn
							,@ViewTime as Page_Time_In_Minutes
					END

			END

		If (@loadtype ='bulk') 
		
			BEGIN
			--Insert into the w_Channel_User_Activity with all values includding getdate() as default datetimeviewedon
				IF  @UserID IS NOT NULL and @VisitorTypeID IS NOT NULL 

					BEGIN
						
						delete 
						from dbo.w_Channel_User_Activity 
						where UserID=@UserID and VisitorTypeID = @VisitorTypeID

						----Now we can add the row using an INSERT Statement
						INSERT INTO dbo.w_Channel_User_Activity (UserID,ArticleID,VisitorTypeID,DateTimeViewedOn,Page_Time_In_Minutes)
						Select 
						U.UserID
						,A.ArticleID
						,@VisitorTypeID as VisitorTypeID
						,Case When A.DatePublished > F.DateSince Then A.DatePublished Else F.DateSince End as DateTimeViewedOn
						,@ViewTime as Page_Time_In_Minutes
						from dbo.w_Author_Followers F
						JOIN dbo.w_Channel_Articles  A on F.AuthorID = A.AuthorID
						JOIN dbo.w_Channel_Users U on F.UserID = U.UserID
						Where U.UserName = @UserName and U.IsAuthor =0

					END

			END
	END
	GO

	----Simple insert into w_sp_AddUserActivity
	----(@loadtype varchar(20),@ArticleName varchar(100),@UserName varchar(40), @VisitorType varchar(50),@ViewTime int)
	----- @DateViewed datetime is Optional - takes getdate() by default
	Exec dbo.w_sp_AddUserActivity 'simple','How Businesses are Using Machine Learning and AI','Amitesh.Kumar','Subscriber','',10   
	----Bulk insert into w_sp_AddUserActivity
	----Inserts all combination based on all Articles published by author who the User is following
	Exec dbo.w_sp_AddUserActivity 'bulk','','Amitesh.Kumar','Subscriber','',10

---	select * from dbo.w_Channel_User_Activity

----- 7. w_sp_AddUserActivitys_BULK - Creation
	----- This Stored procedure executes w_sp_AddUserActivity procedure on custom mode to perform Bulk Inserts into w_Channel_User_Activity
	---- table
	----- Input Values were based on raw data prepared for better data analysis.

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_sp_AddUserActivitys_BULK')
	BEGIN
		DROP PROCEDURE w_sp_AddUserActivitys_BULK
	END
	GO

	Create Procedure [dbo].[w_sp_AddUserActivitys_BULK] AS
	BEGIN
			------Block 1  -------
	----Exec dbo.w_sp_AddUserActivity 'bulk','','Amitesh.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Amitesh.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Anjali.Baranwal','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Anshuman.Mishra','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Scarlett.Johnson','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Deepthi.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Dhanasekara.Pandian','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Fathima.Zahera','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Jai.Ganesh','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Joseph.Gonsalves','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Kamalakkannan.Kandswamy','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Karthik.Ramani','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Kishore.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Krishna.Swamy','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Kumar.Anupam','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Madhuri.Dixit','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Manish.Patel','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Manodip.Acharya','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Manu.Jayaraj','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Mathew.Varghese','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Mitul.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Chloe.Bennet','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Ming.Wen','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Elizabeth.Hegde','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Henry.Simmons','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Jeff.Ward','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Stan.Lee','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Nick.Blood','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Luke.Mitchell','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Nirmala.Ramani','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Nishit.Rai','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Padmini.Rangam','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Paritosh.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Parmar.Singh','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Patraksha.Sarkar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Pavithra.Prem','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','PavithraManjunath.Manjunath','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Piyush.Goyal','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Piyush.Kantilal','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Ponnammal.Ramachandran','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Prabath.Kantilal','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Pradeep.Diwanji','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','PradeepKumar.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Pragya.Jha','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Rajshekhar.Aurade','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Rohith.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sandeep.Ramesh','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sharat.Patel','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Shriman.Mishra','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Siddhartha.Moghe','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sobhan.Mahapatra','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sovan.Pratihar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sreejith.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','SREENIVASALU.Rao','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Srikanth.Mallya','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','SRIKANTHA.Reddy','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Subramanya.Rao','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Subramonian.Swamy','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sudeep.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sudhir.Prabhu','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sugeesh.Chandran','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Suhas.Kini','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sukeshini.Kumari','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Suma.Meda','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sumanth.Rao','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sunand.Sahu','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sunil.Narayan','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sunil.Sharma','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Supriya.Prasad','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Suresh.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sushma.Numula','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Tejendra.Gupta','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Thulasidhar.Reddy','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','TUSHAR.Tamboli','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Udayasree.Narayan','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Usha.Sharma','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vaibhav.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vaibhav.Saxena','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vasant.Ghooli','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Veena.Mehta','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vijay.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vijaya.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vijaykumar.Peddibhotla','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vijaykumar.Sadhana','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vinayak.Kumashi','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vinayaka.Venkat','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vishal.Tyagi','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vishnu.Reddy','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Vishwas.Kumar','Subscriber','',10
	Exec dbo.w_sp_AddUserActivity  'bulk','','Sachin.Yadav','Subscriber','',10
	END
	GO

	----To Insert more records by executing the procedure below
	Exec dbo.w_sp_AddUserActivitys_BULK

---- 8. w_sp_Update_Tier_Level - Creation
	----- This Stored procedure Updates TierLevel Info ; Value of Min_Followers is driven by TierLevelName
	----- Input value: @@TierLevel,@Minimum_Followers
	----- Output : Min_Followers is updated

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_sp_Update_Tier_Level')
	BEGIN
		DROP PROCEDURE w_sp_Update_Tier_Level
	END
	GO

	CREATE PROCEDURE dbo.w_sp_Update_Tier_Level (@TierLevel varchar(50), @Minimum_Followers varchar (100))
	AS
	BEGIN
		--First, decare a variables to hold the IDs
		DECLARE @TierLevelID int

		Select @TierLevelID = TierLevelID from dbo.w_Author_Tier_Level where TierLevelName =@TierLevel
		
		If (@TierLevelID > 0) 
		
			BEGIN
				Update T
				Set T.Minimum_Followers = @Minimum_Followers
				FROM dbo.w_Author_Tier_Level T
				Where T.TierLevelName = @TierLevel
			END
	END
	
	GO

	EXEC dbo.w_sp_Update_Tier_Level 'Bronze', '0 to 5'
	EXEC dbo.w_sp_Update_Tier_Level 'Silver', '6 to 14'
	EXEC dbo.w_sp_Update_Tier_Level 'Gold', '15 to 21'
	EXEC dbo.w_sp_Update_Tier_Level 'Platinum', '22 to 29'
	EXEC dbo.w_sp_Update_Tier_Level 'Diamond', '30 and above'

---- 9. w_sp_Update_Author_TierLevel - Creation
	----- This Stored procedure Updates TierLevel Info on the Authors tables based on the number of followers each author has
	----- CTE used to Uodate
	----- Output : Bulk Update on w_Channel_Authors table

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_sp_Update_Author_TierLevel')
		BEGIN
			DROP PROCEDURE w_sp_Update_Author_TierLevel
		END
		GO

		CREATE PROCEDURE dbo.w_sp_Update_Author_TierLevel
		AS
		BEGIN

			WITH CTE_TierLevel
			AS
			(
			Select 
			U.UserID
			,U.UserName
			,Case When count(F.UserID) < 6 then 'Bronze'
				When count(F.UserID) between 6 and 14  then 'Silver'
				When count(F.UserID) between 15 and 21  then 'Gold'
				When count(F.UserID) between 22 and 29  then 'Platinum'
				When count(F.UserID) >=30  then 'Diamond'
			End as TierLevel
			from dbo.w_Author_Followers F
			Join dbo.w_Channel_Authors A on F.AuthorID=A.AuthorID
			Join dbo.w_Channel_Users U on A.AuthorID=U.UserID
			Group by 
				U.UserID
			,U.UserName
			) 

			UPDATE A
			SET A.TierLevelID = TL.TierLevelID
			FROM CTE_TierLevel T 
			Join dbo.w_Author_Tier_Level TL on T.TierLevel=TL.TierLevelName
			Join dbo.w_Channel_Authors A  on T.UserID=A.AuthorID

		END
	GO

	----Procedure Execution - No parameters required
	EXEC dbo.w_sp_Update_Author_TierLevel

/********************************  Stored Procedures Creation - Ends ******************************************

***************************************************************************************************************
									Data Question - Begins |SQL Views

		SQL Views:
			1. Most Viewed Articles by Category
			2. Authors with greater number of Followers based on thier TierLevel
			3. List Number of Articles by Category
			4. Most Valued Users 
			5. Contributions by Author having more than 10 Articles
			---- Articles Published trend Over Year, Quarter, Month and Day level
			6. YTD Yearly Spread of Articles
			7.YTD Quarterly Spread of Articles
			8. YTD Monthly Spread of Articles
			9. YTD Daily Trend : Published vs Viewed
************************************************************************************************

********************************  SQL Views Creation - Begins ***************************/

-----1. Most Viewed Articles by Category

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='w_vw_Most_Viewed_Articles_by_Category')
	BEGIN
		DROP VIEW w_vw_Most_Viewed_Articles_by_Category
	END
	GO

	CREATE VIEW dbo.w_vw_Most_Viewed_Articles_by_Category
	AS
		Select
		  C.CategoryName
		, Count(Act.ArticleID) Articles_Viewed
		From 
		dbo.w_Channel_User_Activity Act
		Join dbo.w_Channel_Articles A on Act.ArticleID=A.ArticleID
		Join dbo.w_Article_Category C on A.CategoryID = C.CategoryID
		Group by C.CategoryName 
	 GO

	----Retrive values from the w_vw_Most_Viewed_Articles_by_Category View 
		SELECT 
			 CategoryName
			,Articles_Viewed 
		FROM dbo.w_vw_Most_Viewed_Articles_by_Category
		Order by 
			Articles_Viewed desc
		GO

	-----2. Authors with greater number of Followers based on thier TierLevel

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='w_vw_Authors_by_TierLevel')
	BEGIN
		DROP VIEW w_vw_Authors_by_TierLevel
	END
	GO

	CREATE VIEW dbo.w_vw_Authors_by_TierLevel
	AS
		Select 
			 U.UserName AuthorName
			,T.TierLevelName
			,T.Minimum_Followers
			,count(F.UserID) as Current_Followers
		from dbo.w_Author_Followers F
		Join dbo.w_Channel_Authors A on F.AuthorID=A.AuthorID
		Join dbo.w_Author_Tier_Level T on A.TierLevelID=T.TierLevelID
		Join dbo.w_Channel_Users U on A.AuthorID=U.UserID
		Group by 
			 U.UserName
			,T.TierLevelName
			,T.Minimum_Followers
	 GO

	----Retrive values from the w_vw_Authors_by_TierLevel View 
		SELECT 
			 AuthorName
			,TierLevelName
			-----,Minimum_Followers
			----,Current_Followers 
		FROM 
			dbo.w_vw_Authors_by_TierLevel
		Order by 
			Current_Followers desc
		GO

----3. List Number of Articles by Category
	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='w_vw_Nbr_Of_Articles_by_Category')
	BEGIN
		DROP VIEW w_vw_Nbr_Of_Articles_by_Category
	END
	GO

	CREATE VIEW dbo.w_vw_Nbr_Of_Articles_by_Category
	AS

		Select
		  C.CategoryName
		, Count(A.ArticleID) Nbr_Of_Articles
		From 
				dbo.w_Channel_Articles A 
		Join dbo.w_Article_Category C on A.CategoryID = C.CategoryID
		Group by C.CategoryName 
	 GO

	----Retrive values from the w_vw_Nbr_Of_Articles_by_Category View 
		Select
		  CategoryName
		, Nbr_Of_Articles
		From 
			w_vw_Nbr_Of_Articles_by_Category
		Order by Nbr_Of_Articles desc

----4. Most Valued Users 
	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='w_vw_Top_5_Viewers')
	BEGIN
		DROP VIEW w_vw_Top_5_Viewers
	END
	GO

	CREATE VIEW dbo.w_vw_Top_5_Viewers
	AS
		Select top 5
		 U.UserName
		,Count(A.ArticleID) Nbr_Of_Articles
		From 
				dbo.w_Channel_User_Activity A 
		Join dbo.w_Channel_Users U on A.UserID=U.UserID
		Where U.IsAuthor = 0
		Group by U.UserName 
	 GO
	----Retrive values from the w_vw_Top_5_Viewers View 
		Select
		  UserName
		, Nbr_Of_Articles
		From 
			w_vw_Top_5_Viewers
		Order by Nbr_Of_Articles desc
		
----5. Contributions by Author having more than 10 Articles

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='w_vw_Topline_Contributors')
	BEGIN
		DROP VIEW w_vw_Topline_Contributors
	END
	GO

	CREATE VIEW dbo.w_vw_Topline_Contributors
	AS

		Select 
		  U.UserName as AuthorName
		, Count(A.ArticleID) Nbr_Of_Articles
		From 
				dbo.w_Channel_Articles A 
		Join dbo.w_Channel_Users U on A.AuthorID = U.UserID
		Where U.IsAuthor = 'true'
		Group by U.UserName having Count(A.ArticleID) >=10 
	
	 GO

	----Retrive values from the w_vw_Topline_Contributors View 
		Select
		  AuthorName
		, Nbr_Of_Articles
		From 
			w_vw_Topline_Contributors
		Order by Nbr_Of_Articles desc
	
----6. YTD Yearly Spread of Articles
			
	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='w_vw_YTD_Articles_Trend')
	BEGIN
		DROP VIEW w_vw_YTD_Articles_Trend
	END
	GO

	CREATE VIEW dbo.w_vw_YTD_Articles_Trend
	AS
		Select 
		 Datepart(year,A.DatePublished) As Year_Published
		,Count(A.ArticleID) Nbr_Of_Articles
		From 
				dbo.w_Channel_Articles A 
		Group by Datepart(year,A.DatePublished)
   	 GO
	 ----Retrive values from the w_vw_YTD_Articles_Trend View 
		Select
		  Year_Published
		, Nbr_Of_Articles
		From 
			w_vw_YTD_Articles_Trend
		 Order by Year_Published
 
----7. YTD Quarterly Spread of Articles
			
	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='w_vw_QTD_Articles_Trend')
	BEGIN
		DROP VIEW w_vw_QTD_Articles_Trend
	END
	GO

	CREATE VIEW dbo.w_vw_QTD_Articles_Trend
	AS
		Select 
		 Datepart(year,A.DatePublished) As Year_Published
		,'Q'+ cast(Datepart(quarter,A.DatePublished) as varchar) As Quarter_Published
		,Count(A.ArticleID) Nbr_Of_Articles
		From 
				dbo.w_Channel_Articles A 
		Group by Datepart(year,A.DatePublished),Datepart(quarter,A.DatePublished)

   	 GO
	 ----Retrive values from the w_vw_QTD_Articles_Trend View 
		Select
		  Year_Published
		, Quarter_Published
		,Nbr_Of_Articles
		From 
			w_vw_QTD_Articles_Trend
		 Order by Year_Published ,Quarter_Published

----8. YTD Monthly Spread of Articles

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='w_vw_Monthly_Articles_Trend')
	BEGIN
		DROP VIEW w_vw_Monthly_Articles_Trend
	END
	GO

	CREATE VIEW dbo.w_vw_Monthly_Articles_Trend
	AS
	
		Select 
		 Datepart(year,A.DatePublished) As Year_Published
		,Datepart(month,A.DatePublished) As Month_Published
		,Datename(month,A.DatePublished) As MonthName_Published
		,Count(A.ArticleID) Nbr_Of_Articles
		From 
				dbo.w_Channel_Articles A 
		Group by Datepart(year,A.DatePublished),Datepart(month,A.DatePublished),Datename(month,A.DatePublished)
	
   	GO
	 ----Retrive values from the w_vw_Monthly_Articles_Trend View 
		Select
		  Year_Published
		, Month_Published
		, MonthName_Published
		, Nbr_Of_Articles
		From 
			w_vw_Monthly_Articles_Trend
		Order by Year_Published, Month_Published

----9. YTD Daily Trend : Published vs Viewed

	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='w_vw_Daily_Published_vs_Viewed_Trend')
	BEGIN
		DROP VIEW w_vw_Daily_Published_vs_Viewed_Trend
	END
	GO

	CREATE VIEW dbo.w_vw_Daily_Published_vs_Viewed_Trend
	AS
		WITH Articles_Published_vs_Viewed
		AS
		(Select
		  Datepart(dw,Act.DateTimeViewedOn) As Days_of_Week
		, Datename(dw,Act.DateTimeViewedOn) As Day_of_Week
		, Count(Act.ArticleID) As Articles_Viewed
		, 0 As Articles_Published
		From 
		dbo.w_Channel_User_Activity Act
		Group by Datepart(dw,Act.DateTimeViewedOn),Datename(dw,Act.DateTimeViewedOn) 
		UNION ALL
		Select
		  Datepart(dw,A.DatePublished) As Days_of_Week
		, Datename(dw,A.DatePublished) As Day_of_Week
		, 0 As Articles_Viewed
		, Count(A.ArticleID) As Articles_Published
		From 
		dbo.w_Channel_Articles A 
		Group by  Datepart(dw,A.DatePublished),Datename(dw,A.DatePublished)
		)

		Select 
		  Days_of_Week,Day_of_Week
		, sum(Articles_Published) as Articles_Published
		, sum(Articles_Viewed) as Articles_Viewed
		From Articles_Published_vs_Viewed
		Group by Days_of_Week,Day_of_Week
   	GO
		 ----Retrive values from the w_vw_Daily_Published_vs_Viewed_Trend View 
		Select 
		   Days_of_Week
		  ,Day_of_Week
		  ,Articles_Published
		  ,Articles_Viewed
		From
		dbo.w_vw_Daily_Published_vs_Viewed_Trend
		Order by Days_of_Week, Day_of_Week