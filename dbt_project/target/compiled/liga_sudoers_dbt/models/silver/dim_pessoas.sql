

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
    
    
)

SELECT * FROM cleaned_data;