

create PROCEDURE [dbo].[bom_detail_upd]
(
    @tt    bom_detail_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  bom_id					= b.bom_id
			,for_mrs				= b.for_mrs
			,product_id				= b.product_id
			,quantity				= b.quantity
			,unit_of_measure_id		= b.unit_of_measure_id
			,unit_cost_material	    = b.unit_cost_material
			,unit_cost_labor	    = b.unit_cost_labor
			,total_cost_material	= b.total_cost_material
			,total_cost_labor	    = b.total_cost_labor
			,total_cost				= b.total_cost
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.bom_detail a INNER JOIN @tt b
        ON a.bom_detail_id = b.bom_detail_id 
       WHERE (
				isnull(a.bom_id,0)				<> isnull(b.bom_id,0)   
			OR	isnull(a.for_mrs,'')			<> isnull(b.for_mrs,'')   
			OR	isnull(a.product_id,0)			<> isnull(b.product_id,0)   
			OR	isnull(a.quantity,0)			<> isnull(b.quantity,0)   
			OR	isnull(a.unit_of_measure_id,0)	<> isnull(b.unit_of_measure_id,0)   
			OR	isnull(a.unit_cost_material,0)	<> isnull(b.unit_cost_material,0)   
			OR	isnull(a.unit_cost_labor,0)		<> isnull(b.unit_cost_labor,0)   
			OR	isnull(a.total_cost_material,0) <> isnull(b.total_cost_material,0)   
			OR	isnull(a.total_cost_labor,0)	<> isnull(b.total_cost_labor,0)   
			OR	isnull(a.total_cost,0)			<> isnull(b.total_cost,0)   
	   )
	   
-- Insert Process

    INSERT INTO dbo.bom_detail (
		 bom_id
		,for_mrs 
		,product_id
		,quantity
		,unit_of_measure_id
		,unit_cost_material
		,unit_cost_labor
		,total_cost_material
		,total_cost_labor
		,total_cost
        ,created_by
        ,created_date
        )
    SELECT 
		 bom_id
		,for_mrs 
		,product_id
		,quantity
		,unit_of_measure_id
		,unit_cost_material
		,unit_cost_labor
		,total_cost_material
		,total_cost_labor
		,total_cost
        ,@user_id
        ,GETDATE()
    FROM @tt
    WHERE bom_detail_id IS NULL;
END

