use superstores;
/* 											ASSIGNMNET NO. 4 								*/

/* 									 Task 1:- Understanding the Data 						*/


/* 
The superstore database is a database of superstore giving information about its sales and shipment 
This database can be used for gaining various outputs using querries which can lead us to gain more ideas for 
boosting the revenue and transaction of the superstores.
*/

/*
 The database consists of 5 tables naming cust_dimen, market_fact, orders_dimen, prod_dimen and 
shipping_dimen. Each tables consist of various data and can be linked to each other through primary keys and 
foreign keys
*/

/*										 	1. Table Information 									*/

/*
cust_dimen- Customer_Name (TEXT) -  Name of the customer
			Province (TEXT) - Province of the customer
			Region (TEXT) - Region of the customer
			Customer_Segment (TEXT) - Segment of the customer
			Cust_id (INT) - Unique Customer ID
*/

/*
 market_fact -  Ord_id (INT) - Order ID
				Prod_id (INT) - Prod ID
				Ship_id (INT) - Shipment ID
				Cust_id (INT) - Customer ID
				Sales (DOUBLE) - Sales from the item sold
				Discount (DOUBLE) - Discount on the item sold
				Order_Quantity (INT) - Order Quantity of the item sold
				Profit (DOUBLE) - Profit from the Item sold
				Shipping_Cost (DOUBLE) - Shipping Cost of the item sold
				Product_Base_Margin (DOUBLE) - Product Base Margin on the item that are sold
*/

/*
order_dimen -	Order_ID (INT): Order ID
				Order_Date (TEXT): Order Date
				Order_Priority (TEXT): Priority of the Order
				Ord_id (INT): Unique Order ID
*/

/*
prod_dimen -	Product_Category (TEXT): Product Category
				Product_Sub_Category (TEXT): Product Sub Category
				Prod_id (INT): Unique Product ID
*/

/*
shipping_dimen - Order_ID (INT): Order ID
				 Ship_Mode (TEXT): Shipping Mode
				 Ship_Date (TEXT): Shipping Date
				 Ship_id (INT): Unique Shipment ID
*/

/* 									2. Primary Key and Foreign key								*/

/*
cust_dimen - Primary Key - Cust_id	
			 Foreign Key - N/A
             
market_fact - Primary Key - N/A	
			  Foreign Key - Cust_id, Ord_id, Prod_id, Ship_id
             
orders_dimen - Primary Key - Ord_id	( Ord_id as Primary Key, although Order_ID is also there but it is advisable to 
							use Ord_id as primary Key to ensure relationship consistency but Order_ID will be used
                            as a foreign key in shipping_dimen will help retrieve the details)
			   Foreign Key - N/A			  
                
prod_dimen - Primary Key - Prod_id
			 Foreign Key - N/A
             
shipping_dimen - Primary Key - Ship_id	
				 Foreign Key - order_id
*/

/*										Task 2:- Basic & Advanced Analysis					*/

/* 1. Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", 
"Customer Segment" from table Cust_dimen.
*/

select customer_name as "Customer Name", customer_segment as "Customer_Segment"
		from cust_dimen;
        
/* 
2. Write a query to find all the details of the customer from the table cust_dimen order by desc.
*/

select * 
		from cust_dimen
        order by cust_id desc;
        
/*
3. Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high.
*/

select order_id, order_date 
		from orders_dimen
		where order_priority = "high";
        
/*
4. Find the total and the average sales (display total_sales and avg_sales)
*/

select sum(sales) as "Total Sales", avg(sales) as "Avg Sales"
		from market_fact;
        
/*
5. Write a query to get the maximum and minimum sales from maket_fact table.
*/

select max(sales) as "Maximum Sales", min(sales) as "Minimum Sales"
		from market_fact;
        
/*
6. Display the number of customers in each region in decreasing order of no_of_customers. 
The result should contain columns Region, no_of_customers.
*/

select Region, count(Cust_id) as "No. of Customers"
		from cust_dimen
		group by Region
		order by count(Cust_id) desc;
        
/*
7. Find the region having maximum customers (display the region name and max(no_of_customers)
*/

