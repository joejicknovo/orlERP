
create PROCEDURE [dbo].[delivery_item_detail_upd]
(
    @tt    delivery_item_detail_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  delivery_item_id		= b.delivery_item_id
			,item_id				= b.item_id
			,unit_of_measure_id		= b.unit_of_measure_id
			,unit_price				= b.unit_price
			,quantity				= b.quantity
			,amount					= b.amount
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.delivery_item_detail a INNER JOIN @tt b
        ON a.delivery_item_detail_id = b.delivery_item_detail_id 
       WHERE (
				isnull(a.delivery_item_id,0)	<> isnull(b.delivery_item_id,0)   
			OR	isnull(a.item_id,0)				<> isnull(b.item_id,0)  
			OR	isnull(a.unit_of_measure_id,0)	<> isnull(b.unit_of_measure_id,0) 
			OR	isnull(a.unit_price,0)			<> isnull(b.unit_price,0)
			OR	isnull(a.quantity,0)			<> isnull(b.quantity,0) 
			OR	isnull(a.amount,0)				<> isnull(b.amount,0)
	   )

-- Insert Process

    INSERT INTO delivery_item_detail (
         delivery_item_id 
		,item_id	
		,unit_of_measure_id
		,unit_price
		,quantity  
		,amount
		,created_by
        ,created_date
        )
    SELECT 
        delivery_item_id 
	   ,item_id  
	   ,unit_of_measure_id
	   ,unit_price
	   ,quantity  
	   ,amount
	   ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE delivery_item_detail_id IS NULL;
END





