CREATE PROCEDURE [dbo].[warehousing_return_upd]
(
    @tt    warehousing_return_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  warehousing_id			= b.warehousing_id
			,product_id				= b.product_id
			,unit_of_measure_id		= b.unit_of_measure_id
			,unit_price				= b.unit_price
			,quantity				= b.quantity
			,warehouse_id			= b.warehouse_id
			,rack_id				= b.rack_id
			,tag_no					= b.tag_no
			,expiration_date		= b.expiration_date
			,warehousing_return_id	= b.warehousing_return_id
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.warehousing_detail a INNER JOIN @tt b
        ON a.warehousing_detail_id = b.warehousing_detail_id 
       WHERE (
				isnull(a.warehousing_id,0)			<> isnull(b.warehousing_id,0)   
			OR	isnull(a.product_id,0)				<> isnull(b.product_id,0)   
			OR	isnull(a.unit_of_measure_id,0)		<> isnull(b.unit_of_measure_id,0)
			OR	isnull(a.unit_price,0)				<> isnull(b.unit_price,0)
			OR	isnull(a.quantity,0)				<> isnull(b.quantity,0) 
			OR	isnull(a.warehouse_id,0)			<> isnull(b.warehouse_id,0)
			OR	isnull(a.rack_id,0)					<> isnull(b.rack_id,0)
			OR	isnull(a.tag_no,'')					<> isnull(b.tag_no,'')
			OR	isnull(a.expiration_date,'')		<> isnull(b.expiration_date,'')
			OR	isnull(a.warehousing_return_id,0)	<> isnull(b.warehousing_return_id,0)
	   )

-- Insert Process

    INSERT INTO warehousing_detail (
         warehousing_id 
		,product_id	
		,unit_of_measure_id
		,unit_price
		,quantity  
		,warehouse_id
		,rack_id
		,tag_no
		,expiration_date
		,warehousing_return_id
		,created_by
        ,created_date
        )
    SELECT 
         warehousing_id = 0
		,product_id	
		,unit_of_measure_id
		,unit_price
		,quantity  
		,warehouse_id
		,rack_id
		,tag_no
		,expiration_date
		,warehousing_return_id
	    ,@user_id
        ,GETDATE()
    FROM @tt
    WHERE warehousing_detail_id IS NULL;
END

