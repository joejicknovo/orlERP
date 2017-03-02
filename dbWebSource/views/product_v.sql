CREATE VIEW [dbo].[product_v]
AS
SELECT        dbo.product.product_id, dbo.product.image_url, dbo.product.product_code, dbo.product.product_name, dbo.product.unit_of_measure_id, dbo.unit_of_measure.unit_of_measure_code, 
                         dbo.product.product_classification_id, dbo.product_classification.product_classification_name, dbo.product.product_category_id, dbo.product_category.product_category_name, dbo.product.product_group_id, 
                         dbo.product_group.product_group_name, dbo.product.product_type_id, dbo.product_type.product_type_name, dbo.product.product_brand_id, dbo.product_brand.product_brand_name, 
                         dbo.product.product_attribute_id, dbo.product_attribute.product_attribute_value, dbo.product.is_active, dbo.product_classification.product_classification_code, dbo.product_category.product_category_code, 
                         dbo.product_group.product_group_code, dbo.product_type.product_type_code, dbo.product_brand.product_brand_code, dbo.product_attribute.product_attribute_sequence_no
FROM            dbo.product_brand RIGHT OUTER JOIN
                         dbo.product ON dbo.product_brand.product_brand_id = dbo.product.product_brand_id LEFT OUTER JOIN
                         dbo.product_type ON dbo.product.product_type_id = dbo.product_type.product_type_id LEFT OUTER JOIN
                         dbo.product_attribute ON dbo.product.product_attribute_id = dbo.product_attribute.product_attribute_id LEFT OUTER JOIN
                         dbo.product_group ON dbo.product.product_group_id = dbo.product_group.product_group_id LEFT OUTER JOIN
                         dbo.product_classification ON dbo.product.product_classification_id = dbo.product_classification.product_classification_id LEFT OUTER JOIN
                         dbo.product_category ON dbo.product.product_category_id = dbo.product_category.product_category_id LEFT OUTER JOIN
                         dbo.unit_of_measure ON dbo.product.unit_of_measure_id = dbo.unit_of_measure.unit_of_measure_id
