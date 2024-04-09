use restaurant_db;
show tables;

# EXPLORE THE MENU_ITEM TABLE
select count(*) from menu_items;
select * from menu_items;

# for finding the least expensive item from the menu
select * from menu_items order by price asc;

# for checking the number of Italian dishes.
select count(*) from menu_items where category = "Italian";

# for least expensive Italian dishes
select * from menu_items where category = "Italian" order by price;

# for most expensive Italian dishes
select * from menu_items where category = "Italian" order by price desc;

# for finding the average price of the dishes based on categories. 
select category, avg(price) as average_dish_price from menu_items group by category;

# for finding the number of dishes in each categories 
select category, count(menu_item_id) from menu_items group by category;

# Explore the order tables
# what is the range of the table?
show tables;
select min(order_date) as staring_date, max(order_date) as ending_date 
from order_details order by order_date;

# how many orders are made within the date range?
select count(distinct order_id) as total_unique_orders from order_details;

# how many items were ordered within this date range?
select count(*) from order_details;

# which order has most number of items
select * from order_details;
select order_id, count(item_id) as number_of_items 
from order_details group by order_id order by count(item_id) desc;

# how many orders have more than 12 items?
select count(*) from (select order_id, count(item_id) as number_of_orders 
from order_details group by order_id 
having count(item_id) > 12 order by count(item_id)desc) as num_orders;


# Analyze customer behaviour
# combine menu_items, order_daetails
select * from menu_items m join order_details o on m.menu_item_id = o.item_id;

#what were the least and most ordered items? what categories were they in?
# most ordered and least order
select m.category,count(o.item_id) as no_time_orderd ,m.item_name as most_ordered_item
from menu_items m join order_details o on m.menu_item_id = o.item_id
 group by o.item_id,m.category,m.item_name
 order by count(o.item_id) desc;


# what were the top 5 orders
select  o.order_id, sum(m.price) as price 
from menu_items m join order_details o on m.menu_item_id = o.item_id
group by o.order_id order by sum(m.price) desc limit 5; 

# View the details of the highest spend order. which specific itmes were purchased?
select m.category, o.order_id,m.item_name, m.price from menu_items m join order_details o
 where o.order_id = 440 group by m.category,o.order_id,m.price,m.item_name;
 
 # View the details of the top 5 highest spend orders.
 select o.order_id,  m.category, count(o.item_id) as num_items from menu_items m right join order_details o on m.menu_item_id = o.item_id
 where o.order_id in (440,2075,1957,330,2675) group by o.order_id,m.category;
 
 





