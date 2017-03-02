-- =============================================
-- Author:		Rogelio T. Novo Jr.
-- Create date: October 11, 2016
-- Description:	Supply monitoring
-- =============================================
CREATE PROCEDURE [dbo].[supply_monitoring_sel] 
	
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT p.product_id, 
	    p.product_code,
		p.product_name AS product,
		ISNULL(u.unit_of_measure_code,u1.unit_of_measure_code) AS unit_of_measure_code,
		ISNULL(dbo.getProductCurrentDateWarehousing(p.product_id),0) AS latest_price,
		--SUM(wd.quantity) AS available_quantity,
		--dbo.getSumOfDeliveredProduct(wd.product_id) AS delivered_quantity,
		ISNULL(ISNULL((SUM(wd.quantity) - dbo.getSumOfDeliveredProduct(p.product_id)),SUM(wd.quantity)),0) AS remaining_quantity
	FROM dbo.warehousing_detail wd
	RIGHT OUTER JOIN dbo.product p ON wd.product_id = p.product_id
	LEFT OUTER JOIN dbo.unit_of_measure u ON wd.unit_of_measure_id = u.unit_of_measure_id
	LEFT OUTER JOIN dbo.unit_of_measure u1 ON p.unit_of_measure_id = u1.unit_of_measure_id
	GROUP BY p.product_id, p.product_code, p.product_name, u.unit_of_measure_code, u1.unit_of_measure_code
	ORDER BY product
	
END


