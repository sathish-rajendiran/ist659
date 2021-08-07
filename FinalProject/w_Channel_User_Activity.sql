
Select * from w_Channel_User_Activity Go;

Select * from w_Channel_User_Activity Go;

Select 
 U.UserName
,U.UserID
,A.ArticleName
,A.ArticleID
--,C.CategoryName
--,U.IsAuthor
--,F.DateSince
,(Select VisitorTypeID from dbo.w_Channel_VisitorType where VisitorTypeName='Subscriber') as VisitorTypeID
--,A.DatePublished
,Case When A.DatePublished> F.DateSince Then A.DatePublished Else F.DateSince End as DateTimeViewedOn
,'10' as Page_Time_In_Minutes
from dbo.w_Author_Followers F
JOIN dbo.w_Channel_Articles  A on F.AuthorID = A.AuthorID
JOIN dbo.w_Channel_Users U on F.UserID = U.UserID
JOIN dbo.w_Article_Category C on A.CategoryID = C.CategoryID
Where U.UserName ='Stan.Lee' and U.IsAuthor =0


----- 3. Popluate w_Channel_User_Activity Table

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME='w_sp_AddUserActivity')
BEGIN
	DROP PROCEDURE w_sp_AddUserActivity
END
GO

CREATE PROCEDURE dbo.w_sp_AddUserActivity (@loadtype varchar(20),@ArticleName varchar(100),@UserName varchar(40), @VisitorTypeName varchar(50),@DateViewed datetime,@ViewTime int)
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

	If (@loadtype ='Simple') 
	
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

	If (@loadtype ='bulk')
	
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


