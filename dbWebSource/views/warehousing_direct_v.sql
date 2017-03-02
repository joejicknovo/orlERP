CREATE VIEW [dbo].[warehousing_direct_v]
AS
SELECT        dbo.warehousing_detail.warehousing_detail_id, dbo.getProductCode(dbo.warehousing_detail.product_id) AS product_code, dbo.getProductName(dbo.warehousing_detail.product_id) AS product_name, 
                         dbo.unit_of_measure.unit_of_measure_code, dbo.warehousing_detail.unit_price, dbo.warehousing_detail.quantity, dbo.warehouse.warehouse_name, dbo.warehouse_rack.warehouse_rack_name, 
                         dbo.warehousing_detail.tag_no, dbo.warehousing_detail.expiration_date, dbo.warehousing_detail.warehousing_id, dbo.warehousing_detail.warehousing_return_id
FROM            dbo.warehousing_detail LEFT OUTER JOIN
                         dbo.warehouse_rack ON dbo.warehousing_detail.rack_id = dbo.warehouse_rack.warehouse_rack_id LEFT OUTER JOIN
                         dbo.warehouse ON dbo.warehousing_detail.warehouse_id = dbo.warehouse.warehouse_id LEFT OUTER JOIN
                         dbo.unit_of_measure ON dbo.warehousing_detail.unit_of_measure_id = dbo.unit_of_measure.unit_of_measure_id
WHERE        (dbo.warehousing_detail.warehousing_id = 0) AND (dbo.warehousing_detail.warehousing_return_id IS NULL)
