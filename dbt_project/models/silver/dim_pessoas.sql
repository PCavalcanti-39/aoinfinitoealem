{{ config(    
    materialized='incremental', 
    unique_key='id', 
    incremental_strategy='merge'
) }}

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
    FROM {{ source('bronze', 'pessoas') }}
    {% if is_incremental() %}
        -- Pega apenas registros que foram atualizados após o último update da tabela
        WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})
    {% endif %}
    
)

SELECT * FROM cleaned_data;
