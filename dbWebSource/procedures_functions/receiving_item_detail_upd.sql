create PROCEDURE [dbo].[receiving_item_detail_upd]
(
    @tt    receiving_item_detail_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  receiving_item_id		= b.receiving_item_id
			,item_id				= b.item_id
			,quantity				= b.quantity
			,unit_of_measure_id		= b.unit_of_measure_id
			,unit_price				= b.unit_price
			,amount					= b.amount
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.receiving_item_detail a INNER JOIN @tt b
        ON a.receiving_item_detail_id = b.receiving_item_detail_id 
       WHERE (
				isnull(a.receiving_item_id,0)	<> isnull(b.receiving_item_id,0)   
			OR	isnull(a.item_id,0)				<> isnull(b.item_id,0)   
			OR	isnull(a.quantity,0)			<> isnull(b.quantity,0) 
			OR	isnull(a.unit_of_measure_id,0)	<> isnull(b.unit_of_measure_id,0)
			OR	isnull(a.unit_price,0)			<> isnull(b.unit_price,0)
			OR	isnull(a.amount,0)				<> isnull(b.amount,0)
	   )

-- Insert Process

    INSERT INTO receiving_item_detail (
         receiving_item_id 
		,item_id	
		,quantity  
		,unit_of_measure_id
		,unit_price
		,amount
		,created_by
        ,created_date
        )
    SELECT 
        receiving_item_id 
	   ,item_id  
	   ,quantity  
	   ,unit_of_measure_id
	   ,unit_price
	   ,amount
	   ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE receiving_item_detail_id IS NULL;
END





