IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'PIPE\anita')
CREATE LOGIN [PIPE\anita] FROM WINDOWS
GO
CREATE USER [anita] FOR LOGIN [PIPE\anita]
GO
