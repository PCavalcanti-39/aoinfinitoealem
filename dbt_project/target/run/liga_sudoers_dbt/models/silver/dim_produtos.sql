
  
    
        create or replace table silver.dim_produtos
      
      
    using delta
      
      
      
      
      
    location 's3a://silver/dim_produtos'
      

      as
      WITH cleaned_data AS (
    SELECT 
        p.id, 
        c.descricao AS cat_desc, 
        p.descricao, 
        p.created_at, 
        p.updated_at     
    FROM bronze.produtos p 
            INNER JOIN bronze.categorias c ON c.id = p.id_categoria
    WHERE p.descricao IS NOT NULL 
    /*AND var('is_full') OR 
    CAST('2030-01-01' as DATE)
 IN (CAST(created_at as DATE), CAST(updated_at as DATE))*/
)

SELECT * FROM cleaned_data;
  