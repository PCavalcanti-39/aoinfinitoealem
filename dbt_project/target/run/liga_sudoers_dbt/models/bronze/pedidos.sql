
    -- back compat for old kwarg name
  
  
  
      
          
          
      
  

  

  merge into bronze.pedidos as DBT_INTERNAL_DEST
      using pedidos__dbt_tmp as DBT_INTERNAL_SOURCE
      on 
              DBT_INTERNAL_SOURCE.id = DBT_INTERNAL_DEST.id
          

      when matched then update set
         * 

      when not matched then insert *
