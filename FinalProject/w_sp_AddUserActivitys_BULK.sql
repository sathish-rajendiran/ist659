USE [IST659_M406_srajendi]
GO

/****** Object:  StoredProcedure [dbo].[w_sp_AddUserActivitys_BULK]    Script Date: 3/16/2020 2:28:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
	Title	:	WikiChannel - Main Project - More inserts on w_Channel_User_Activity table
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	March, 2020
*/


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


