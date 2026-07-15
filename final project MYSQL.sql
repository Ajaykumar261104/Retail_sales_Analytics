Create database FP1;

select * from FP1.brands;
select *from fp1.categories;
select * from fp1.customers;
select *from fp1.order_items;
select * from fp1.orders;
select * from fp1.products;
select * from fp1.staffs;
select * from fp1.stocks;
select * from fp1.stores;

-- Task 1 (3)
select o.order_id,o.order_date,oi.product_id,p.product_name,oi.quantity,oi.list_price,oi.discount
from fp1.orders as o
inner join fp1.order_items as oi
on o.order_id = oi.order_id
inner join fp1.products as p
on oi.product_id = p.product_id;
    
-- Task 2 (4)
select o.store_id,SUM((oi.list_price * oi.quantity) - oi.discount) as total_sales
from fp1.orders as o
inner join fp1.order_items as oi
on o.order_id = oi.order_id
group by o.store_id
order by total_sales desc;

-- task 3 (5)
select p.product_id,p.product_name,SUM(oi.quantity) as total_quantity_sold
from fp1.order_items as oi
inner join fp1.products as p
on oi.product_id = p.product_id
group by p.product_id, p.product_name
order by total_quantity_sold desc
limit 5;

-- task 4 (6)
select o.customer_id,
    COUNT(distinct o.order_id) as total_orders,
    SUM(oi.quantity) as total_items_purchased,
    SUM((oi.list_price * oi.quantity) - oi.discount) as total_revenue
from fp1.orders as o
inner join fp1.order_items as oi
on o.order_id = oi.order_id
group by o.customer_id
order by total_revenue desc;

-- Task 5(7)
select o.customer_id,SUM((oi.list_price * oi.quantity) - oi.discount) as total_spending,
    case
        when SUM((oi.list_price * oi.quantity) - oi.discount) > 50000 then 'high'
        when SUM((oi.list_price * oi.quantity) - oi.discount) between 10000 and 50000 then 'Medium'
        else 'low'
    end as spending_bracket
from fp1.orders as o
inner join fp1.order_items as oi
on o.order_id = oi.order_id
group by o.customer_id
order by total_spending desc;

-- task 6(8)
select s.staff_id,s.first_name,s.last_name,
    SUM((oi.list_price * oi.quantity) - oi.discount) as total_revenue
from fp1.staffs as s
inner join fp1.orders as o
on s.staff_id = o.staff_id
inner join fp1.order_items as oi
on o.order_id = oi.order_id
group by s.staff_id, s.first_name, s.last_name
order by total_revenue desc; 

-- task 7 (9)
select s.store_id,p.product_id,p.product_name,s.quantity as stock_quantity
from fp1.stocks as s
inner join fp1.products as p
on s.product_id = p.product_id
where s.quantity < 10
order by s.quantity asc;