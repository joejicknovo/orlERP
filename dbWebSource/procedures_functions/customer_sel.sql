
CREATE PROCEDURE [dbo].[customer_sel]
(
    @customer_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @customer_id IS NOT NULL  
	 SELECT * 
	 FROM dbo.customer 
	 WHERE customer_id = @customer_id
	 ORDER BY customer_name; 
  ELSE
      SELECT * FROM dbo.customer
	  ORDER BY customer_name; 
	
END
 
