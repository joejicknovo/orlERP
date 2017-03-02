
create PROCEDURE [dbo].[department_sel]
(
    @department_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @department_id IS NOT NULL  
	 SELECT * 
	 FROM dbo.department 
	 WHERE department_id = @department_id
	 ORDER BY department_name; 
  ELSE
     SELECT * 
	 FROM dbo.department
	 ORDER BY department_name; 
	
END
 


