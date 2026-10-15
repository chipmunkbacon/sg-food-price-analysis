-- ============================================================================
-- QUERY 3: Lookup Table — Category Groups (Food at home vs. Eating out)
-- Creates table: category_groups
-- Note: Category names must match SingStat exactly (use & not "and")
-- ============================================================================
CREATE OR REPLACE TABLE `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.category_groups` (
  category   STRING,
  food_group STRING
);

INSERT INTO `project-3be6fcb1-65ce-42aa-a59.sg_food_prices.category_groups` (category, food_group)
VALUES
  -- Food at home (groceries)
  ('Rice & Cereal Products',            'Food at home'),
  ('Meat',                              'Food at home'),
  ('Fish & Other Seafood',              'Food at home'),
  ('Vegetables',                        'Food at home'),
  ('Fruits & Nuts',                     'Food at home'),
  ('Milk, Other Dairy Products & Eggs', 'Food at home'),
  ('Oils & Fats',                       'Food at home'),
  ('Sugar, Confectionery & Desserts',   'Food at home'),
  ('Non-Alcoholic Beverages',           'Food at home'),
  -- Eating out (dining services)
  ('Food & Beverage Serving Services',  'Eating out');
