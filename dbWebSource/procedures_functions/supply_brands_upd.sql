CREATE PROCEDURE [dbo].[supply_brands_upd]
(
    @tt    supply_brands_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  brand_id		= b.brand_id
			,supply_id		= b.supply_id
			,conv_id	    = b.conv_id
			,supply_cost	= b.supply_cost
            ,updated_by		= @user_id
            ,updated_date	= GETDATE()
     FROM dbo.supply_brands a INNER JOIN @tt b
        ON a.supply_brand_id = b.supply_brand_id 
       WHERE (
				isnull(a.brand_id,'') <> isnull(b.brand_id,'')   
			OR	isnull(a.supply_id,'') <> isnull(b.supply_id,'')   
			OR	isnull(a.conv_id,'') <> isnull(b.conv_id,'')   
			OR	isnull(a.supply_cost,'') <> isnull(b.supply_cost,'')   
	   )

-- Insert Process

    INSERT INTO supply_brands (
         brand_id	
		,supply_id	
		,conv_id	
		,supply_cost
		,created_by
        ,created_date
        )
    SELECT 
         brand_id	
		,supply_id	
		,conv_id	
		,supply_cost
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE supply_brand_id IS NULL
END





