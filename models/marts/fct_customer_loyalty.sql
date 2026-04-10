with sales as (
    select * from {{ ref('int_sales_details') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

customer_metrics as (
    select
        customer_id,
        count(distinct order_id) as total_orders,
        sum(line_item_revenue) as lifetime_value,
        min(order_date) as first_purchase_date,
        max(order_date) as last_purchase_date
    from sales
    group by 1
),

segmented as (
    select
        c.*,
        m.total_orders,
        m.lifetime_value,
        case 
            when m.lifetime_value > 2000 then 'Gold'
            when m.lifetime_value > 500 then 'Silver'
            else 'Bronze'
        end as loyalty_tier
    from customers c
    left join customer_metrics m on c.customer_id = m.customer_id
)

select * from segmented