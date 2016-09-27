create FUNCTION [dbo].[getUserRoleId]() 
RETURNS INT 
AS
BEGIN
   DECLARE @l_role_id INT; 
      SELECT @l_role_id = role_id FROM USERS where logon = substring(SUSER_NAME(),10,30);
      RETURN @l_role_id;
END;