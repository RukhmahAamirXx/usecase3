with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    -- You'll need to create stg_order_items.sql if you haven't yet!
    select * from {{ ref('stg_order_items') }}
),

products as (
    -- You'll need to create stg_products.sql if you haven't yet!
    select * from {{ ref('stg_products') }}
),

joined as (
    select
        oi.item_id,
        o.order_id,
        o.customer_id,
        o.order_date,
        p.product_id,
        p.product_name,
        p.category,
        oi.quantity,
        oi.unit_price as item_price_at_sale,
        p.cost as unit_cost,
        -- Calculated Fields
        (oi.quantity * oi.unit_price) as line_item_revenue,
        (oi.quantity * (oi.unit_price - p.cost)) as line_item_profit,
        o.header_total_amount
    from order_items oi
    join orders o on oi.order_id = o.order_id
    join products p on oi.product_id = p.product_id
),

final_with_anomaly_check as (
    select
        *,
        -- Anomaly Detection: Does the sum of items match the order header?
        case 
            when sum(line_item_revenue) over(partition by order_id) != header_total_amount 
            then TRUE 
            else FALSE 
        end as is_amount_anomaly
    from joined
)

select * from final_with_anomaly_check