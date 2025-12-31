-- Part D: DQL

-- 9) Vendors with plan name and price
SELECT v.vendor_id, v.business_name, sp.name AS plan_name, sp.price
FROM Vendor v
JOIN SubscriptionPlan sp ON v.plan_id = sp.plan_id
ORDER BY v.vendor_id;

-- 10) Products under Electronics
SELECT p.name AS product_name, p.price, p.stock_quantity
FROM Product p
JOIN ProductCategory pc ON p.product_id = pc.product_id
JOIN Category c ON pc.category_id = c.category_id
WHERE c.name = 'Electronics';

-- 11) Orders by Karim Uddin
SELECT o.order_id, o.order_date, o.total_amount, o.status
FROM "Order" o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE c.name = 'Karim Uddin'
ORDER BY o.order_date DESC;

-- 12) Payment details for order_id = 1
SELECT method, amount, status
FROM Payment
WHERE order_id = 1;

-- 13) Top 5 best-selling products by quantity sold
SELECT p.product_id, p.name AS product_name, SUM(oi.quantity) AS total_qty_sold
FROM OrderItem oi
JOIN Product p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY total_qty_sold DESC
LIMIT 5;
