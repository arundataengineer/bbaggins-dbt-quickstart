{{
    config(
            schema = var('sch_jaf'),
            alias = 'VW_JAFFLE_SHOP_PAYMENTS',
            tags = ['GENERATE_VIEW']
    )
}}

with payments as
(
    select 
ID, ORDERID, PAYMENTMETHOD, STATUS, AMOUNT, CREATED, _BATCHED_AT
FROM {{source('stripe','payment')}}
)
SELECT
* FROM payments