

WITH cleaned_data AS (
    SELECT 
        p.id, 
        c.descricao AS cat_desc, 
        p.descricao, 
        p.created_at, 
        p.updated_at     
    FROM bronze.produtos p 
            INNER JOIN bronze.categorias c ON c.id = p.id_categoria
    
)

SELECT * FROM cleaned_data;