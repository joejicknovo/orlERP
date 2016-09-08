
CREATE PROCEDURE [dbo].[roles_sel]
(
    @role_id  INT = null
   ,@user_id  int = null
)
AS
BEGIN
  IF ISNULL(@role_id,0)=0  
     SELECT * FROM roles_v;
  ELSE
      SELECT * FROM roles_v WHERE role_id = @role_id; 
END

