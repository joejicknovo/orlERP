CREATE VIEW [dbo].[product_attribute_v]
AS
SELECT        TOP (100) PERCENT product_attribute_id, '(' + CAST(product_attribute_sequence_no AS VARCHAR(1000)) + ') ' + product_attribute_value AS product_attribute, product_type_id
FROM            dbo.product_attribute
ORDER BY product_type_id, product_attribute

