CREATE PROCEDURE [dbo].[warehousing_upd]
(
    @tt    warehousing_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  receiving_item_id      = b.receiving_item_id
			,status_id				= b.status_id
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.warehousing a INNER JOIN @tt b
        ON a.warehousing_id = b.warehousing_id 
       WHERE (
				isnull(a.receiving_item_id,0) <> isnull(b.receiving_item_id,0)   
			OR	isnull(a.status_id,0) <> isnull(b.status_id,0)     
	   )

-- Insert Process

    INSERT INTO warehousing (
         receiving_item_id 
		,status_id	
		,created_by
        ,created_date
        )
    SELECT 
        receiving_item_id 
	   ,status_id  
	   ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE warehousing_id IS NULL;
END

