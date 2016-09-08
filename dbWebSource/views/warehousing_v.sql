CREATE VIEW dbo.warehousing_v
AS
SELECT        dbo.warehousing.warehousing_id, dbo.warehousing.receiving_item_id, dbo.warehousing.item_id, dbo.item.item_code + '- ' + dbo.item.item_name AS item, dbo.warehousing.unit_of_measure_id, 
                         dbo.unit_of_measure.unit_of_measure_code, dbo.warehousing.unit_price, dbo.warehousing.quantity, dbo.warehousing.warehouse_id, 
                         dbo.warehouse.warehouse_code + '- ' + dbo.warehouse.warehouse_name AS warehouse, dbo.warehousing.rack_id, dbo.warehousing.tag_no, dbo.warehousing.expiration_date, dbo.warehousing.status_id, 
                         dbo.warehousing.created_by, dbo.warehousing.created_date, dbo.warehousing.updated_by, dbo.warehousing.updated_date
FROM            dbo.warehousing LEFT OUTER JOIN
                         dbo.unit_of_measure ON dbo.warehousing.unit_of_measure_id = dbo.unit_of_measure.unit_of_measure_id LEFT OUTER JOIN
                         dbo.warehouse ON dbo.warehousing.warehouse_id = dbo.warehouse.warehouse_id LEFT OUTER JOIN
                         dbo.item ON dbo.warehousing.item_id = dbo.item.item_id
