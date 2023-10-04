with orders as (
    select * from {{ ref('int_orders') }}
)

select * 
from order_items