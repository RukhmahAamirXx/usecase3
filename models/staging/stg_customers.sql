with source as (
    select * from {{ source('ecommerce_raw', 'customers_raw') }}
)

select
    customer_id,
    first_name,
    last_name,
    email,
    city,
    country,
    signup_date
from source