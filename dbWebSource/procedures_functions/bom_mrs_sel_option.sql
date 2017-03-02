-- =============================================
-- Author:		Rogelio T. Novo Jr.
-- Create date: October 13, 2016 8:25 PM
-- Description:	Selected options of BOM for MRS request.
-- =============================================
CREATE PROCEDURE [dbo].[bom_mrs_sel_option] 
	@bom_id INT
AS
BEGIN
	SET NOCOUNT ON;

    SELECT b.product_id, 
       p.product_code + ' : ' + p.product_name AS product, 
	   b.unit_of_measure_id, 
	   b.unit_cost_material,
	   b.quantity
	FROM dbo.bom_detail b
	INNER JOIN dbo.product p ON b.product_id = p.product_id
	WHERE b.for_mrs = 'Y'
	AND b.bom_id = @bom_id
	ORDER BY p.product_name ASC

END
