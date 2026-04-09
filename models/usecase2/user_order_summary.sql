{{ config(
    materialized='table',
    alias='user_order_summary'
) }}

WITH source_users AS (
    SELECT * FROM {{ source('streamsets_raw', 'users') }}
),

source_orders AS (
    SELECT 
        user_id,
        COUNT(order_id) as total_orders,
        SUM(total_order_amount) as total_order_amount
    FROM {{ source('streamsets_raw', 'orders') }}
    GROUP BY 1
),

source_demographics AS (
    -- Referencing the seed we just made
    SELECT 
        user_id,
        age,
        gender,
        location
    FROM {{ ref('user_demographics') }}
)

SELECT 
    u.user_id,
    u.name,
    u.email,
    d.gender,
    d.location,
    d.age,
    -- Age Categorization
    CASE 
        WHEN d.age BETWEEN 18 AND 24 THEN '18-24'
        WHEN d.age BETWEEN 25 AND 34 THEN '25-34'
        WHEN d.age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45+' 
    END as age_group,
    COALESCE(o.total_orders, 0) as total_orders,
    COALESCE(o.total_order_amount, 0) as total_revenue,
    -- Average Order Value
    (COALESCE(o.total_order_amount, 0) / NULLIF(COALESCE(o.total_orders, 0), 0)) as avg_order_value
FROM source_users u
LEFT JOIN source_orders o ON u.user_id = o.user_id
LEFT JOIN source_demographics d ON u.user_id = d.user_id