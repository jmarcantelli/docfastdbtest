IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'PIPE\yli')
CREATE LOGIN [PIPE\yli] FROM WINDOWS
GO
