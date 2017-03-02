
CREATE PROCEDURE [dbo].[warehouse_rack_upd]
(
    @tt    warehouse_rack_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  warehouse_rack_name	= b.warehouse_rack_name
			,is_active				= b.is_active
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.warehouse_rack a INNER JOIN @tt b
        ON a.warehouse_rack_id = b.warehouse_rack_id 
       WHERE (
				isnull(a.warehouse_rack_name,'') <> isnull(b.warehouse_rack_name,'')   
			OR	isnull(a.is_active,'')            <> isnull(b.is_active,'')   
	   )
	   
-- Insert Process
	DECLARE @warehouse_rack_id INT = NULL;
    INSERT INTO warehouse_rack (
         warehouse_rack_name
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        warehouse_rack_name	
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE warehouse_rack_id IS NULL;

	--Code generator
    DECLARE @terminator INT = 1;
	DECLARE @counter INT = (SELECT COUNT(warehouse_rack_id) FROM dbo.warehouse_rack WHERE warehouse_rack_code IS NULL);

	WHILE @terminator <= @counter
		BEGIN
			UPDATE dbo.warehouse_rack
			SET warehouse_rack_code = (SELECT 'WH' + REPLICATE('0',4-LEN(RTRIM(warehouse_rack_id))) + RTRIM(warehouse_rack_id))
			WHERE warehouse_rack_id = (SELECT TOP 1 warehouse_rack_id FROM dbo.warehouse_rack WHERE warehouse_rack_code IS NULL);

			SET @terminator = @terminator + 1;
		END
END






