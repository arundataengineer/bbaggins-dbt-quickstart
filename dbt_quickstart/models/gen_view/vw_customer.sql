{{
    config (
            schema = var('sch_jaf'),
            alias = 'VW_JAFFLE_SHOP_CUST_INFO',
            tags = ['GENERATE_VIEW']
    )
}}

WITH CUST_INFO AS
(SELECT 
ID, 
FIRST_NAME, 
LAST_NAME
FROM {{source('jaf_shop','customers')}})
SELECT 
    ID, 
    FIRST_NAME, 
    LAST_NAME
FROM CUST_INFO