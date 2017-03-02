
CREATE PROCEDURE [dbo].[product_display_sel]
(
     @product_id  INT	= NULL
	,@is_active varchar(1)='Y'
	,@col_no INT		= 3
    ,@order_no INT		= 0
	,@pno INT			= 1
    ,@rpp INT			= 100
)
AS
BEGIN
  DECLARE @stmt         VARCHAR(4000);
  DECLARE @order        VARCHAR(4000);
  DECLARE @count	    INT = 0;
  DECLARE @page_count	INT = 1;

--SET NOCOUNT ON

  
	SET @stmt = N'SELECT * FROM dbo.product_display_v WHERE 1 = 1 ';
	SET @order = N' ORDER BY ' + CAST(@col_no AS VARCHAR(1)) + ' ' + IIF(@order_no=0,'ASC','DESC'); 
	SELECT @count = COUNT(*) FROM dbo.product_display_v WHERE is_active = @is_active;
		
	IF @product_id IS NOT NULL 
	BEGIN 
		SET @stmt = @stmt + N' AND product_id = ' + CAST(@product_id AS VARCHAR(50));
		SET @count = 1;
	END

	SET @stmt = @stmt + @order
	SET @stmt = @stmt + N' OFFSET (' + CAST(@pno-1 AS VARCHAR(20)) +')*' + CAST(@rpp AS VARCHAR(20)) + ' ROWS FETCH NEXT ' + CAST(@rpp AS VARCHAR(20)) + ' ROWS ONLY '; 
	EXEC(@stmt);
	PRINT @stmt;

	SET @page_count =  CEILING((CONVERT(DECIMAL(20,5),@count))/@rpp);
	print @page_count;
	RETURN @page_count;

	
END


