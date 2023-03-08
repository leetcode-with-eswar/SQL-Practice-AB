create database customers;

Use customers;

##Find order date , new_customer_count,repeat_customer_count
create table customer_orders(order_id int PRIMARY key , customer_id int, order_date Date , order_amount int);

insert into customer_orders values(1,100,'2022-01-01',2000),
(2,200,'2022-01-01',2500),
(3,300,'2022-01-01',2100),
(4,100,'2022-01-02',2000),
(5,400,'2022-01-02',2200),
(6,500,'2022-01-02',2700),
(7,100,'2022-01-03',3000),
(8,400,'2022-01-03',1000),
(9,600,'2022-01-03',3000);

select * from customer_orders;


with t1 as (select
                customer_id, min(order_date) as fdate
            FROM
                customer_orders
            group by customer_id)
SELECT
    a.order_date, 
    sum(case when t1.fdate is not null then 1 
            else 0 
        end )as new_customers,
    sum(case when t1.fdate is null then 1 
    else 0 
    end )as repeat_customers
FROM
    customer_orders a
        left JOIN
    t1 on t1.customer_id = a.customer_id and t1.fdate = a.order_date
group by a.order_date;