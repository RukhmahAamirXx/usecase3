with source as (
    select * from {{ source('ecommerce_raw', 'order_items_raw') }}
)

select
    item_id,
    order_id,
    product_id,
    quantity,
    unit_price
from source