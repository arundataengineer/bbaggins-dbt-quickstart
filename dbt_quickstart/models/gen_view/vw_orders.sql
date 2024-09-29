{{
    config(
            schema = var('sch_jaf'),
            alias = 'VW_JAFFLE_SHOP_ORDERS_INFO',
            tags = ['GENERATE_VIEW']
    )
}}

WITH ORDERS AS 
(SELECT 
ID, 
    USER_ID, 
    ORDER_DATE, 
    STATUS, 
    _ETL_LOADED_AT
FROM {{source('jaf_shop','orders')}})
SELECT * FROM ORDERS