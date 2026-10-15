-- ============================================================================
-- QUERY 8: Headline Food Series Comparison
-- 10-year % change for the 3 key headline food series
-- Creates table: result_food_series
-- Depends on: result_cumulative (Query 2)
-- Note: SingStat uses abbreviation 'Excl', not 'Excluding'
-- ============================================================================
CREATE OR REPLACE TABLE `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.result_food_series` AS
SELECT
  category,
  ROUND(pct_change, 1) AS pct_change
FROM `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.result_cumulative`
WHERE category IN (
  'Food',
  'Food & Beverage Serving Services',
  'Food Excl Food & Beverage Serving Services'
)
ORDER BY pct_change DESC;
