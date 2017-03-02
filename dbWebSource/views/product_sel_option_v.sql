CREATE VIEW [dbo].[product_sel_option_v]
AS
SELECT        TOP (100) PERCENT dbo.product.product_id, dbo.product.product_code + ' : ' + dbo.product.product_name + ' [' + dbo.unit_of_measure.unit_of_measure_code + ']' AS product_description, 
                         dbo.product.is_active
FROM            dbo.product INNER JOIN
                         dbo.unit_of_measure ON dbo.product.unit_of_measure_id = dbo.unit_of_measure.unit_of_measure_id
WHERE        (dbo.product.is_active = 'Y')
ORDER BY dbo.product.product_name
