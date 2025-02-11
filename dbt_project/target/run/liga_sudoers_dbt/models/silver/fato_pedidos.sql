
  
    
        create or replace table silver.fato_pedidos
      
      
    using delta
      
      
      partitioned by (dt_venda)
      
      
    location 's3a://silver/fato_pedidos'
      

      as
      
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
        p.valor_total 
    FROM bronze.pedidos p 
        INNER JOIN bronze.itens_pedidos i 
        ON p.id = i.id_pedido 
        INNER JOIN bronze.auditoria_pedidos a 
        ON p.id = a.id_pedido
    /* WHERE var('is_full') OR 
    CAST('2030-01-01' as DATE)
 IN (CAST(created_at as DATE), CAST(updated_at as DATE)) */
)

SELECT * FROM orders;
  