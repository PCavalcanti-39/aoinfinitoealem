
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
FROM source_data
