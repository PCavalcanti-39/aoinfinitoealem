
-- models/pedidos.sql
WITH source_data AS (
    SELECT * 
    FROM oltp.pedidos
)

SELECT 
    id_pessoa,
    id,
    CAST(dt_venda as DATE) as dt_venda,
    COALESCE(valor_total, 0) AS valor_total,
    created_at,
    updated_at
FROM source_data
