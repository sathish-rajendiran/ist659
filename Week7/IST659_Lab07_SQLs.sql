USE [IST659_M406_srajendi]
GO

/*
	Title	:	Lab 07 - SQL Scripts
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	February 2020

	
*/ 

----Part 1: Display Users who have made VidCasts

SELECT
	 USR.UserName
	,USR.EmailAddress
	,VidCast.vc_VidCastID
FROM dbo.vc_VidCast as VidCast
 Join dbo.vc_User as USR ON USR.vc_UserID=VidCast.vc_UserID
Order by USR.UserName


----Look for users who have not yet made any VidCasts
Select  * From dbo.vc_User
Where vc_UserID NOT IN (Select vc_UserID from dbo.vc_VidCast)


----Display all users including those with No VidCasts | Be sure to include all vc_User records

SELECT
	 USR.UserName
	,USR.EmailAddress
	,VidCast.vc_VidCastID
FROM dbo.vc_VidCast as VidCast
RIGHT Join dbo.vc_User as USR ON USR.vc_UserID=VidCast.vc_UserID
Order by USR.UserName

----High-level descriptive statisticss for vc_VidCast
Select
  Count(vc_VidCastID) as NumberOfVidCasts
 ,Sum(ScheduleDurationMinutes) as TotalScheduledMinutes
 ,Min(ScheduleDurationMinutes) as MinScheduledMinutes
 ,Avg(ScheduleDurationMinutes) as AvgScheduledMinutes
 ,Max(ScheduleDurationMinutes) as MaxScheduledMinutes
From dbo.vc_VidCast

----Aggregate CountOfVidCasts 
SELECT
	 USR.UserName
	,USR.EmailAddress
	,count(VidCast.vc_VidCastID) as CountofVidCasts
FROM dbo.vc_VidCast as VidCast
RIGHT Join dbo.vc_User as USR ON USR.vc_UserID=VidCast.vc_UserID
Group by 
	 USR.UserName
	,USR.EmailAddress
Order by USR.UserName 

----Aggregate CountOfVidCasts and order by those with maximum VidCasts
SELECT
	 USR.UserName
	,USR.EmailAddress
	,count(VidCast.vc_VidCastID) as CountofVidCasts
FROM dbo.vc_VidCast as VidCast
RIGHT Join dbo.vc_User as USR ON USR.vc_UserID=VidCast.vc_UserID
Group by 
	 USR.UserName
	,USR.EmailAddress
Order by CountofVidCasts desc,USR.UserName 


----Display Users with <10 VidCasts | Our least prolific users

SELECT
	 USR.UserName
	,USR.EmailAddress
	,count(VidCast.vc_VidCastID) as CountofVidCasts
FROM dbo.vc_VidCast as VidCast
RIGHT Join dbo.vc_User as USR ON USR.vc_UserID=VidCast.vc_UserID
Group by 
	 USR.UserName
	,USR.EmailAddress
Having count(VidCast.vc_VidCastID) <10
Order by CountofVidCasts desc,USR.UserName 

--Actual duration of Finished VidCasts between two dates
SELECT
	 USR.UserName
	,USR.EmailAddress
	,Sum(DateDiff(n,StartDatetime,EndDateTime)) as SumActualDurationMinutes
FROM dbo.vc_VidCast as VidCast
 Join dbo.vc_User as USR ON USR.vc_UserID=VidCast.vc_UserID
 Join dbo.vc_Status as VStatus ON VStatus.vc_StatusID=VidCast.vc_StatusID
Where VStatus.StatusText = 'Finished'
Group by 
	 USR.UserName
	,USR.EmailAddress
Order by USR.UserName 


----Part 2: More descriptive statistics for VidCast results
SELECT
	 USR.UserName
	,USR.EmailAddress
	,Sum(DateDiff(n,StartDatetime,EndDateTime)) as SumActualDurationMinutes
	,Count(vc_VidCastID) as CountOfVidCasts
    ,Min(DateDiff(n,StartDatetime,EndDateTime)) as MinActualDurationMinutes
	,Avg(DateDiff(n,StartDatetime,EndDateTime)) as AvgActualDurationMinutes
	,Max(DateDiff(n,StartDatetime,EndDateTime)) as MaxActualDurationMinutes
FROM dbo.vc_VidCast as VidCast
 Join dbo.vc_User as USR ON USR.vc_UserID=VidCast.vc_UserID
 Join dbo.vc_Status as VStatus ON VStatus.vc_StatusID=VidCast.vc_StatusID
Where VStatus.StatusText = 'Finished' --and vc_User.UserName='ecstatic'
Group by 
	 USR.UserName
	,USR.EmailAddress
Order by CountofVidCasts desc,USR.UserName 



