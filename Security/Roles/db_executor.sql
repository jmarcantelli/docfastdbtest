CREATE ROLE [db_executor]
AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'db_executor', N'CORP\Exton_RD'
GO
EXEC sp_addrolemember N'db_executor', N'DV\UATPOLEXAPP_SVC'
GO
GRANT EXECUTE TO [db_executor]
