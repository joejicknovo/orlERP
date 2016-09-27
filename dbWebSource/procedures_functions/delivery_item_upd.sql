
create PROCEDURE [dbo].[delivery_item_upd]
(
    @tt    delivery_item_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  project_id				= b.project_id
			,delivery_date		    = b.delivery_date
			,delivery_incharge_id	= b.delivery_incharge_id
			,company_vehicle_id		= b.company_vehicle_id
			,company_driver_id		= b.company_driver_id
			,outsource_shipper_id	= b.outsource_shipper_id
			,status_id				= b.status_id
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.delivery_item a INNER JOIN @tt b
        ON a.delivery_item_id = b.delivery_item_id 
       WHERE (
				isnull(a.project_id,0)				<> isnull(b.project_id,0)   
			OR	isnull(a.delivery_date,'')			<> isnull(b.delivery_date,'')   
			OR	isnull(a.delivery_incharge_id,0)	<> isnull(b.delivery_incharge_id,0)  
			OR	isnull(a.company_vehicle_id,0)		<> isnull(b.company_vehicle_id,0)  
			OR	isnull(a.company_driver_id,0)		<> isnull(b.company_driver_id,0)  
			OR	isnull(a.outsource_shipper_id,0)	<> isnull(b.outsource_shipper_id,0)  
			OR	isnull(a.status_id,0)				<> isnull(b.status_id,0)   
	   )

-- Insert Process

    INSERT INTO delivery_item (
         project_id 
		,delivery_date	
		,delivery_incharge_id  
		,company_vehicle_id
		,company_driver_id
		,outsource_shipper_id
		,status_id
		,created_by
        ,created_date
        )
    SELECT 
        project_id 
	   ,delivery_date  
	   ,delivery_incharge_id  
	   ,company_vehicle_id
	   ,company_driver_id
	   ,outsource_shipper_id
	   ,status_id
	   ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE delivery_item_id IS NULL;
END





