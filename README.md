🍴 SQL Project: Restaurant Menu Database
1️⃣ Project Title

Restaurant Menu Management System using SQL

2️⃣ Project Objective

The objective of this project is to design a relational database that efficiently manages:

Restaurant menu categories and items
Customer details
Orders and ordered items
Payment information

The database ensures data integrity, easy retrieval, and analysis of sales and revenue using SQL queries.

3️⃣ Database Design (Entities & Relationships)
Entities:
Categories → Menu classification (Starters, Main Course, Desserts)
Menu_Items → Food items with prices
Customers → Customer information
Orders → Orders placed by customers
Order_Details → Items in each order
Payments → Payment records
Relationships:
One category → many menu items
One customer → many orders
One order → many menu items
One order → one payment
4️⃣ Database Schema (SQL Code)
🔹 Create Database
CREATE DATABASE Restaurant_Menu_DB;
USE Restaurant_Menu_DB;
🔹 Categories Table
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);
🔹 Menu Items Table
CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(8,2) NOT NULL,
    availability BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
🔹 Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15)
);
🔹 Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
🔹 Order Details Table
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);
🔹 Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    amount DECIMAL(8,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
5️⃣ Sample Data (INSERT Statements)
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
6️⃣ SQL Queries
🔹 Display Full Menu with Categories
SELECT m.item_name, c.category_name, m.price
FROM menu_items m
JOIN categories c ON m.category_id = c.category_id;
🔹 Show Available Menu Items
SELECT item_name, price
FROM menu_items
WHERE availability = TRUE;
🔹 Total Revenue
SELECT SUM(amount) AS total_revenue
FROM payments;
🔹 Customer Order History
SELECT cu.customer_name, o.order_id, o.order_date
FROM customers cu
JOIN orders o ON cu.customer_id = o.customer_id;
🔹 Most Expensive Item
SELECT item_name, price
FROM menu_items
WHERE price = (SELECT MAX(price) FROM menu_items);
🔹 Category-wise Sales
SELECT c.category_name, SUM(p.amount) AS total_sales
FROM categories c
JOIN menu_items m ON c.category_id = m.category_id
JOIN order_details od ON m.item_id = od.item_id
JOIN payments p ON od.order_id = p.order_id
GROUP BY c.category_name;
7️⃣ Advanced Features (Optional)
Views for daily sales reports
Stored procedures to place orders
Triggers to update item availability
Indexes for faster searching
Discount logic for loyal customers
8️⃣ Conclusion

This Restaurant Menu Database efficiently manages restaurant operations using SQL.
It demonstrates real-world use of relational database concepts, joins, constraints, and analytical queries, making it ideal for academic submission and interviews.
