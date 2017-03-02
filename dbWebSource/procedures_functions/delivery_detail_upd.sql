CREATE PROCEDURE [dbo].[delivery_detail_upd]
(
    @tt    delivery_detail_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  delivery_id		    = b.delivery_id
			,product_id				= b.product_id
			,unit_of_measure_id		= b.unit_of_measure_id
			,unit_price				= b.unit_price
			,quantity				= b.quantity
			,amount					= b.amount
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.delivery_detail a INNER JOIN @tt b
        ON a.delivery_detail_id = b.delivery_detail_id 
       WHERE (
				isnull(a.delivery_id,0)			<> isnull(b.delivery_id,0)   
			OR	isnull(a.product_id,0)			<> isnull(b.product_id,0)  
			OR	isnull(a.unit_of_measure_id,0)	<> isnull(b.unit_of_measure_id,0) 
			OR	isnull(a.unit_price,0)			<> isnull(b.unit_price,0)
			OR	isnull(a.quantity,0)			<> isnull(b.quantity,0) 
			OR	isnull(a.amount,0)				<> isnull(b.amount,0)
	   )

-- Insert Process

    INSERT INTO delivery_detail (
         delivery_id 
		,product_id	
		,unit_of_measure_id
		,unit_price
		,quantity  
		,amount
		,created_by
        ,created_date
        )
    SELECT 
        delivery_id 
	   ,product_id  
	   ,unit_of_measure_id
	   ,unit_price
	   ,quantity  
	   ,amount
	   ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE delivery_detail_id IS NULL;
END



