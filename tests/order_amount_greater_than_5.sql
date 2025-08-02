select 
    order_total
from {{ ref('fct_orders')}}
where order_total <= 5