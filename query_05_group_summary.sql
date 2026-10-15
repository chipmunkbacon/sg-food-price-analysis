-- ============================================================================
-- QUERY 5: Group Summary — Food at home vs. Eating out (2015–2025)
-- Creates table: result_group_summary
-- Depends on: result_cumulative (Query 2), category_groups (Query 3)
-- ============================================================================
CREATE OR REPLACE TABLE `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.result_group_summary` AS
SELECT
  g.food_group,
  COUNT(*)                    AS n_categories,
  ROUND(AVG(c.pct_change), 1) AS avg_pct_change,
  ROUND(MIN(c.pct_change), 1) AS min_pct_change,
  ROUND(MAX(c.pct_change), 1) AS max_pct_change
FROM `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.result_cumulative` c
JOIN `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.category_groups` g
  ON c.category = g.category
GROUP BY g.food_group
ORDER BY avg_pct_change DESC;
