


CREATE PROCEDURE [dbo].[employee_sel]
(
    @employee_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @employee_id IS NOT NULL  
	 SELECT * FROM dbo.employee WHERE @employee_id = @employee_id; 
  ELSE
     SELECT * FROM dbo.employee ORDER BY employee_first_name; 
	
END
 







