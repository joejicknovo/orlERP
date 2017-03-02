
-- =============================================
-- Author:		Rogelio T. Novo Jr.
-- Create date: October 13, 2016 10:31 PM
-- Description:	MRS to PO select option.
-- =============================================
CREATE PROCEDURE [dbo].[mrs_po_sel_option] 
	@mrs_id INT
AS
BEGIN
	SET NOCOUNT ON;

    SELECT m.product_id,
	   p.product_code + ' : ' + p.product_name AS product,
       m.unit_of_measure_id,
	   m.unit_price,
	   m.quantity
	FROM dbo.mrs_detail m
	INNER JOIN dbo.product p ON m.product_id = p.product_id
	WHERE mrs_id = @mrs_id

END


