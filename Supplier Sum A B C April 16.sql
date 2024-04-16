DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    supplier_name VARCHAR(50)
);

INSERT INTO products (product_id, product_name, supplier_name) VALUES
    (1, 'Product 1', 'Supplier A'),
    (1, 'Product 1', 'Supplier B'),
    (3, 'Product 3', 'Supplier A'),
    (3, 'Product 3', 'Supplier A'),
    (5, 'Product 5', 'Supplier A'),
    (5, 'Product 5', 'Supplier B'),
    (7, 'Product 7', 'Supplier C'),
    (8, 'Product 8', 'Supplier A'),
    (7, 'Product 7', 'Supplier B'),
    (7, 'Product 7', 'Supplier A'),
    (9, 'Product 9', 'Supplier B'),
    (9, 'Product 9', 'Supplier C'),
    (10, 'Product 10', 'Supplier C'),
    (11, 'Product 11', 'Supplier C'),
    (10, 'Product 10', 'Supplier A')
	
SELECT * FROM PRODUCTS

---- Write a query to find products that are sold by 
--both Supplier A and Supplier B, 
--excluding products sold by only one supplier.

SELECT PRODUCT_ID,
	   PRODUCT_NAME,
	   COUNT(SUPPLIER_NAME) AS SELLERS
FROM PRODUCTS
WHERE SUPPLIER_NAME IN ('Supplier A','Supplier B')
GROUP BY PRODUCT_ID,PRODUCT_NAME
HAVING COUNT(DISTINCT SUPPLIER_NAME) = 2

--TASK Find the product that are selling by Supplier C and Supplier B but not Supplier A--
SELECT 
    product_id, 
    product_name,
    COUNT(supplier_name) as cnt_sellers
FROM products
WHERE supplier_name IN ('Supplier B', 'Supplier C')
GROUP BY product_id, product_name
HAVING COUNT(DISTINCT supplier_name) = 2

--Using Analytical Functions

Select product_name from (
	select *, rank() over(partition by product_name order by supplier_name ) as rn
	from products
	where supplier_name in ('Supplier C','Supplier B')
)x
where x.rn=2