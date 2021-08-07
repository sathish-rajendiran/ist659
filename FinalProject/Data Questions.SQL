USE [IST659_M406_srajendi]
GO


/*****************************************************************************************************

	Title	:	WikiChannel - Main Project  - Data Questions
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	March, 2020
******************************************************************************************************

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

10. Most Viewed Articles 

*/
-----1. Most Viewed Articles by Category
	Select
	  C.CategoryName
	, Count(Act.ArticleID) Articles
	From 
	dbo.w_Channel_User_Activity Act
	Join dbo.w_Channel_Articles A on Act.ArticleID=A.ArticleID
	Join dbo.w_Article_Category C on A.CategoryID = C.CategoryID
	Group by C.CategoryName Order by Articles desc

-----2. Authors with greater number of Followers based on thier TierLevel
----Needs update Statement
	Select 
		 U.UserName
		,T.TierLevelName
		,T.Minimum_Followers
		,count(F.UserID) as Followers
	from dbo.w_Author_Followers F
	Join dbo.w_Channel_Authors A on F.AuthorID=A.AuthorID
	Join dbo.w_Author_Tier_Level T on A.TierLevelID=T.TierLevelID
	Join dbo.w_Channel_Users U on A.AuthorID=U.UserID
	Group by 
		U.UserName
		,T.TierLevelName
		,T.Minimum_Followers
	order by Followers desc

----3. List Number of Articles by Category
	Select
	  C.CategoryName
	, Count(A.ArticleID) Articles
	From 
			dbo.w_Channel_Articles A 
	Join dbo.w_Article_Category C on A.CategoryID = C.CategoryID
	Group by C.CategoryName Order by Articles desc

----4. Most Valued Users 
	Select top 5
	 U.UserName
	,Count(A.ArticleID) Articles
	From 
			dbo.w_Channel_User_Activity A 
	Join dbo.w_Channel_Users U on A.UserID=U.UserID
	Where U.IsAuthor = 0
	Group by U.UserName Order by Articles desc

----5. Contributions by Author having more than 10 Articles
	Select 
	  U.UserName as AuthorName
	, Count(A.ArticleID) Articles
	From 
			dbo.w_Channel_Articles A 
	Join dbo.w_Channel_Users U on A.AuthorID = U.UserID
	Where U.IsAuthor = 'true'
	Group by U.UserName having Count(A.ArticleID) >=10 
	Order by Articles desc

---- Articles Published trend Over Year, Quarter, Month and Day level

----6. YTD Yearly Spread of Articles
	Select 
	 Datepart(year,A.DatePublished) As Year_Published
	,Count(A.ArticleID) Articles
	From 
			dbo.w_Channel_Articles A 
	Group by Datepart(year,A.DatePublished)
    Order by Year_Published 


----7. YTD Quarterly Spread of Articles
	Select 
	 Datepart(year,A.DatePublished) As Year_Published
	,'Q'+ cast(Datepart(quarter,A.DatePublished) as varchar) As Quarter_Published
	,Count(A.ArticleID) Articles
	From 
			dbo.w_Channel_Articles A 
    Group by Datepart(year,A.DatePublished),Datepart(quarter,A.DatePublished)
    Order by Year_Published ,Quarter_Published

----8. YTD Monthly Spread of Articles
	Select 
	 Datepart(year,A.DatePublished) As Year_Published
	,Datepart(month,A.DatePublished) As Month_Published
	,Datename(month,A.DatePublished) As MonthName_Published
	,Count(A.ArticleID) Articles
	From 
			dbo.w_Channel_Articles A 
	Group by Datepart(year,A.DatePublished),Datepart(month,A.DatePublished),Datename(month,A.DatePublished)
    Order by Year_Published, Month_Published

----9. YTD Daily Trend : Published vs Viewed

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
	Order by Days_of_Week

-------10. Most Viewed Articles 
----Select top 10
---- A.ArticleName
----,Count(Act.UserActivityID) Views
----From 
----		dbo.w_Channel_User_Activity Act
----Join dbo.w_Channel_Articles A On Act.ArticleID=A.ArticleID
----Group by A.ArticleName Order by Views desc

----Tables Involved
select top 2 * from dbo.w_Channel_Articles
select top 2 * from dbo.w_Channel_Users
select top 2 * from dbo.w_Channel_Authors
select top 2 * from dbo.w_Channel_User_Activity 
select * from dbo.w_Author_Tier_Level
select * from dbo.w_Article_Category


		
       UPDATE
		[account]
	SET
		balance =
		(
			CASE
				WHEN
					((balance - 10.00) < 0)
				THEN
					0
				ELSE
					(balance - 10.00)
			END
		)
	WHERE
		id = 1
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
		--Join dbo.w_Author_Tier_Level T on A.TierLevelID=T.TierLevelID
		Join dbo.w_Channel_Users U on A.AuthorID=U.UserID
		Group by 
			U.UserID
		   ,U.UserName
		  -- ,T.TierLevelID
		) 

		--select A.TierLevelID,TL.TierLevelID,A.AuthorID
		--FROM  CTE_TierLevel T 
		--Join dbo.w_Author_Tier_Level TL on T.TierLevel=TL.TierLevelName
		--Join dbo.w_Channel_Authors A  on T.UserID=A.AuthorID

		UPDATE A
		SET A.TierLevelID = TL.TierLevelID
		FROM CTE_TierLevel T 
		Join dbo.w_Author_Tier_Level TL on T.TierLevel=TL.TierLevelName
		Join dbo.w_Channel_Authors A  on T.UserID=A.AuthorID

	END
GO

EXEC dbo.w_sp_Update_Author_TierLevel