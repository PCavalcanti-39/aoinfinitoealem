
WITH orders AS (
    SELECT 
        p.id AS id_pedido, 
        p.id_pessoa, 
        i.id_produto, 
        a.dispositivo, 
        a.geohash,
        a.telefone,
        p.dt_venda,
        i.qtde, 
        i.valor_total AS valor_unit,
        p.valor_total, 
        p.created_at,
        p.updated_at
    FROM bronze.pedidos p 
        INNER JOIN bronze.itens_pedidos i 
        ON p.id = i.id_pedido 
        INNER JOIN bronze.auditoria_pedidos a 
        ON p.id = a.id_pedido
    

)

SELECT * FROM orders;