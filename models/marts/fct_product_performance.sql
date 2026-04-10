with sales as (
    select 
        product_id,
        product_name,
        category,
        sum(line_item_revenue) as total_revenue,
        sum(quantity) as total_units_sold
    from {{ ref('int_sales_details') }}
    group by 1, 2, 3
),

reviews as (
    select 
        product_id,
        avg(rating) as avg_rating,
        count(review_id) as total_reviews
    from {{ ref('stg_reviews') }}
    group by 1
)

select
    s.*,
    coalesce(r.avg_rating, 0) as avg_rating,
    coalesce(r.total_reviews, 0) as total_reviews
from sales s
left join reviews r on s.product_id = r.product_id