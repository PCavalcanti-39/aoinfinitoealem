-- models/produtos.sql
WITH source_data AS (
    SELECT * 
    FROM oltp.produtos
)

SELECT 
    id_categoria,
    id,
    descricao,
    COALESCE(valor_unit, 0) AS valor_unit,
    created_at,
    updated_at
FROM source_data;
-- WHERE 0 OR CAST(now() as DATE) IN (CAST(created_at as DATE), CAST(updated_at as DATE))