-- models/itens_pedidos.sql
WITH source_data AS (
    SELECT * 
    FROM oltp.itens_pedidos
)

SELECT 
    id_pedido,
    id_produto,
    COALESCE(qtde, 0 ) AS qtde,
    COALESCE(valor_total, 0) AS valor_total,
    created_at,
    updated_at
FROM source_data;
-- WHERE 0 OR CAST(now() as DATE) IN (CAST(created_at as DATE), CAST(updated_at as DATE))