-- ============================================================================
-- QUERY 1: Annual Average CPI and Year-on-Year % Change (2015–2025)
-- ============================================================================
WITH annual AS (
  SELECT
    category,
    year,
    AVG(cpi_index) AS avg_index
  FROM `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.cpi_long`
  WHERE year BETWEEN 2015 AND 2025
  GROUP BY category, year
)
SELECT
  category,
  year,
  ROUND(avg_index, 3) AS avg_index,
  ROUND(
    100.0 * (avg_index / LAG(avg_index) OVER (PARTITION BY category ORDER BY year) - 1),
    2
  ) AS yoy_pct
FROM annual
ORDER BY category, year;
