
-- models/categorias.sql
WITH source_data AS (
    SELECT * 
    FROM oltp.categorias
)

SELECT 
    id,
    descricao,
    created_at,
    updated_at
FROM source_data
