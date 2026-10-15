-- ============================================================================
-- QUERY 6: Annual Rebased Index per Category (2015 = 100)
-- Creates table: annual_index
-- Categories without a 2015 baseline are excluded (SAFE_DIVIDE handles nulls)
-- ============================================================================
CREATE OR REPLACE TABLE `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.annual_index` AS
WITH annual AS (
  SELECT
    category,
    year,
    AVG(cpi_index) AS avg_index
  FROM `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.cpi_long`
  WHERE year BETWEEN 2015 AND 2025
  GROUP BY category, year
),
base_2015 AS (
  SELECT
    category,
    year,
    avg_index,
    MAX(CASE WHEN year = 2015 THEN avg_index END) OVER (PARTITION BY category) AS base_idx
  FROM annual
)
SELECT
  category,
  year,
  ROUND(avg_index, 3)                                AS avg_index,
  ROUND(100.0 * SAFE_DIVIDE(avg_index, base_idx), 2) AS index_2015_100
FROM base_2015
WHERE base_idx IS NOT NULL
ORDER BY category, year;
