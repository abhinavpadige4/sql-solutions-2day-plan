-- ============================================================================
-- 00_schema_and_data.sql
-- Sample e-commerce dataset for the 2-day SQL study plan.
-- ANSI SQL compatible (PostgreSQL, MySQL 8+, SQLite).
-- ============================================================================

-- Clean slate
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- ---------------------------------------------------------------------------
-- Schema
-- ---------------------------------------------------------------------------

CREATE TABLE customers (
    customer_id   INTEGER PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    country       VARCHAR(50)  NOT NULL,
    signup_date   DATE         NOT NULL
);

CREATE TABLE products (
    product_id    INTEGER PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    category      VARCHAR(50)  NOT NULL,
    price         NUMERIC(10,2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE orders (
    order_id      INTEGER PRIMARY KEY,
    customer_id   INTEGER NOT NULL REFERENCES customers(customer_id),
    order_date    DATE    NOT NULL
);

CREATE TABLE order_items (
    item_id       INTEGER PRIMARY KEY,
    order_id      INTEGER NOT NULL REFERENCES orders(order_id),
    product_id    INTEGER NOT NULL REFERENCES products(product_id),
    quantity      INTEGER NOT NULL CHECK (quantity > 0),
    unit_price    NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
);

-- ---------------------------------------------------------------------------
-- Data
-- ---------------------------------------------------------------------------

INSERT INTO customers (customer_id, name, country, signup_date) VALUES
    (1,  'Alice Johnson',   'USA',      '2022-01-15'),
    (2,  'Bob Smith',       'USA',      '2022-03-22'),
    (3,  'Carla Mendes',    'Brazil',   '2022-05-10'),
    (4,  'Diego Ramirez',   'Mexico',   '2022-06-01'),
    (5,  'Emma Wilson',     'USA',      '2022-07-14'),
    (6,  'Farid Hassan',    'Egypt',    '2022-08-30'),
    (7,  'Grace Lee',       'South Korea','2022-09-12'),
    (8,  'Hiroshi Tanaka',  'Japan',    '2022-10-05'),
    (9,  'Isla O''Brien',   'Ireland',  '2022-11-20'),
    (10, 'Jamal Carter',    'USA',      '2023-01-08');

INSERT INTO products (product_id, name, category, price) VALUES
    (1,  'Laptop Pro 14',     'Electronics', 1299.00),
    (2,  'Wireless Mouse',    'Electronics',   29.99),
    (3,  'Mechanical Keyboard','Electronics',  89.50),
    (4,  'Running Shoes',     'Apparel',      119.00),
    (5,  'Cotton T-Shirt',    'Apparel',       24.99),
    (6,  'Coffee Maker',      'Home',         149.00),
    (7,  'Desk Lamp',         'Home',          39.99),
    (8,  'Yoga Mat',          'Sports',        29.00);

INSERT INTO orders (order_id, customer_id, order_date) VALUES
    (101, 1,  '2023-01-10'),
    (102, 2,  '2023-02-15'),
    (103, 3,  '2023-03-22'),
    (104, 1,  '2023-04-05'),
    (105, 4,  '2023-05-18'),
    (106, 5,  '2023-06-30'),
    (107, 6,  '2023-07-12'),
    (108, 7,  '2023-08-25'),
    (109, 8,  '2023-09-14'),
    (110, 9,  '2023-10-08'),
    (111, 1,  '2023-11-20'),
    (112, 2,  '2023-12-05'),
    (113, 3,  '2023-12-28'),
    (114, 10, '2024-01-15'),
    (115, 1,  '2024-02-10'),
    (116, 5,  '2024-03-22'),
    (117, 7,  '2024-04-08'),
    (118, 8,  '2024-05-19'),
    (119, 10, '2024-06-30'),
    (120, 4,  '2024-07-14');

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price) VALUES
    (1,  101, 1, 1, 1299.00),
    (2,  101, 2, 2,   29.99),
    (3,  102, 3, 1,   89.50),
    (4,  103, 4, 1,  119.00),
    (5,  104, 1, 1, 1299.00),
    (6,  104, 5, 3,   24.99),
    (7,  105, 6, 1,  149.00),
    (8,  106, 7, 2,   39.99),
    (9,  107, 8, 1,   29.00),
    (10, 108, 1, 1, 1299.00),
    (11, 108, 2, 1,   29.99),
    (12, 109, 3, 2,   89.50),
    (13, 110, 4, 2,  119.00),
    (14, 111, 5, 4,   24.99),
    (15, 112, 6, 1,  149.00),
    (16, 113, 7, 1,   39.99),
    (17, 114, 1, 1, 1299.00),
    (18, 114, 8, 2,   29.00),
    (19, 115, 2, 3,   29.99),
    (20, 116, 3, 1,   89.50),
    (21, 117, 4, 1,  119.00),
    (22, 118, 5, 2,   24.99),
    (23, 119, 6, 1,  149.00),
    (24, 120, 7, 1,   39.99),
    (25, 120, 8, 1,   29.00),
    (26, 102, 2, 1,   29.99),
    (27, 105, 3, 1,   89.50),
    (28, 106, 1, 1, 1299.00),
    (29, 110, 2, 2,   29.99),
    (30, 111, 1, 1, 1299.00),
    (31, 113, 4, 1,  119.00),
    (32, 115, 5, 2,   24.99),
    (33, 116, 6, 1,  149.00),
    (34, 117, 7, 1,   39.99),
    (35, 119, 8, 1,   29.00);

-- ---------------------------------------------------------------------------
-- Sanity checks (optional — run to confirm the dataset loaded correctly)
-- ---------------------------------------------------------------------------

SELECT 'customers' AS tbl, COUNT(*) AS n FROM customers
UNION ALL SELECT 'products',    COUNT(*) FROM products
UNION ALL SELECT 'orders',      COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items;
