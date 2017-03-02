
-- =============================================
-- Author:		Rogelio T. Novo Jr.
-- Create date: October 13, 2016
-- Description:	Supply monitoring
-- =============================================
CREATE PROCEDURE [dbo].[supply_monitoring_sel_option] 
	
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT p.product_id, 
		p.product_code + '- ' + p.product_name AS product,
		p.unit_of_measure_id,
		ISNULL(dbo.getProductCurrentDateWarehousing(p.product_id),0) AS latest_price,
		--SUM(wd.quantity) AS available_quantity,
		--dbo.getSumOfDeliveredProduct(p.product_id) AS delivered_quantity,
		ISNULL(ISNULL((SUM(wd.quantity) - dbo.getSumOfDeliveredProduct(p.product_id)),SUM(wd.quantity)),0) AS remaining_quantity
	FROM dbo.warehousing_detail wd
	RIGHT OUTER JOIN dbo.product p ON wd.product_id = p.product_id
	GROUP BY p.product_id, p.product_code, p.product_name, p.unit_of_measure_id
	ORDER BY product
	
END

