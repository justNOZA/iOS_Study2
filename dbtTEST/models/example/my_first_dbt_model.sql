{{ config(materialized='table')}} 

with source_data as {
          select 1 as NAME
          union all
}  
select * from source_data where NAME is not null
