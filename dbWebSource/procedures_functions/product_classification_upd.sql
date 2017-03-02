

CREATE PROCEDURE [dbo].[product_classification_upd]
(
    @tt    product_classification_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  product_classification_code		= b.product_classification_code
			,product_classification_name		= b.product_classification_name
			,is_active	                = b.is_active
            ,updated_by                 = @user_id
            ,updated_date               = GETDATE()
        FROM dbo.product_classification a INNER JOIN @tt b
        ON a.product_classification_id = b.product_classification_id 
        WHERE (
				isnull(a.product_classification_code,'')  <> isnull(b.product_classification_code,'')   
			OR	isnull(a.product_classification_name,'')  <> isnull(b.product_classification_name,'')   
			OR	isnull(a.is_active,'')			          <> isnull(b.is_active,'')   
	   )
	   
-- Insert Process

    INSERT INTO dbo.product_classification (
		 product_classification_code
		,product_classification_name 
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
		product_classification_code	
       ,product_classification_name 
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE product_classification_id IS NULL;
END



