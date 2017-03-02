create PROCEDURE [dbo].[department_upd]
(
    @tt    department_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  department_code		= b.department_code
			,department_name		= b.department_name
			,department_head_id		= b.department_head_id
			,is_active				= b.is_active
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.department a INNER JOIN @tt b
        ON a.department_id = b.department_id 
       WHERE (
				isnull(a.department_code,'')	<> isnull(b.department_code,'')   
			OR	isnull(a.department_name,'')	<> isnull(b.department_name,'')   
			OR	isnull(a.department_head_id,0)	<> isnull(b.department_head_id,0)   
			OR	isnull(a.is_active,'')			<> isnull(b.is_active,'')   
	   )
	   
-- Insert Process

    INSERT INTO department (
         department_code 
		,department_name
		,department_head_id
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        department_code 
	   ,department_name	
	   ,department_head_id
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE department_id IS NULL;
END






