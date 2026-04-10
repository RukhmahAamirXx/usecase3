with source as (
    select * from {{ source('ecommerce_raw', 'products_raw') }}
)

select
    product_id,
    product_name,
    category,
    brand,
    price,
    cost,
    is_active
from source