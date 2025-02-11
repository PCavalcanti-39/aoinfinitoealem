{{ config(    
    partition_by='dt_venda',
    materialized='incremental', 
    unique_key='id_pedido, nome, descricao, dt_venda', 
    incremental_strategy='merge'
) }}
WITH itens_person AS (
    SELECT 
        dp.nome, 
        dp.sexo, 
        dp.dt_nasc, 
        dpr.cat_desc, 
        dpr.descricao, 
        fp.id_pedido, 
        fp.dt_venda, 
        fp.dispositivo, 
        fp.geohash, 
        COALESCE(valor_unit, 0 ) as total
    FROM {{ source('silver', 'fato_pedidos') }} fp
        INNER JOIN {{ source('silver', 'dim_produtos') }} dpr ON dpr.id = fp.id_produto
        INNER JOIN {{ source('silver','dim_pessoas') }} dp ON dp.id = fp.id_pessoa    
    {% if is_incremental() %}
        -- Pega apenas registros que foram atualizados após o último update da tabela
        WHERE fp.updated_at > (SELECT MAX(fp.updated_at) FROM {{ this }})
    {% endif %}

    ORDER BY 6 desc, 1, 2, 3, 4, 5, 7, 8
)

SELECT * FROM itens_person;







