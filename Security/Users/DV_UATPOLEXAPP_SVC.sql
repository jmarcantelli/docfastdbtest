IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'DV\UATPOLEXAPP_SVC')
CREATE LOGIN [DV\UATPOLEXAPP_SVC] FROM WINDOWS
GO
CREATE USER [DV\UATPOLEXAPP_SVC] FOR LOGIN [DV\UATPOLEXAPP_SVC]
GO