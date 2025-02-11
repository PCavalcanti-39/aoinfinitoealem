-- models/pedidos.sql
WITH source_data AS (
    SELECT * 
    FROM oltp.pedidos
)

SELECT 
    id_pessoa,
    id,
    dt_venda,
    COALESCE(valor_total, 0) AS valor_total,
    created_at,
    updated_at
FROM source_data;
-- WHERE 0 OR CAST(now() as DATE) IN (CAST(created_at as DATE), CAST(updated_at as DATE))