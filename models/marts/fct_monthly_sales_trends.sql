select
    date_trunc('month', order_date) as sales_month,
    category,
    sum(line_item_revenue) as monthly_revenue,
    count(distinct order_id) as total_orders
from {{ ref('int_sales_details') }}
group by 1, 2
order by 1 desc