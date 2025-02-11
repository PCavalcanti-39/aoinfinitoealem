{{ config(    
    partition_by='created_at'
) }}
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
{% if is_incremental() %}
    -- Pega apenas registros que foram atualizados após o último update da tabela
    WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})
{% endif %}

