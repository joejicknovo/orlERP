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
			,warehouse_id			= b.warehouse_id
			,rack_id				= b.rack_id
			,tag_no					= b.tag_no
			,expiration_date		= b.expiration_date
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
			OR	isnull(a.warehouse_id,0)		<> isnull(b.warehouse_id,0)
			OR	isnull(a.rack_id,0)				<> isnull(b.rack_id,0)
			OR	isnull(a.tag_no,'')				<> isnull(b.tag_no,'')
			OR	isnull(a.expiration_date,'')	<> isnull(b.expiration_date,'')
	   )

-- Insert Process

    INSERT INTO receiving_item_detail (
         receiving_item_id 
		,item_id	
		,quantity  
		,unit_of_measure_id
		,unit_price
		,warehouse_id
		,rack_id
		,tag_no
		,expiration_date
		,created_by
        ,created_date
        )
    SELECT 
        receiving_item_id 
	   ,item_id  
	   ,quantity  
	   ,unit_of_measure_id
	   ,unit_price
	   ,warehouse_id
	   ,rack_id
	   ,tag_no
	   ,expiration_date
	   ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE receiving_item_detail_id IS NULL;
END





