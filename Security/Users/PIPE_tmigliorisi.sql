IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'PIPE\tmigliorisi')
CREATE LOGIN [PIPE\tmigliorisi] FROM WINDOWS
GO
CREATE USER [PIPE\tmigliorisi] FOR LOGIN [PIPE\tmigliorisi]
GO
