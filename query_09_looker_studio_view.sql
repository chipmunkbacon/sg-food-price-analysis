-- ============================================================================
-- QUERY 9: Looker Studio View
-- Combines rebased index + food group labels for use in Looker Studio charts
-- Creates view: looker_food_trend
-- Add this as a data source in Looker Studio via BigQuery connector
-- ============================================================================
CREATE OR REPLACE VIEW `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.looker_food_trend` AS
WITH annual AS (
  SELECT
    category,
    year,
    AVG(cpi_index) AS avg_index
  FROM `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.cpi_long`
  WHERE year BETWEEN 2015 AND 2025
  GROUP BY category, year
),
rebased AS (
  SELECT
    category,
    year,
    avg_index,
    100.0 * avg_index
      / MAX(CASE WHEN year = 2015 THEN avg_index END) OVER (PARTITION BY category)
      AS index_2015_100
  FROM annual
)
SELECT
  PARSE_DATE('%Y', CAST(r.year AS STRING)) AS date_year,
  r.year,
  r.category,
  CASE
    WHEN r.category IN (
      'Rice & Cereal Products',
      'Meat',
      'Fish & Other Seafood',
      'Vegetables',
      'Fruits & Nuts',
      'Milk, Other Dairy Products & Eggs',
      'Oils & Fats',
      'Sugar, Confectionery & Desserts',
      'Non-Alcoholic Beverages'
    ) THEN 'Food at home'
    WHEN r.category IN (
      'Food & Beverage Serving Services',
      'Fast Food Restaurants',
      'Hawker Centres, And Food Courts, Coffee Shops & Kiosks',
      'Restaurants, Cafes & Pubs'
    ) THEN 'Eating out'
    ELSE 'Other / Headline'
  END AS food_group,
  ROUND(r.avg_index, 2)      AS avg_index,
  ROUND(r.index_2015_100, 2) AS index_2015_100
FROM rebased r;
