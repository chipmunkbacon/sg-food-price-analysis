-- ============================================================================
-- QUERY 7: Annual Group Rebased Index (Food at home vs. Eating out over time)
-- Creates table: annual_group_index
-- Depends on: annual_index (Query 6), category_groups (Query 3)
-- ============================================================================
CREATE OR REPLACE TABLE `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.annual_group_index` AS
SELECT
  g.food_group,
  r.year,
  ROUND(AVG(r.index_2015_100), 2) AS group_index
FROM `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.annual_index` r
JOIN `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.category_groups` g
  ON r.category = g.category
GROUP BY g.food_group, r.year
ORDER BY g.food_group, r.year;
