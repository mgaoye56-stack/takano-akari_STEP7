SELECT
    *
FROM
    users;

SELECT
 *
FROM
users
WHERE
created_at >= '2024-01-01';

SELECT
* 
FROM 
users
WHERE 
age < 30 AND gender = 'female';

SELECT
    product_name, price
FROM
    products;

SELECT
users.name, orders.order_date
FROM
users
JOIN
orders
ON
users.id = orders.user_id;

SELECT
products.product_name,
products.price, 
order_items.quantity,
(products.price * order_items.quantity) AS '金額'
FROM
order_items
JOIN
products
ON
products.id = order_items.product_id;

SELECT
users.name, 
COUNT(orders.id) AS '注文件数'
FROM
users
JOIN
orders
ON
users.id = orders.user_id
GROUP BY
users.id, users.name;

SELECT 
users.name, 
SUM(products.price * order_items.quantity) AS '総購入金額'
FROM 
users
JOIN
orders
ON
users.id = orders.user_id
JOIN
order_items
ON
orders.id = order_items.order_id
JOIN
products
ON
products.id = order_items.product_id
GROUP BY
users.id, users.name;

SELECT
users.name, 
SUM(products.price * order_items.quantity) AS '注文金額'
FROM 
users
JOIN
orders
ON
users.id = orders.user_id
JOIN
order_items
ON
orders.id = order_items.order_id
JOIN
products
ON
products.id = order_items.product_id
GROUP BY
orders.id, users.id, users.name
ORDER BY
SUM(products.price * order_items.quantity) DESC
LIMIT 1;

SELECT 
products.product_name,
SUM(order_items.quantity) AS '合計注文数量'
FROM
products
JOIN
order_items
ON
products.id = order_items.product_id
GROUP BY
products.id, products.product_name;

SELECT
users.name
FROM 
users 
LEFT JOIN
orders
ON
users.id = orders.user_id
WHERE
orders.user_id IS NULL;

SELECT
order_items.order_id
FROM 
order_items
GROUP BY
order_items.order_id
HAVING
COUNT(DISTINCT order_items.product_id) >= 2;

SELECT DISTINCT
users.name
FROM
users
JOIN
orders
ON
users.id = orders.user_id
JOIN
order_items
ON
orders.id = order_items.order_id
JOIN
products
ON
order_items.product_id = products.id
WHERE
products.product_name = 'テレビ';

SELECT
    orders.order_date,
    users.name,
    products.product_name,
    order_items.quantity,
    products.price * order_items.quantity AS '合計金額'
FROM users
JOIN orders
ON users.id = orders.user_id
JOIN order_items
ON orders.id = order_items.order_id
JOIN products
ON order_items.product_id = products.id;

SELECT
SUM(order_items.quantity) AS '合計注文数量',
products.product_name
FROM 
order_items
JOIN 
products
ON
order_items.product_id = products.id
GROUP BY
products.id,
products.product_name
ORDER BY
SUM(order_items.quantity) DESC
LIMIT
1;

SELECT
DATE_FORMAT (orders.order_date, '%Y-%m') AS '注文月',
COUNT(orders.id) AS '注文件数'
FROM 
orders
GROUP BY
DATE_FORMAT(orders.order_date, '%Y-%m')
ORDER BY
注文月;

SELECT
products.product_name
FROM 
products
LEFT JOIN
order_items
ON
products.id = order_items.product_id
WHERE
order_items.product_id IS NULL;

CREATE INDEX idx_order_items_product_id ON order_items (product_id);

SELECT 
users.name,
AVG(order_totals.order_amount) AS '平均注文金額'
FROM
users
JOIN(
 SELECT
  orders.id AS order_id,
  orders.user_id,
  SUM(products.price * order_items.quantity) AS order_amount
 FROM 
  orders
JOIN
order_items
ON
orders.id = order_items.order_id
JOIN
products
ON
order_items.product_id = products.id
GROUP BY
orders.id,
orders.user_id
 ) AS order_totals
  ON users.id = order_totals.user_id
GROUP BY
 users.id,
 users.name;

SELECT
users.name,
MAX(orders.order_date) AS '最新注文日'
FROM
orders
JOIN
users
ON
orders.user_id = users.id
GROUP BY
users.id,
users.name;

INSERT INTO
users (id, name, age, gender, created_at)
VALUES
(6,'中村愛', 25, 'female', '2025-06-01');

INSERT INTO
products (id, product_name, price)
VALUES
(6, 'エアコン', 60000);

INSERT INTO
orders (id, user_id, order_date)
VALUES
(10, 1, '2025-06-10'); 

INSERT INTO
order_items (id, order_id, product_id, quantity)
VALUES
(10, 10, 6, 1);

UPDATE
users
SET
age = 24
WHERE
id = 4;

UPDATE
products
SET
price = price * 1.1;

UPDATE
orders
SET
order_date = '2024-05-01'
WHERE
order_date <= '2024-05-01';

DELETE FROM
users
WHERE
id = 5;

DELETE FROM
order_items
WHERE
order_id = 5;

DELETE 
products
FROM
products
LEFT JOIN
order_items
ON
products.id = order_items.product_id
WHERE
order_items.product_id IS NULL;

