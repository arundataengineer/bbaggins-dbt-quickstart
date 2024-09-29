{{
    config(
            materialized = 'table',
            schema = var('sch_tran'),
            alias = 'TBL_JAFFLE_SHOP_CUST_PURCHASE',
            tags = ['TRANS']
    )
}}

WITH CUSTOMERS AS
(
    SELECT
        ID AS customer_id, 
        FIRST_NAME, 
        LAST_NAME
    FROM {{ref('vw_customer')}}
),
ORDERS AS
(
    SELECT
        ID AS ORDER_ID, 
        USER_ID AS customer_id, 
        ORDER_DATE, 
        STATUS
    FROM {{ref('vw_orders')}}
),
CUSTOMER_ORDERS AS
(
    SELECT
        ORDERS.customer_id,
        MIN(ORDER_DATE) AS FIRST_ORDER_DT,
        MAX(ORDER_DATE) AS MOST_RECENT_ORDER_DT,
        COUNT(ORDER_ID) AS NO_OF_ORDERS
    FROM ORDERS
      GROUP BY 1
),
FINAL AS
(
    SELECT
        CU.customer_id,
        CU.FIRST_NAME,
        ORD.FIRST_ORDER_DT,
        ORD.MOST_RECENT_ORDER_DT,
        COALESCE(ORD.NO_OF_ORDERS,0) as number_of_orders
    FROM CUSTOMERS AS CU
    LEFT JOIN CUSTOMER_ORDERS AS ORD ON CU.customer_id = ORD.customer_id
)
SELECT * FROM FINAL 