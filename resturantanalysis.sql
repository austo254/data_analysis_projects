-- --------- TOTAL ITEMS IN THE MENU LIST ----------

SELECT 
COUNT(*) AS TOTAL_ITEMS
FROM
restaurant_db.menu_items;

-- ---------- LEAST AND MOST EXPENSIVE ITEMS IN THE MENU LIST ------------
SELECT 
MAX(price) as highest_price
FROM
menu_items;
select
item_name
from
menu_items
where price = 19.95;

SELECT 
min(price) as lowest_price
FROM
menu_items;
select
item_name
from
menu_items
where price = 5.00;

-- ----------- NUMBER OF ITALIAN DISHES ON THE MENU AND THE LEAST AND MOST EXPENSIVE ITEMS ----
SELECT
count(category) as italian_dishes
from
menu_items
where category = 'italian';

select *
from
menu_items
WHERE price = (SELECT MAX(price) FROM menu_items) and category = 'italian'
limit 1;

select 
MIN(price) FROM menu_items
WHERE category = 'italian';


-- -------- HOW MANY DISHES ARE IN EACH CATEGORY -------
select
category,
COUNT(item_name) as total_items,
avg(price) as avg_dish_price
from
menu_items
group by
category
order by avg_dish_price desc;

-- ------------ WHAT IS THE DATE RANGE OF THE TABLE ----------
SELECT MIN(order_date) AS start_date, 
MAX(order_date) AS end_date
FROM order_details;

-- -------------- HOW MANY ORDER AND ITEMS WERE MADE DURING THIS DATE RANGE -------
SELECT 
COUNT(DISTINCT order_id) as total_orders,
COUNT(order_details_id) as total_items
FROM order_details;

-- --------------- WHICH ORDERS HAD THE MOST NUMBER OF ITEMS -----------------
SELECT
order_id,
COUNT(order_details_id) as total_items_in_order
FROM order_details
group by order_id
order by total_items_in_order DESC
Limit 10;

-- -------------- HOW MANY ORDERS HAD MORE THAN 12 ITEMS ---------------
SELECT
order_id,
COUNT(order_details_id) as total_items_in_order
FROM order_details
group by order_id
HAVING total_items_in_order > 12;

-- --- OBJECTIVE 3 ----
-- ----- COMMBINING MENU_ITEMS AND ORDER_DETAILS INTO ONE TABLE ----------
SELECT *
FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id = order_details.item_id

UNION

SELECT *
FROM menu_items
RIGHT JOIN  order_details ON menu_items.menu_item_id = order_details.item_id;

-- -------- least and most ordered items what categories were they in ----------
CREATE TABLE new_table_name AS
SELECT*
FROM (
SELECT *
FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id = order_details.item_id

UNION

SELECT *
FROM menu_items
RIGHT JOIN  order_details ON menu_items.menu_item_id = order_details.item_id) as joined_table;

SELECT 
count(item_name) as total_items,
category
from
new_table_name
group by category
order by total_items desc;

-- ----------to 5 orders that spent the most money -------------------
select 
order_id,
SUM(price) as totals_per_order
from
new_table_name
group by order_id
order by SUM(price) desc
limit 5;
-- ---- what was orderd in the highest order code -----------
select *
from new_table_name
where order_id = 440;







