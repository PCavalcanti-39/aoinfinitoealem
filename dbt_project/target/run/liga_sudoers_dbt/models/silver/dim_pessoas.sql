
  
    
        create or replace table silver.dim_pessoas
      
      
    using delta
      
      
      
      
      
    location 's3a://silver/dim_pessoas'
      

      as
      WITH cleaned_data AS (
    SELECT 
        id,
        nome,
        CASE 
            WHEN sexo = 'M' THEN 'Masculino'
            WHEN sexo = 'F' THEN 'Feminino'
            ELSE 'Indefinido'
        END AS sexo,
        CAST(dt_nasc AS DATE) AS dt_nasc,
        created_at,
        updated_at
    FROM bronze.pessoas
    WHERE nome IS NOT NULL /* AND var('is_full') OR 
    CAST('2030-01-01' as DATE)
 IN (CAST(created_at as DATE), CAST(updated_at as DATE))*/
    
)

SELECT * FROM cleaned_data;
  