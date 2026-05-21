CREATE DATABASE Restaurant_Menu_DB;
USE Restaurant_Menu_DB;
describe categories;
describe menu_items;
describe customers;
describe orders;
describe order_details;
describe payments;


CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(8,2) NOT NULL,
    availability BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    amount DECIMAL(8,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);



INSERT INTO categories VALUES
(1, 'Starters'),
(2, 'Main Course'),
(3, 'Desserts');

INSERT INTO menu_items VALUES
(101, 'Paneer Tikka', 1, 220.00, TRUE),
(102, 'Veg Biryani', 2, 180.00, TRUE),
(103, 'Gulab Jamun', 3, 90.00, TRUE);

INSERT INTO customers VALUES
(1, 'Amit Sharma', '9876543210'),
(2, 'Neha Verma', '9123456780');

INSERT INTO orders VALUES
(1001, 1, '2026-01-25'),
(1002, 2, '2026-01-26');

INSERT INTO order_details VALUES
(1, 1001, 101, 2),
(2, 1001, 103, 1),
(3, 1002, 102, 1);

INSERT INTO payments VALUES
(1, 1001, 'UPI', 530.00),
(2, 1002, 'Cash', 180.00);

SELECT m.item_name, c.category_name, m.price
FROM menu_items m
JOIN categories c ON m.category_id = c.category_id;

SELECT item_name, price
FROM menu_items
WHERE availability = TRUE;

SELECT SUM(amount) AS total_revenue
FROM payments;

SELECT cu.customer_name, o.order_id, o.order_date
FROM customers cu
JOIN orders o ON cu.customer_id = o.customer_id;

SELECT item_name, price
FROM menu_items
WHERE price = (SELECT MAX(price) FROM menu_items);

SELECT c.category_name, SUM(p.amount) AS total_sales
FROM categories c
JOIN menu_items m ON c.category_id = m.category_id
JOIN order_details od ON m.item_id = od.item_id
JOIN payments p ON od.order_id = p.order_id
GROUP BY c.category_name;

CREATE TABLE category (
    category_id VARCHAR(5) PRIMARY KEY,
    category_name VARCHAR(50),
    active TINYINT,
    created_at TIMESTAMP
);
INSERT INTO category VALUES
('C01','Starters',1,'2026-01-01 09:00:00'),
('C02','Main Course',1,'2026-01-01 09:00:00'),
('C03','Desserts',1,'2026-01-01 09:00:00'),
('C04','Beverages',1,'2026-01-01 09:00:00');

SELECT * FROM category;

CREATE TABLE menu_item (
    item_id VARCHAR(5) PRIMARY KEY,
    item_name VARCHAR(100),
    category_id VARCHAR(5),
    price DECIMAL(8,2),
    available TINYINT,
    created_at TIMESTAMP
);

INSERT INTO menu_item VALUES
('M01','Paneer Tikka','C01',220.00,1,'2026-01-01 09:00:00'),
('M02','Veg Spring Roll','C01',150.00,1,'2026-01-01 09:00:00'),
('M03','Veg Biryani','C02',180.00,1,'2026-01-01 09:00:00'),
('M04','Paneer Butter Masala','C02',240.00,1,'2026-01-01 09:00:00'),
('M05','Gulab Jamun','C03',90.00,1,'2026-01-01 09:00:00'),
('M06','Cold Coffee','C04',130.00,1,'2026-01-01 09:00:00');

SELECT * FROM menu_item;

CREATE TABLE customer (
    customer_id VARCHAR(5) PRIMARY KEY,
    customer_name VARCHAR(100),
    phone VARCHAR(15),
    created_at TIMESTAMP
);

INSERT INTO customer VALUES
('CU01','Amit Sharma','9876543210','2026-01-01 09:00:00'),
('CU02','Neha Verma','9123456780','2026-01-01 09:00:00'),
('CU03','Rahul Mehta','9988776655','2026-01-01 09:00:00');

SELECT * FROM customer;

CREATE TABLE orders (
    order_id VARCHAR(5) PRIMARY KEY,
    customer_id VARCHAR(5),
    order_date DATE,
    created_at TIMESTAMP
);

INSERT INTO orders VALUES
('O01','CU01','2026-01-25','2026-01-25 13:30:00'),
('O02','CU02','2026-01-26','2026-01-26 14:15:00'),
('O03','CU03','2026-01-26','2026-01-26 19:45:00');

SELECT * FROM orders;

CREATE TABLE order_details (
    order_detail_id VARCHAR(5) PRIMARY KEY,
    order_id VARCHAR(5),
    item_id VARCHAR(5),
    quantity INT,
    created_at TIMESTAMP
);

INSERT INTO order_details VALUES
('OD01','O01','M01',2,'2026-01-25 13:30:00'),
('OD02','O01','M05',1,'2026-01-25 13:30:00'),
('OD03','O02','M03',1,'2026-01-26 14:15:00'),
('OD04','O03','M04',1,'2026-01-26 19:45:00');

SELECT * FROM order_details;

CREATE TABLE payment (
    payment_id VARCHAR(5) PRIMARY KEY,
    order_id VARCHAR(5),
    payment_method VARCHAR(50),
    amount DECIMAL(8,2),
    created_at TIMESTAMP
);

INSERT INTO payment VALUES
('P01','O01','UPI',530.00,'2026-01-25 13:35:00'),
('P02','O02','Cash',180.00,'2026-01-26 14:20:00'),
('P03','O03','Card',240.00,'2026-01-26 19:50:00');

SELECT * FROM payment;

SELECT *FROM menu_item WHERE available = 1;
SELECT item_name, price FROM menu_item;

SELECT m.item_name, m.price
FROM menu_item m
JOIN category c
ON m.category_id = c.category_id
WHERE c.category_name = 'Main Course';

SELECT item_name, price
FROM menu_item
WHERE price = (SELECT MAX(price) FROM menu_item);

SELECT item_name, price
FROM menu_item
WHERE price > (SELECT AVG(price) FROM menu_item);

SELECT item_name, price
FROM menu_item
WHERE category_id = (
    SELECT category_id
    FROM category
    WHERE category_name = 'Main Course'
);

SELECT m.item_name, c.category_name, m.price
FROM menu_item m
INNER JOIN category c
ON m.category_id = c.category_id;

SELECT o.order_id, m.item_name, od.quantity
FROM orders o
INNER JOIN order_details od
ON o.order_id = od.order_id
INNER JOIN menu_item m
ON od.item_id = m.item_id;

SELECT cu.customer_name, o.order_id, o.order_date
FROM customer cu
INNER JOIN orders o
ON cu.customer_id = o.customer_id;


SELECT cu.customer_name, p.payment_method, p.amount
FROM customer cu
INNER JOIN orders o
ON cu.customer_id = o.customer_id
INNER JOIN payment p
ON o.order_id = p.order_id;

SELECT m.item_name, c.category_name, m.price
FROM menu_item m
INNER JOIN category c
ON m.category_id = c.category_id;


