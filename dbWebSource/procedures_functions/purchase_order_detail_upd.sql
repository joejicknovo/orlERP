
CREATE PROCEDURE [dbo].[purchase_order_detail_upd]
(
    @tt    purchase_order_detail_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  purchase_order_id		= b.purchase_order_id
			,product_id				= b.product_id
			,quantity				= b.quantity
			,unit_of_measure_id		= b.unit_of_measure_id
			,unit_price				= b.unit_price
			,amount					= b.amount
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.purchase_order_detail a INNER JOIN @tt b
        ON a.purchase_order_detail_id = b.purchase_order_detail_id 
       WHERE (
				isnull(a.purchase_order_id,0)	<> isnull(b.purchase_order_id,0)   
			OR	isnull(a.product_id,0)				<> isnull(b.product_id,0)   
			OR	isnull(a.quantity,0)			<> isnull(b.quantity,0) 
			OR	isnull(a.unit_of_measure_id,0)	<> isnull(b.unit_of_measure_id,0)
			OR	isnull(a.unit_price,0)			<> isnull(b.unit_price,0)
			OR	isnull(a.amount,0)				<> isnull(b.amount,0)
	   )

-- Insert Process

    INSERT INTO purchase_order_detail (
         purchase_order_id 
		,product_id	
		,quantity  
		,unit_of_measure_id
		,unit_price
		,amount
		,created_by
        ,created_date
        )
    SELECT 
        purchase_order_id 
	   ,product_id  
	   ,quantity  
	   ,unit_of_measure_id
	   ,unit_price
	   ,amount
	   ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE purchase_order_detail_id IS NULL;
END








