USE [IST659_M406_srajendi]
GO

/*
	Title	:	Lab 10 -SQL Scripts
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	March, 2020

*/

----The Following line shows all of the rows for UserName "tardy" 

Select
	 USR.UserName
	,UL.*
From dbo.vc_User USR
Join dbo.vc_UserLogin UL
on USR.vc_UserID=UL.vc_UserID
Where Lower(USR.UserName) ='tardy'


SELECT
	distinct
	 DATEPART(dw,VC.StartDateTime) as StartDayOfWeek
	,Datename(dw,VC.StartDateTime) as StartDayNameOfWeek
	,VC.StartDatetime
	,DateDiff(n,VC.StartDatetime,VC.EndDateTime) as ActualDuration
	,VC.ScheduleDurationMinutes
	,USR.vc_UserID
	,USR.UserName
FROM dbo.vc_VidCast as VC
 Join dbo.vc_User as USR ON USR.vc_UserID=VC.vc_UserID 

 SELECT
	 VC.vc_VidCastID
	,VC.VidCastTitle
	,DATEPART(dw,VC.StartDateTime) as StartDayOfWeek
	,DateDiff(n,VC.StartDatetime,VC.EndDateTime) as ActualDuration
	,VC.ScheduleDurationMinutes
	,USR.vc_UserID
	,USR.UserName
FROM dbo.vc_VidCast as VC
 Join dbo.vc_User as USR ON USR.vc_UserID=VC.vc_UserID 