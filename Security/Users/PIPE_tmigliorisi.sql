IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'PIPE\tmigliorisi')
CREATE LOGIN [PIPE\tmigliorisi] FROM WINDOWS
GO
