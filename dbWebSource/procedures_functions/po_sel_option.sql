
-- =============================================
-- Author:		Rogelio T. Novo Jr.
-- Create date: October 13, 2016 11:42 PM
-- Description:	PO select option.
-- =============================================
CREATE PROCEDURE [dbo].[po_sel_option]
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT purchase_order_id FROM dbo.purchase_order ORDER BY purchase_order_id DESC;
END


