
CREATE PROCEDURE [dbo].[supplies_upd]
(
    @tt    supplies_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
   /* UPDATE a 
        SET  supply_code		= b.supply_code
			,supply_desc		= b.supply_code
			,supply_type_id	    = b.supply_type_id
			,unit_id			= b.unit_id
			,supply_srp			= b.supply_srp
			,seq_no				= b.seq_no
			,weight_serve		= b.weight_serve
			,supply_cost	    = b.supply_cost
            ,updated_by			= @user_id
            ,updated_date		= GETDATE()
     FROM dbo.supplies a INNER JOIN @tt b
        ON a.supply_id = b.supply_id 
       WHERE (
				isnull(a.supply_code,'')		    <> isnull(b.supply_code,'')   
			OR	isnull(a.supply_desc,'')		    <> isnull(b.supply_desc,'')   
			OR	isnull(a.supply_type_id,0)	  	    <> isnull(b.supply_type_id,0)   
			OR	isnull(a.unit_id,0)					<> isnull(b.unit_id,0)   
			OR	isnull(a.supply_srp,0)			    <> isnull(b.supply_srp,0)   
			OR	isnull(a.seq_no,0)			        <> isnull(b.seq_no,0)   
			OR	isnull(a.weight_serve,0)		    <> isnull(b.weight_serve,0)   
			OR	isnull(a.supply_cost,0)				<> isnull(b.supply_cost,0)
	   )
	   */
-- Insert Process

    INSERT INTO supplies (
         seq_no		
		,supply_code	
		,supply_desc	
		,supply_type_id	
		,unit_id		
		,supply_srp		
		,weight_serve	
		,supply_cost	
		,created_by
        ,created_date
        )
    SELECT 
	    seq_no	
       ,supply_code	
	   ,supply_desc	
	   ,supply_type_id	
	   ,unit_id		
	   ,supply_srp		
	   ,weight_serve	
	   ,supply_cost	
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE supply_id IS NULL
END





