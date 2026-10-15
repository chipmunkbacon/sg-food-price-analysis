-- ============================================================================
-- QUERY 4: Validation Check — Unmapped Food/Beverage Categories
-- Identifies any food or beverage categories not mapped in category_groups
-- Run this after Query 3 to confirm all intended categories are joined
-- ============================================================================
SELECT DISTINCT c.category
FROM `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.cpi_long` c
LEFT JOIN `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.category_groups` g
  ON c.category = g.category
WHERE g.category IS NULL
  AND (
    LOWER(c.category) LIKE '%food%'
    OR LOWER(c.category) LIKE '%beverage%'
  )
ORDER BY c.category;
