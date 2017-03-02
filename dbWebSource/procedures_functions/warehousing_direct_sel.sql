
CREATE PROCEDURE [dbo].[warehousing_direct_sel]
(
	  @pno INT = 1
	 ,@rpp INT = 1000
	 ,@col_no INT = 1
	 ,@order_no INT = 0
)
AS
BEGIN

SET NOCOUNT ON

	DECLARE @count INT = 0;
	DECLARE @page_count INT = 1;

	IF @col_no = 1
		BEGIN
			IF @order_no = 0
				BEGIN
					SELECT * FROM dbo.warehousing_direct_v ORDER BY product_name ASC OFFSET (@pno-1)*@rpp ROWS
					FETCH NEXT @rpp ROWS ONLY;
					SET @page_count = CEILING((CONVERT(DECIMAL(20,5),@count))/@rpp);
					SET @count = @@ROWCOUNT;
				END
		END

	RETURN @page_count;
END


