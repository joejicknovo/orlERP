
CREATE PROCEDURE [dbo].[product_upd]
(
    @tt    product_tt READONLY
   ,@user_id INT
)
AS

BEGIN
--Update Process
     UPDATE a 
        SET  product_name	            = b.product_name
			,unit_of_measure_id         = b.unit_of_measure_id
			,product_classification_id  = b.product_classification_id
			,product_category_id        = b.product_category_id
			,product_group_id           = b.product_group_id
			,product_type_id            = b.product_type_id
			,product_brand_id			= b.product_brand_id
			,product_attribute_id       = b.product_attribute_id
			,image_url		            = b.image_url
			,is_active	                = b.is_active
            ,updated_by                 = @user_id
            ,updated_date               = GETDATE()
     FROM dbo.product a INNER JOIN @tt b
        ON a.product_id = b.product_id 
     WHERE (
				ISNULL(a.product_name,'')				<> ISNULL(b.product_name,'')   
			OR	ISNULL(a.unit_of_measure_id,0)			<> ISNULL(b.unit_of_measure_id,0)   
			OR  ISNULL(a.product_classification_id,0)	<> ISNULL(b.product_classification_id,0)   
			OR  ISNULL(a.product_category_id,0)			<> ISNULL(b.product_category_id,0)   
			OR  ISNULL(a.product_group_id,0)			<> ISNULL(b.product_group_id,0)   
			OR  ISNULL(a.product_type_id,0)				<> ISNULL(b.product_type_id,0)   
			OR  ISNULL(a.product_brand_id,0)			<> ISNULL(b.product_brand_id,0)   
			OR  ISNULL(a.product_attribute_id,0)		<> ISNULL(b.product_attribute_id,0)   
			OR	ISNULL(a.image_url,'')					<> ISNULL(b.image_url,'')  
			OR	ISNULL(a.is_active,'')					<> ISNULL(b.is_active,'')   
	   )

--Code generator
	DECLARE @uterminator INT = 1;
	DECLARE @ucounter INT = (SELECT COUNT(product_id) FROM dbo.product_v WHERE product_code IS NOT NULL);

	WHILE @uterminator <= @ucounter
	BEGIN
		UPDATE dbo.product_v
		SET product_code = (SELECT product_classification_code + 
		                           product_category_code +
								   product_group_code +
								   product_type_code + 
								   product_brand_code +
								   REPLICATE('0',4-LEN(RTRIM(product_attribute_sequence_no))) + RTRIM(product_attribute_sequence_no))
		WHERE product_id = product_id;

		SET @uterminator = @uterminator + 1;
	END

--Insert Process
    INSERT INTO product (
         product_name
		,unit_of_measure_id	
		,product_classification_id
		,product_category_id
		,product_group_id
		,product_type_id
		,product_brand_id
		,product_attribute_id
		,image_url  
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        product_name
	   ,unit_of_measure_id	
	   ,product_classification_id
	   ,product_category_id
	   ,product_group_id
	   ,product_type_id
	   ,product_brand_id
	   ,product_attribute_id
	   ,image_url  
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE product_id IS NULL;

--Code generator
	DECLARE @terminator INT = 1;
	DECLARE @counter INT = (SELECT COUNT(product_id) FROM dbo.product_v WHERE product_code IS NULL);

	WHILE @terminator <= @counter
	BEGIN
		UPDATE dbo.product_v
		SET product_code = (SELECT product_classification_code + 
		                           product_category_code +
								   product_group_code +
								   product_type_code + 
								   product_brand_code +
								   REPLICATE('0',4-LEN(RTRIM(product_attribute_sequence_no))) + RTRIM(product_attribute_sequence_no))
		WHERE product_id = (SELECT TOP 1 product_id FROM dbo.product_v WHERE product_code IS NULL);

		SET @terminator = @terminator + 1;
	END
	
END




