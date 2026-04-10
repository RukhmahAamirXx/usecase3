with source as (
    select * from {{ source('ecommerce_raw', 'raw_reviews') }}
),

flattened as (
    select
        json_content:review_id::int as review_id,
        json_content:product_id::int as product_id,
        json_content:customer_id::int as customer_id,
        json_content:rating::int as rating,
        json_content:review_text::string as review_text,
        json_content:review_date::date as review_date,
        json_content:verified_purchase::boolean as is_verified
    from source
)

select * from flattened