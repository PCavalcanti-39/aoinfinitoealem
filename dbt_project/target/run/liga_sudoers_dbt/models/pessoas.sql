create or replace view bronze.pessoas
  
  
  as
    -- models/pessoas.sql
WITH source_data AS (
    SELECT * 
    FROM oltp.pessoas
)

SELECT 
    id,
    nome,
    CASE sexo
        WHEN 'M' THEN 'Masculino'
        WHEN 'F' THEN 'Feminino'
        ELSE 'Indefinido'
    end as sexo,
    CAST(dt_nasc AS DATE) AS dt_nasc,
    created_at,
    updated_at
FROM source_data;
-- WHERE 0 OR CAST(now() as DATE) IN (CAST(created_at as DATE), CAST(updated_at as DATE))
