IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'PIPE\thirsh')
CREATE LOGIN [PIPE\thirsh] FROM WINDOWS
GO
CREATE USER [PIPE\thirsh] FOR LOGIN [PIPE\thirsh]
GO
