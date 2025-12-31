Part A: 

2) Relational schema (tables, PKs, FKs)

SubscriptionPlan(plan_id PK, plan_name, price, duration, features)
Vendor(vendor_id PK, plan_id FK→SubscriptionPlan.plan_id, business_name, contact_person, email, phone, address)
Category(category_id PK, category_name, description)
Product(product_id PK, vendor_id FK→Vendor.vendor_id, product_name, description, price, stock_qty, status)
ProductCategory(product_id FK→Product.product_id, category_id FK→Category.category_id, PK(product_id, category_id))
Customer(customer_id PK, name, email, phone, address)
Order(order_id PK, customer_id FK→Customer.customer_id, order_date, total_amount, status)
OrderItem(order_item_id PK, order_id FK→Order.order_id, product_id FK→Product.product_id, quantity, unit_price, subtotal)
Payment(payment_id PK, order_id FK→Order.order_id UNIQUE, method, amount, payment_date, status)


