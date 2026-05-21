# 🍽️ Restaurant Menu Management System using SQL

A SQL-based Restaurant Menu Management System designed to efficiently manage restaurant operations including menu categories, menu items, customers, orders, and payment records.

This project demonstrates practical usage of relational database concepts such as table relationships, joins, constraints, subqueries, and analytical SQL queries.

---

## 📌 Project Objective

The goal of this project is to create a structured database system that helps manage:

- Restaurant menu categories and food items
- Customer details
- Order management
- Ordered item tracking
- Payment information
- Revenue and sales analysis

This system ensures:

✔ Data integrity  
✔ Efficient data retrieval  
✔ Easy reporting and analytics  
✔ Real-world database design practice

---

## 🏗 Database Design

### Entities

1. **Categories**
   - Stores food categories
   - Examples: Starters, Main Course, Desserts

2. **Menu_Items**
   - Stores restaurant menu details

3. **Customers**
   - Stores customer information

4. **Orders**
   - Stores order records

5. **Order_Details**
   - Stores items included in each order

6. **Payments**
   - Stores payment information

---

## 🔗 Entity Relationships

- One Category → Many Menu Items
- One Customer → Many Orders
- One Order → Many Menu Items
- One Order → One Payment

---

## 🗄 Database Schema

### Create Database

```sql
CREATE DATABASE Restaurant_Menu_DB;
USE Restaurant_Menu_DB;
```

### Categories Table

```sql
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);
```

### Menu Items Table

```sql
CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(8,2),
    availability BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
);
```

### Customers Table

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    phone VARCHAR(15)
);
```

### Orders Table

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);
```

### Order Details Table

```sql
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    FOREIGN KEY(order_id)
    REFERENCES orders(order_id),
    FOREIGN KEY(item_id)
    REFERENCES menu_items(item_id)
);
```

### Payments Table

```sql
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    amount DECIMAL(8,2),
    FOREIGN KEY(order_id)
    REFERENCES orders(order_id)
);
```

---

## 📥 Sample Data

### Categories

```sql
INSERT INTO categories VALUES
(1,'Starters'),
(2,'Main Course'),
(3,'Desserts');
```

### Menu Items

```sql
INSERT INTO menu_items VALUES
(101,'Paneer Tikka',1,220.00,TRUE),
(102,'Veg Biryani',2,180.00,TRUE),
(103,'Gulab Jamun',3,90.00,TRUE);
```

### Customers

```sql
INSERT INTO customers VALUES
(1,'Amit Sharma','9876543210'),
(2,'Neha Verma','9123456780');
```

### Orders

```sql
INSERT INTO orders VALUES
(1001,1,'2026-01-25'),
(1002,2,'2026-01-26');
```

### Order Details

```sql
INSERT INTO order_details VALUES
(1,1001,101,2),
(2,1001,103,1),
(3,1002,102,1);
```

### Payments

```sql
INSERT INTO payments VALUES
(1,1001,'UPI',530.00),
(2,1002,'Cash',180.00);
```

---

# 🔍 SQL Queries

## Display Full Menu with Categories

```sql
SELECT m.item_name,c.category_name,m.price
FROM menu_items m
JOIN categories c
ON m.category_id=c.category_id;
```

---

## Show Available Menu Items

```sql
SELECT item_name,price
FROM menu_items
WHERE availability=TRUE;
```

---

## Calculate Total Revenue

```sql
SELECT SUM(amount) AS total_revenue
FROM payments;
```

---

## Customer Order History

```sql
SELECT cu.customer_name,
       o.order_id,
       o.order_date
FROM customers cu
JOIN orders o
ON cu.customer_id=o.customer_id;
```

---

## Most Expensive Menu Item

```sql
SELECT item_name,price
FROM menu_items
WHERE price=
(
SELECT MAX(price)
FROM menu_items
);
```

---

## Category-wise Sales

```sql
SELECT c.category_name,
SUM(p.amount) AS total_sales
FROM categories c
JOIN menu_items m
ON c.category_id=m.category_id
JOIN order_details od
ON m.item_id=od.item_id
JOIN payments p
ON od.order_id=p.order_id
GROUP BY c.category_name;
```

---

# 🚀 Advanced Features

Future enhancements:

- Create Views for sales reports
- Stored Procedures for placing orders
- Triggers for updating item availability
- Indexes for performance optimization
- Discount system for loyal customers
- Dashboard integration with Power BI/Tableau

---

## 🛠 Technologies Used

- SQL
- MySQL
- Relational Database Concepts

---

## 📊 Concepts Covered

- Database Design
- Primary Keys
- Foreign Keys
- Joins
- Aggregate Functions
- Subqueries
- Constraints
- Data Analysis Queries

---

## 🎯 Conclusion

This Restaurant Menu Database project demonstrates real-world SQL implementation and restaurant data management practices.

The project helps understand:

- Relational database design
- SQL query writing
- Data analysis
- Business-oriented database systems

This project is suitable for:

✔ Academic projects  
✔ SQL practice  
✔ Portfolio projects  
✔ Interview preparation

---

## 👨‍💻 Author

**Nishikant Ghute**

GitHub: https://github.com/nishikantsghute/Restaurant-Menu-Database-SQL-Project/edit/main/README.md
