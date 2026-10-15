-- ============================================================================
-- QUERY 2: Cumulative 10-Year Price Change (2015 to 2025), Ranked
-- Creates table: result_cumulative
-- ============================================================================
CREATE OR REPLACE TABLE `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.result_cumulative` AS
WITH annual_2015_2025 AS (
  SELECT
    category,
    AVG(CASE WHEN year = 2015 THEN cpi_index END) AS start_idx,
    AVG(CASE WHEN year = 2025 THEN cpi_index END) AS end_idx
  FROM `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.cpi_long`
  WHERE year IN (2015, 2025)
  GROUP BY category
)
SELECT
  category,
  ROUND(100.0 * (end_idx / start_idx - 1), 2) AS pct_change,
  RANK() OVER (ORDER BY (end_idx / start_idx) DESC) AS price_rank
FROM annual_2015_2025
WHERE start_idx IS NOT NULL
  AND end_idx   IS NOT NULL
ORDER BY price_rank;
