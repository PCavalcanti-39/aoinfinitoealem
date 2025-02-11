create or replace view bronze.auditoria_pedidos
  
  
  as
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
FROM source_data;
-- WHERE 0 OR CAST(now() as DATE) IN (CAST(created_at as DATE), CAST(updated_at as DATE))
