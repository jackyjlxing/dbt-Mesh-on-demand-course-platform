with order_items as (
    select * from {{ ref('stg_order_items') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

locations as (
    select * from {{ ref('stg_locations') }}
),

joined as (
    select
        order_items.*,
        orders.ordered_at,
        customers.*,
        locations.*

    from order_items
        left join orders 
            on order_items.order_id  = orders.order_id
        left join customers 
            on orders.customer_id = customers.customer_id
        left join locations 
            on orders.location_id = locations.location_id    
)

select * from joined