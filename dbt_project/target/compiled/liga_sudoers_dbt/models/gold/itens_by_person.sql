
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
    FROM silver.fato_pedidos fp
        INNER JOIN silver.dim_produtos dpr ON dpr.id = fp.id_produto
        INNER JOIN silver.dim_pessoas dp ON dp.id = fp.id_pessoa    
    

    ORDER BY 6 desc, 1, 2, 3, 4, 5, 7, 8
)

SELECT * FROM itens_person;