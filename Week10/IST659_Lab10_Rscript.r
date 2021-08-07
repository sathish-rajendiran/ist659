#ready RODBC for use in this script
require(RODBC)

#create a connection to SQL Server using our 64 bit DSN
myconn <- odbcConnect("VidCast64")

# Ready the SQL to send to the server

sqlselectstatement <- 
  "SELECT
	 VC.vc_VidCastID
	,VC.VidCastTitle
	,DATEPART(dw,VC.StartDateTime) as StartDayOfWeek
	,DateDiff(n,VC.StartDatetime,VC.EndDateTime) as ActualDuration
	,VC.ScheduleDurationMinutes
	,USR.vc_UserID
	,USR.UserName
FROM dbo.vc_VidCast as VC
 Join dbo.vc_User as USR ON USR.vc_UserID=VC.vc_UserID 
"
#send  the request to the server and store the results in a variabe
sqlresult <- sqlQuery(myconn,sqlselectstatement)

#Create a list of days of week for charting later
days <- c("Sun","MOn","Tue","Wed","Thu","Fri","Sat")

#Create a Histogram of durations (appears in the Plots tab)
hist(sqlresult$ActualDuration,
     main = "srajendi How long are the VidCasts?",
     xlab = "Minutes",
     ylab = "VidCasts",
     border = "blue",
     col = "grey",
     labels = TRUE
)
#Plot a bar chart of vidoe counts by day of the week
daycounts <- table(sqlresult$StartDayOfWeek)
barplot(daycounts,
        main = "srajendi VidCasts by Day of Week",
        ylab = "Day of Week",
        xlab = "Count of VidCasts",
        border = "blue",
        names.arg = days)


#close all connections
odbcCloseAll()

#Fin
     



