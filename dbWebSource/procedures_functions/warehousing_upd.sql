CREATE PROCEDURE [dbo].[warehousing_upd]
(
    @tt    warehousing_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  receiving_item_id	= b.receiving_item_id
			,item_id			= b.item_id
			,unit_of_measure_id	= b.unit_of_measure_id
			,unit_price			= b.unit_price
			,quantity			= b.quantity
			,warehouse_id		= b.warehouse_id
			,rack_id			= b.rack_id
			,tag_no				= b.tag_no
			,expiration_date	=b.expiration_date
			,status_id			=b.status_id
            ,updated_by			= @user_id
            ,updated_date		= GETDATE()
     FROM dbo.warehousing a INNER JOIN @tt b
        ON a.warehouse_id = b.warehouse_id 
       WHERE (
				isnull(a.receiving_item_id,'')	<> isnull(b.receiving_item_id,'')   
			OR	isnull(a.item_id,'')		    <> isnull(b.item_id,'')   
			OR	isnull(a.unit_of_measure_id,0)	<> isnull(b.unit_of_measure_id,0)   
			OR	isnull(a.unit_price,0)			<> isnull(b.unit_price,0)   
			OR	isnull(a.quantity,0)			<> isnull(b.quantity,0)   
			OR	isnull(a.warehouse_id,0)		<> isnull(b.warehouse_id,0)   
			OR	isnull(a.rack_id,0)			    <> isnull(b.rack_id,0) 
			OR	isnull(a.tag_no,0)			    <> isnull(b.tag_no,0) 
			OR	isnull(a.expiration_date,0)		<> isnull(b.expiration_date,0)   
			OR	isnull(a.status_id,0)			<> isnull(b.status_id,0)
	   )
	   
-- Insert Process

    INSERT INTO warehousing (
         receiving_item_id		
		,item_id	
		,unit_of_measure_id	
		,unit_price	
		,quantity		
		,warehouse_id		
		,rack_id	
		,tag_no
		,expiration_date
		,status_id	
		,created_by
        ,created_date
        )
    SELECT 
	    receiving_item_id	
       ,item_id	
	   ,unit_of_measure_id	
	   ,unit_price	
	   ,quantity		
	   ,warehouse_id		
	   ,rack_id	
	   ,tag_no	
	   ,expiration_date
	   ,status_id
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE warehouse_id IS NULL
END





