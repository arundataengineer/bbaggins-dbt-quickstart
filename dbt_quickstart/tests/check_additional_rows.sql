select ID,FIRST_NAME,LAST_NAME from  {{source('jaf_shop','customers')}}
minus 
select ID,FIRST_NAME,LAST_NAME from {{ref('vw_customer')}}