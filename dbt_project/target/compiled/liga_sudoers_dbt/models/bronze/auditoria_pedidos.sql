
-- models/auditoria_pedidos.sql
WITH source_data AS (
    SELECT * 
    FROM oltp.auditoria_pedidos
)

SELECT 
    id_pedido,
    dispositivo,
    geohash,
    telefone,
    created_at,
    updated_at
FROM source_data
