create or replace view bronze.categorias
  
  
  as
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
FROM source_data;
-- WHERE 0 OR CAST(now() as DATE) IN (CAST(created_at as DATE), CAST(updated_at as DATE))
