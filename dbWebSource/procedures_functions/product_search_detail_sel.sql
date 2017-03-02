-- =============================================
-- Author:		Rogelio T. Novo Jr.
-- Create date: October 21, 2016
-- Description:	Product Search Detail
-- =============================================
CREATE PROCEDURE [dbo].[product_search_detail_sel] 
@product_id int
AS
BEGIN
	SELECT d.product_code, 
       ('#' + CAST(c.project_id AS VARCHAR(10)) + ' : ' + c.project_code + ' - ' + c.project_name) AS project, 
    a.mrs_id, 
    CAST(a.mrs_date AS DATE) AS mrs_date,
    b.unit_price 
	FROM dbo.mrs a
	INNER JOIN dbo.mrs_detail b ON a.mrs_id = b.mrs_id
	INNER JOIN dbo.project c ON a.project_id = c.project_id
	INNER JOIN dbo.product d ON b.product_id = d.product_id
	WHERE d.product_id = @product_id;
	
END


