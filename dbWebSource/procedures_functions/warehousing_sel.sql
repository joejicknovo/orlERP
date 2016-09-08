
CREATE PROCEDURE [dbo].[warehousing_sel]
(
    --@warehousing_id  INT = 0
   @receiving_item_id INT = 0
   --,@status_id INT = 0
)
AS
BEGIN
	DECLARE @stmt		VARCHAR(4000);

	SET @stmt = 'SELECT * FROM dbo.warehousing_v';

	--IF @warehousing_id <> 0 
	--	SET @stmt = @stmt + ' WHERE warehousing_id='+ @warehousing_id;

	IF @receiving_item_id <> 0 
		SET @stmt = @stmt + ' WHERE receiving_item_id='+ @receiving_item_id;

	--IF @status_id <> 0
	--	SET	@stmt = @stmt + ' AND status-id='+ @status_id;
	print @stmt;
   exec (@stmt);
end
