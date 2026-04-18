-- ============================================================
-- Supply Chain SQL Analysis
-- Author: Nicholas Rodriguez
-- Dataset: Supply Chain Management SQL Case Study (Kaggle)
-- ============================================================


-- Query 1: Total number of records in the dataset
SELECT COUNT(*) AS total_records
FROM supply_chain_data;


-- Query 2: Count of records by product type
SELECT 
    product_type,
    COUNT(*) AS number_of_records
FROM supply_chain_data
GROUP BY product_type;


-- Query 3: Total revenue by product type
SELECT 
    product_type,
    SUM(revenue_generate) AS total_revenue
FROM supply_chain_data
GROUP BY product_type
ORDER BY total_revenue DESC;


-- Query 4: Average price by product type
SELECT 
    product_type,
    AVG(price) AS avg_price,
    COUNT(*) AS num_products
FROM supply_chain_data
GROUP BY product_type
ORDER BY avg_price DESC;


-- Query 5: Supplier performance - defect rates and manufacturing costs
SELECT 
    supplier_name,
    COUNT(*) AS num_products,
    ROUND(AVG(defect_rates), 2) AS avg_defect_rate,
    ROUND(AVG(manufacturing_co), 2) AS avg_mfg_cost,
    ROUND(AVG(lead_time), 1) AS avg_lead_time
FROM supply_chain_data
GROUP BY supplier_name
ORDER BY avg_defect_rate DESC;


-- Query 6: Shipping mode efficiency - cost vs. speed tradeoff
SELECT 
    transportation_m AS transport_mode,
    COUNT(*) AS num_shipments,
    ROUND(AVG(shipping_costs), 2) AS avg_shipping_cost,
    ROUND(AVG(shipping_times), 1) AS avg_shipping_time,
    ROUND(AVG(shipping_costs) / AVG(shipping_times), 2) AS cost_per_day
FROM supply_chain_data
GROUP BY transportation_m
ORDER BY cost_per_day DESC;


-- Query 7: Products at risk of stockout (high sales, low stock)
SELECT 
    sku,
    product_type,
    stock_levels,
    number_of_produc AS units_sold,
    ROUND(CAST(stock_levels AS FLOAT) / number_of_produc, 2) AS stock_to_sales_ratio
FROM supply_chain_data
WHERE number_of_produc > 0
ORDER BY stock_to_sales_ratio ASC
LIMIT 10;


-- Query 8: Revenue and orders by location
SELECT 
    location,
    COUNT(*) AS num_products,
    SUM(number_of_produc) AS total_units_sold,
    ROUND(SUM(revenue_generate), 2) AS total_revenue,
    ROUND(AVG(shipping_costs), 2) AS avg_shipping_cost
FROM supply_chain_data
GROUP BY location
ORDER BY total_revenue DESC;


-- Query 9: Impact of inspection results on manufacturing costs
SELECT 
    inspection_resul AS inspection_result,
    COUNT(*) AS num_products,
    ROUND(AVG(manufacturing_co), 2) AS avg_mfg_cost,
    ROUND(AVG(defect_rates), 2) AS avg_defect_rate,
    ROUND(SUM(CASE WHEN defect_rates > 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_high_defect
FROM supply_chain_data
GROUP BY inspection_resul
ORDER BY avg_defect_rate DESC;


-- Query 10: Rank top 3 revenue-generating products within each category
SELECT 
    product_type,
    sku,
    revenue_generate,
    revenue_rank
FROM (
    SELECT 
        product_type,
        sku,
        revenue_generate,
        RANK() OVER (PARTITION BY product_type ORDER BY revenue_generate DESC) AS revenue_rank
    FROM supply_chain_data
) ranked
WHERE revenue_rank <= 3
ORDER BY product_type, revenue_rank;


-- Query 11: Operations scorecard by product type
SELECT 
    product_type,
    COUNT(*) AS num_skus,
    ROUND(SUM(revenue_generate), 2) AS total_revenue,
    ROUND(AVG(defect_rates), 2) AS avg_defect_rate,
    ROUND(AVG(lead_time), 1) AS avg_lead_time_days,
    ROUND(AVG(manufacturing_co), 2) AS avg_mfg_cost,
    ROUND(SUM(CASE WHEN inspection_resul = 'Fail' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_failed_inspection,
    ROUND(AVG(stock_levels), 0) AS avg_stock_on_hand
FROM supply_chain_data
GROUP BY product_type
ORDER BY total_revenue DESC;
