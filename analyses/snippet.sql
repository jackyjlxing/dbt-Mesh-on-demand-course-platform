--select * from {{ ref('fct_orders', v=2)}}

select customer_id
from {{ ref('stg_customers')}}
group by customer_id
having count(*) > 1