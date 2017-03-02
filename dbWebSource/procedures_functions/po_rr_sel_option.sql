
-- =============================================
-- Author:		Rogelio T. Novo Jr.
-- Create date: October 13, 2016 11:24 PM
-- Description:	PO to RR select option.
-- =============================================
CREATE PROCEDURE [dbo].[po_rr_sel_option] 
	@po_id INT
AS
BEGIN
	SET NOCOUNT ON;

    SELECT po.product_id,
	   p.product_code + ' : ' + p.product_name AS product,
       po.unit_of_measure_id,
	   po.unit_price,
	   po.quantity 
	FROM dbo.purchase_order_detail po
	INNER JOIN dbo.product p ON po.product_id = p.product_id
	WHERE po.purchase_order_id = @po_id

END


