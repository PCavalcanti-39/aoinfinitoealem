
    -- back compat for old kwarg name
  
  
  
      
          
          
      
  

  

  merge into bronze.itens_pedidos as DBT_INTERNAL_DEST
      using itens_pedidos__dbt_tmp as DBT_INTERNAL_SOURCE
      on 
              DBT_INTERNAL_SOURCE.id_pedido = DBT_INTERNAL_DEST.id_pedido
          

      when matched then update set
         * 

      when not matched then insert *
