# Supply Chain SQL Analysis

An operations-focused SQL analysis of a supply chain dataset, examining supplier performance, inventory risk, shipping efficiency, and product-level profitability across 100 SKUs and 5 suppliers.

## Project Overview

This project analyzes a supply chain dataset to answer operational questions that a business would ask in a typical week: Who are our best suppliers? Where is our inventory at risk? Which shipping modes are most cost-effective? Which products generate the most revenue, and are any of them at risk of stockouts?

The goal was to replicate the type of reporting and analysis that supports real operational decisions — not just data exploration, but insight generation that could drive action.

## Tools Used

- **SQL (SQLite)** for all queries and analysis
- **SQLite Online** as the query environment
- **Kaggle** for dataset sourcing

## Dataset

- **Source:** [Supply Chain Analysis](https://www.kaggle.com/datasets/harshsingh2209/supply-chain-analysis) on Kaggle
- **Size:** 100 SKUs across 3 product categories (skincare, haircare, cosmetics)
- **Scope:** Includes product, pricing, supplier, manufacturing, shipping, and inspection data across 5 locations (Mumbai, Kolkata, Chennai, Bangalore, Delhi)

## Key Findings

**1. Revenue drivers vary by category strategy**
Skincare leads in total revenue despite having mid-range prices — the category wins on volume. Cosmetics has the highest average price but ranks third in revenue, indicating a premium-low-volume strategy. Haircare sells cheap and high-volume.

**2. Top revenue category is also at highest stockout risk**
All three of the top stockout-risk SKUs are in the skincare category — the same category driving the most revenue. This flags an immediate purchasing priority to prevent lost sales.

**3. Supplier 5 has the highest defect rate**
No supplier performs worst across all metrics — Supplier 5 has quality issues but is not the most expensive or slowest. Switching suppliers solves quality but not the other operational concerns.

**4. Cosmetics has the highest failed inspection rate**
Cosmetics combines the highest price point with the highest failed-inspection rate, creating a margin risk: premium pricing is offset by return and rework costs.

**5. Mumbai is the highest-revenue location — and the most expensive to ship to**
Further analysis could evaluate whether a local warehouse or distribution partnership would improve the margin on Mumbai orders.

**6. Air vs. sea shipping tradeoff is clear**
Air is the most expensive per shipping day; sea is the most cost-effective. Standard operational tradeoff, confirmed by the data.

## Techniques Demonstrated

- Aggregations (`SUM`, `AVG`, `COUNT`)
- Grouping and filtering (`GROUP BY`, `WHERE`, `HAVING`)
- Conditional logic (`CASE WHEN`)
- Derived KPIs and calculated fields
- Data type handling (`CAST`, `ROUND`)
- Subqueries
- Window functions with `PARTITION BY` (for top-N per category ranking)

## File Structure

- `queries.sql` — all 11 SQL queries with comments
- `README.md` — this file

## Author

Nicholas Rodriguez
[LinkedIn](https://linkedin.com/in/nick-rodriguez-7421341aa)
