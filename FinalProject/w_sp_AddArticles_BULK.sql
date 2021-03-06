USE [IST659_M406_srajendi]
GO

/****** Object:  StoredProcedure [dbo].[w_sp_AddArticles_BULK]    Script Date: 3/16/2020 2:28:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
	Title	:	WikiChannel - Main Project - More inserts on w_Channel_Articles table
	Author	:	Sathish Kumar Rajendiran
	Course	:	IST659	M406
	Term	:	March, 2020

*/

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
		Exec dbo.w_sp_AddArticles  'custom','A Practitioner???s Guide to Business Analytics','Gwen.Christie','Data Analysis',''
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
		Exec dbo.w_sp_AddArticles  'custom','The Data Vault ??? What is it? ??? Why do we need it?','Nathalie.Emmanuel','Database Management',''
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
		Exec dbo.w_sp_AddArticles  'custom','Extract-Transform-Load (ETL) Technologies ??? Part 1','Iain.Glen','Database Management',''
		Exec dbo.w_sp_AddArticles  'custom','Extract-Transform-Load (ETL) Technologies ??? Part 2','Iain.Glen','Database Management',''
		Exec dbo.w_sp_AddArticles  'custom','Best Database Management Systems','Iain.Glen','Database Management',''
		Exec dbo.w_sp_AddArticles  'custom','Column Oriented Database Technologies','Iain.Glen','Database Management',''
		Exec dbo.w_sp_AddArticles  'custom','Extract-Transform-Load (ETL) Technologies ??? Part 3','Iain.Glen','Database Management',''
		Exec dbo.w_sp_AddArticles  'custom','How to Raise an Exception in SQL Server User Defined Functions','John.Bradley','Database Management',''
		Exec dbo.w_sp_AddArticles  'custom','Fundamentals of Database Systems','John.Bradley','Database Management',''
		Exec dbo.w_sp_AddArticles  'custom','Getting in Front on Data','John.Bradley','Database Management',''
		Exec dbo.w_sp_AddArticles  'custom','Head First SQL: Your Brain on SQL','John.Bradley','Database Management',''
		Exec dbo.w_sp_AddArticles  'custom','How to Create Autonomous Transactions in SQL Server','John.Bradley','Database Management',''
		Exec dbo.w_sp_AddArticles  'custom','Mathematics behind Machine Learning ??? The Core Concepts you Need to Know','Chris.Evans','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','Natural Language Processing with Python','Chris.Evans','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','Neural Networks and Deep Learning','Chris.Evans','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','Paradigm of Artificial Intelligence Programming','Chris.Evans','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','Pattern Recognition and Machine Learning','Chris.Evans','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','Programming Collective Intelligence','Chris.Evans','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','Python Machine Learning','Chris.Evans','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','Python Machine Learning: A Technical Approach to Machine Learning for Beginners','Chris.Evans','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','The Elements of Statistical Learning','Chris.Evans','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','The Elements of Statistical Learning: Data Mining, Inference, and Prediction','Chris.Evans','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','The Most Comprehensive Guide to K-Means Clustering You???ll Ever Need','Chris.Evans','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','Think Stats ??? Probability, and Statistics for Programmers','Chris.Evans','DataScience',''
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
		Exec dbo.w_sp_AddArticles  'custom','8 Useful R Packages for Data Science You Aren???t Using (But Should!)','Mahesh.Nayak','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','A Hands-On Introduction to Time Series Classification (with Python Code)','Mahesh.Nayak','DataScience',''
		Exec dbo.w_sp_AddArticles  'custom','Ransomware attacks on the Internet of Things (IoT) devices','Tom.Hill','Information Security',''
		Exec dbo.w_sp_AddArticles  'custom','Security Audit Findings Spurring Organizational Change','Tom.Hill','Information Security',''
		Exec dbo.w_sp_AddArticles  'custom','Security Monitoring for Internal Intrusions ','Tom.Hill','Information Security',''
		Exec dbo.w_sp_AddArticles  'custom','Sinful Seven - Online Activities at Work','Tom.Hill','Information Security',''
		Exec dbo.w_sp_AddArticles  'custom','The Ethical Hacker???s Handbook','Tom.Hill','Information Security',''
		Exec dbo.w_sp_AddArticles  'custom','Trouble In Authentication Land','Tom.Hill','Information Security',''
		Exec dbo.w_sp_AddArticles  'custom','Why Would Anyone Want to Be a CIO?','Tom.Hill','Information Security',''
		Exec dbo.w_sp_AddArticles  'custom','Government surveillance expose corporate secrets','Lena.Headley','Information Security',''
		Exec dbo.w_sp_AddArticles  'custom','My Adventures as the World???s Most Wanted Hacker','Lena.Headley','Information Security',''
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


