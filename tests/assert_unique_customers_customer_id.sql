select 
    customer_id
from {{ ref('stg_customers') }}
group by 1
having count(*) > 1