IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'CORP\Exton_Support_T2')
CREATE LOGIN [CORP\Exton_Support_T2] FROM WINDOWS
GO
CREATE USER [CORP\Exton_Support_T2] FOR LOGIN [CORP\Exton_Support_T2]
GO
