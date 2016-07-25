IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'DV\tappsvc223')
CREATE LOGIN [DV\tappsvc223] FROM WINDOWS
GO
