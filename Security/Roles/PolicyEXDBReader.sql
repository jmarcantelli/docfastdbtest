CREATE ROLE [PolicyEXDBReader]
AUTHORIZATION [dbo]
GO
EXEC sp_addextendedproperty N'Description', N'This role will have execute permission on all the stored procedures and the Windows NT user used by the PolicyEX application will be assigned with this role', 'USER', N'PolicyEXDBReader', NULL, NULL, NULL, NULL
GO
EXEC sp_addextendedproperty N'Name', N'PolicyEXDBReader', 'USER', N'PolicyEXDBReader', NULL, NULL, NULL, NULL
GO
