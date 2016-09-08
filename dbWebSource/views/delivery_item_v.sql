CREATE VIEW dbo.delivery_item_v
AS
SELECT        dbo.delivery_item.delivery_item_id, dbo.delivery_item.project_id, dbo.project.project_code + '-' + dbo.project.project_name AS project, dbo.delivery_item.item_id, 
                         dbo.item.item_code + '-' + dbo.item.item_name AS item, dbo.delivery_item.unit_of_measure_id, dbo.unit_of_measure.unit_of_measure_code, dbo.delivery_item.unit_price, dbo.delivery_item.quantity, 
                         dbo.delivery_item.amount, dbo.delivery_item.created_by, dbo.delivery_item.created_date, dbo.delivery_item.updated_by, dbo.delivery_item.updated_date
FROM            dbo.delivery_item LEFT OUTER JOIN
                         dbo.unit_of_measure ON dbo.delivery_item.unit_of_measure_id = dbo.unit_of_measure.unit_of_measure_id LEFT OUTER JOIN
                         dbo.item ON dbo.delivery_item.item_id = dbo.item.item_id LEFT OUTER JOIN
                         dbo.project ON dbo.delivery_item.project_id = dbo.project.project_id
