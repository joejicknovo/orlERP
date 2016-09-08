

create PROCEDURE [dbo].[receiving_item_upd]
(
    @tt    receiving_item_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  purchase_order_id      = b.purchase_order_id
			,delivered_by		    = b.delivered_by
			,remark					= b.remark
			,status_id				= b.status_id
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.receiving_item a INNER JOIN @tt b
        ON a.receiving_item_id = b.receiving_item_id 
       WHERE (
				isnull(a.purchase_order_id,0) <> isnull(b.purchase_order_id,0)   
			OR	isnull(a.delivered_by,0) <> isnull(b.delivered_by,0)   
			OR	isnull(a.remark,0) <> isnull(b.remark,0)  
			OR	isnull(a.status_id,'') <> isnull(b.status_id,'')   
	   )

-- Insert Process

    INSERT INTO receiving_item (
         purchase_order_id 
		,delivered_by	
		,remark  
		,status_id
		,received_by
        ,received_date
        )
    SELECT 
        purchase_order_id 
	   ,delivered_by  
	   ,remark  
	   ,status_id
	   ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE receiving_item_id IS NULL;
END