select region as "Region Name", count(region) as "max (no. of customer)"
		from cust_dimen;
        
/*
8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of
 tables purchased (display the customer name, no_of_tables purchased)
*/

select c.customer_name, COUNT(*) as no_of_tables_purchased
		from market_fact m inner join cust_dimen c 
				on m.cust_id = c.cust_id
		where c.region = 'atlantic'
		and m.prod_id = ( select prod_id
								from prod_dimen
								where product_sub_category = "tables"	
						)
		group by m.cust_id, c.customer_name;
        
/*
9. Find all the customers from Ontario province who own Small Business. (display the customer name,
 no of small business owners)
*/

select Customer_name, count(customer_segment) as "No. of Small Business Owners"
		from cust_dimen
        where customer_segment = "Small Business"
        and province = "Ontario"
        group by customer_name
        order by count(customer_segment) asc;
        
/*
10. Find the number and id of products sold in decreasing order of products sold (display
 product id, no_of_products sold)
*/

select prod_id as "Product Id", count(Ord_id) as "no_of_products_sold"
		from market_fact
        group by prod_id
        order by count(Ord_id) desc;
        
/*
11. Display product Id and product sub category whose produt category belongs to Furniture and 
Technlogy. The result should contain columns product id, product sub category.
*/
        
select prod_id as "Product Id", product_sub_category
		from prod_dimen
        where product_category = "Furniture"
        or product_category ="Technology";
        
/*
12. Display the product categories in descending order of profits (display the product category wise 
profits i.e. product_category, profits)?
*/

 select p.product_category, sum(m.profit) as profits
		from market_fact m inner join prod_dimen p 
				on m.prod_id = p.prod_id
		group by p.product_category
		order by profits desc;
    
/*
13. Display the product category, product sub-category and the profit within each subcategory in three columns.
*/

select p.product_category, p.product_sub_category, sum(m.profit) as profits
	from market_fact m INNER JOIN prod_dimen p 
			on m.prod_id = p.prod_id
	group by p.product_category, p.product_sub_category
    order by profits desc;
   
/*
14. Display the order date, order quantity and the sales for the order.
*/

select order_date, Order_Quantity, m.sales
		from orders_dimen as o inner join market_fact as m
				on o.Ord_Id = m.Ord_Id
        group by order_date
        order by order_date;
        
/*
15. Display the names of the customers whose name contains the
i) Second letter as ‘R’
ii) Fourth letter as ‘D’
*/

select customer_name 
		from cust_dimen
        where customer_name like "_R%" or "___D%"
        group by customer_name;
        
/*
16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and their region 
where sales are between 1000 and 5000.
*/

select c.cust_id, c.customer_name, c.region, m.sales
		from cust_dimen  as c inner join market_fact as m
			on c.cust_id = m.cust_id
        where sales between 1000 and 5000
        group by cust_id
        order by sales asc;

/*
17. Write a SQL query to find the 3rd highest sales.
*/

select sales
		from market_fact
        order by sales desc
        limit 2,1;
        
/*
18. Where is the least profitable product subcategory shipped the most? For the least profitable 
product sub-category, display the region-wise no_of_shipments and the profit made in each region
 in decreasing order of profits (i.e. region, no_of_shipments, profit_in_each_region)
→ Note: You can hardcode the name of the least profitable product subcategory
*/

 select c.region, count(distinct s.ship_id) as no_of_shipments, sum(m.profit) as profit_in_each_region
				from market_fact as m inner join cust_dimen as c 
					on m.cust_id = c.cust_id
				inner join shipping_dimen as s 
					on m.ship_id = s.ship_id
				inner join prod_dimen as p 
					on m.prod_id = p.prod_id
				WHERE  p.product_sub_category in 
									(select p.product_sub_category from market_fact m inner join prod_dimen p 
											on m.prod_id = p.prod_id 
                                            group by p.product_sub_category 
                                            having sum(m.profit) <= all
													( select sum(m.profit) as profits
															from market_fact m inner join prod_dimen p 
																	on m.prod_id = p.prod_id 
                                                                    group by p.product_sub_category
													)
									)
				GROUP BY c.region
				ORDER BY profit_in_each_region DESC;













