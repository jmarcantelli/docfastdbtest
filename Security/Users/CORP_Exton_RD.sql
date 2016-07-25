IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'CORP\Exton_RD')
CREATE LOGIN [CORP\Exton_RD] FROM WINDOWS
GO
