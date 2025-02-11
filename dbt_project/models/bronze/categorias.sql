{{ config(materialized='incremental', unique_key='id', incremental_strategy='merge') }}
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
{% if is_incremental() %}
    -- Pega apenas registros que foram atualizados após o último update da tabela
    WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})
{% endif %}

