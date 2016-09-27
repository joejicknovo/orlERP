
create PROCEDURE [dbo].[employee_upd]
(
    @tt    employee_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET	 employee_first_name   = b.employee_first_name
			,employee_middle_name  = b.employee_middle_name
			,employee_last_name	   = b.employee_last_name
			,employee_gender	   = b.employee_gender
			,employee_birth_date   = b.employee_birth_date
			,date_hired			   = b.date_hired
			,termination_date      = b.termination_date
			,position_id		   = b.position_id
			,user_id               = b.user_id
			,note                  = b.note
			,status_id	           = b.status_id
            ,updated_by            = @user_id
            ,updated_date          = GETDATE()
     FROM dbo.employee a INNER JOIN @tt b
        ON a.employee_id = b.employee_id
       WHERE (   
				isnull(a.employee_first_name,'') <> isnull(b.employee_first_name,'')   
			OR	isnull(a.employee_middle_name,'') <> isnull(b.employee_middle_name,'')   
			OR	isnull(a.employee_last_name,'') <> isnull(b.employee_last_name,'')   
			OR	isnull(a.employee_gender,'') <> isnull(b.employee_gender,'')   
			OR	isnull(a.employee_birth_date,'') <> isnull(b.employee_birth_date,'')   
			OR	isnull(a.date_hired,'') <> isnull(b.date_hired,'')   
			OR	isnull(a.termination_date,'') <> isnull(b.termination_date,'')   
			OR	isnull(a.position_id,0) <> isnull(b.position_id,0)
			OR	isnull(a.user_id,'') <> isnull(b.user_id,'')   
			OR	isnull(a.note,'') <> isnull(b.note,'')   
			OR	isnull(a.status_id,'') <> isnull(b.status_id,'')   
	   )
	   
-- Insert Process

    INSERT INTO employee (
		 employee_first_name
		,employee_middle_name
		,employee_last_name
		,employee_gender
		,employee_birth_date
		,date_hired
		,termination_date
		,position_id
		,user_id
		,note
		,status_id
        ,created_by
        ,created_date
        )
    SELECT 
        employee_first_name
	   ,employee_middle_name
	   ,employee_last_name
	   ,employee_gender
	   ,employee_birth_date
	   ,date_hired
	   ,termination_date
	   ,position_id
	   ,user_id
	   ,note
	   ,status_id
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE employee_id IS NULL;
END





