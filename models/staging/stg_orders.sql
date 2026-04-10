with source as (
    select * from {{ source('ecommerce_raw', 'orders_raw') }}
)

select
    order_id,
    customer_id,
    order_date,
    order_status,
    total_amount as header_total_amount, -- Renamed to distinguish from item totals
    payment_method,
    shipping_address
from source