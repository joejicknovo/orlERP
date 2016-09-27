


CREATE PROCEDURE [dbo].[purchase_order_sel]
(
    @purchase_order_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @purchase_order_id IS NOT NULL  
	 SELECT * FROM dbo.purchase_order WHERE purchase_order_id = @purchase_order_id; 
  ELSE
      SELECT * FROM purchase_order
	  ORDER BY purchase_order_id; 
	
END
 





