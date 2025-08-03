select 
    order_id, 
    sum(order_amount) as total_amount
from {{ ref('stg_orders') }}
group by 1
having not(total_amount >= 0 )