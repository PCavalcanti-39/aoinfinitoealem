
  
    
        create or replace table bronze.auditoria_pedidos
      
      
    using delta
      
      
      partitioned by (created_at)
      
      
    location 's3a://bronze/auditoria_pedidos'
      

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
FROM source_data

  