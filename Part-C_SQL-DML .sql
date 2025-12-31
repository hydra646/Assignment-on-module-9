-- Part C: DML

-- 5) Insert vendor under Basic plan
INSERT INTO Vendor (plan_id, business_name, contact_person, email, phone, address)
SELECT sp.plan_id, 'SmartTech Ltd.', 'Rahim Khan', 'rahim@smarttech.com', '017XXXXXXXX', 'Dhaka, Bangladesh'
FROM SubscriptionPlan sp
WHERE sp.name = 'Basic';

-- 6) Insert product Laptop under Electronics for SmartTech Ltd.
WITH v AS (
  SELECT vendor_id FROM Vendor WHERE business_name = 'SmartTech Ltd.'
), c AS (
  SELECT category_id FROM Category WHERE name = 'Electronics'
), ins_prod AS (
  INSERT INTO Product (vendor_id, name, description, price, stock_quantity, status)
  SELECT v.vendor_id, 'Laptop', 'Laptop', 75000, 10, 'active' FROM v
  RETURNING product_id
)
INSERT INTO ProductCategory (product_id, category_id)
SELECT p.product_id, c.category_id FROM ins_prod p CROSS JOIN c;

-- 7) Update stock of Laptop to 15
UPDATE Product
SET stock_quantity = 15
WHERE name = 'Laptop';

-- 8) Delete customer by email
DELETE FROM Customer
WHERE email = 'oldcustomer@gmail.com';
