
CREATE VIEW [dbo].[default_menus_v]
AS
SELECT        '' AS role_menu_id, '' AS role_id, '' AS is_write, '' AS is_delete, dbo.menus.menu_id, dbo.menus.pmenu_id, dbo.menus.menu_name, dbo.menus.seq_no, dbo.menus.is_default, dbo.pages.page_id, 
                         dbo.pages.page_name, dbo.pages.page_title
FROM            dbo.menus INNER JOIN
                         dbo.pages ON dbo.menus.page_id = dbo.pages.page_id
WHERE        (dbo.menus.is_default = 'Y')

