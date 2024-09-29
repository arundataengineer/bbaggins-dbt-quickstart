
select * from 
{{ref('vw_stripe_payments')}}
WHERE AMOUNT < 0