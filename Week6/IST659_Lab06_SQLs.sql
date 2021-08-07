USE [IST659_M406_srajendi]
GO

/*
	Title	:	Lab 05 -SQL Scripts
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	January, 2020

	
*/

--The Following line shows all of the rows in vc_Status
Select * from dbo.vc_Status

-- Adding a row to the vc_Status table
--Insert into dbo.vc_Status (StatusText)
--Values('Scheduled')
--GO


-- Adding three more rows to the vc_Status table
--Insert into dbo.vc_Status (StatusText)
--Values('Started'),('Finished'),('On time')
--GO

select * from dbo.vc_User where UserName ='SaulHudson'
Select * from dbo.vc_Status where StatusText ='Finished'

--Adding a vidcast record to the VidCast Table
--Insert into vc_VidCast
--(VidCastTitle,StartDateTime,EndDateTime,ScheduledDurationMinutes,RecordingURL,vc_UserID,vc_StatusID)
--Values
--('December Snow','3/1/2018 14:00','3/1/2018 14:30',30,'/XVF1234',2,3)
--GO

--The Following line shows all of the rows in vc_VidCast
Select * from dbo.vc_VidCast

--The Following line shows Saul's First VidCast
Select
 vc_User.UserName
,vc_User.EmailAddress
,vc_VidCast.VidCastTitle
,vc_VidCast.StartDateTime
,vc_VidCast.EndDateTime
,vc_VidCast.ScheduledDurationMinutes/60.0 as ScheduledHours
,vc_Status.StatusText
from  dbo.vc_VidCast
Join dbo.vc_User on vc_VidCast.vc_UserID=vc_User.vc_UserID
join dbo.vc_Status on vc_VidCast.vc_StatusID=vc_Status.vc_StatusID
Where vc_User.UserName='SaulHudson'
Order by vc_VidCast.StartDateTime
--GO

--Correcting a User's UserRegisteredDate
--Update dbo.vc_User SET UserRegisteredDate ='3/1/2018' Where UserName='SaulHudson'
--Go

Select * from dbo.vc_User Where UserName ='SaulHudson'


--See What Rows we have in Status
Select * from dbo.vc_Status

--Delete the 'On time' status
--Delete dbo.vc_Status where StatusText='On time'
--GO
--See the effect
Select * from dbo.vc_Status

--- Adding records to vc_Tag table

--Insert into dbo.vc_Tag
--(TagText,TagDescription)
--Values
-- ('Personal','About people')
--,('Professional','Business, business, business')
--,('Sports','All manner of sports')
--,('Music','Music analysis, news, and thoughts')
--,('Games','Live streaming our favorite games')
--GO
--lets see about the newly added Tags
select * from dbo.vc_Tag

--Adding more data to the User table
--Insert Into dbo.vc_User(UserName,EmailAddress,UserDescription)
--	Values
--		  ('TheDoctor','tomBaker@nodomain.xyz','The definite article'),
--		  ('HairCut','S.todd@nodomain.xyz','Fleet Street barber shop'),
--		  ('DnDGal','dnd@nodomain.xyz',NULL)
--GO

--List all rows from User Table
select * from dbo.vc_User

---Insert to User Tag List as in Appendix B
--INSERT INTO dbo.vc_UserTagList (vc_UserID, vc_TagID)
--VALUES
--((SELECT vc_UserID FROM vc_User WHERE UserName='DnDGal'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Sports')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='DnDGal'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Professional')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='RDwight'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Professional')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='SaulHudson'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Sports')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='Gordon'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Personal')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='DnDGal'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Personal')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='Gordon'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Games')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='HairCut'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Professional')), ((SELECT vc_UserID FROM vc_User WHERE UserName='TheDoctor'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Music')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='DnDGal'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Games')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='SaulHudson'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Games')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='Gordon'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Professional')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='HairCut'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Music')),
--((SELECT vc_UserID FROM vc_User WHERE UserName='TheDoctor'),
--(SELECT vc_TagID FROM vc_Tag WHERE TagText='Personal'))
--GO

Select * from dbo.vc_UserTagList
--The Following line shows User Tags Report
Select
 vc_User.UserName
,vc_User.EmailAddress
,vc_Tag.TagText
from  dbo.vc_UserTagList
Join dbo.vc_Tag on vc_Tag.vc_TagID = vc_UserTagList.vc_TagID
Join dbo.vc_User on vc_User.vc_UserID=vc_UserTagList.vc_UserID
Order by vc_User.UserName,vc_Tag.TagText
--GO

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