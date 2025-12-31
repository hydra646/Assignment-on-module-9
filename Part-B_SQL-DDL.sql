-- Part B: DDL 
CREATE TABLE SubscriptionPlan (
  plan_id    SERIAL PRIMARY KEY,
  name       VARCHAR(100) NOT NULL UNIQUE,
  price      DECIMAL(12,2) NOT NULL,
  duration   VARCHAR(50) NOT NULL,
  features   TEXT
);

CREATE TABLE Vendor (
  vendor_id      SERIAL PRIMARY KEY,
  business_name  VARCHAR(150) NOT NULL UNIQUE,
  contact_person VARCHAR(100) NOT NULL,
  email          VARCHAR(150) NOT NULL UNIQUE,
  phone          VARCHAR(50),
  address        VARCHAR(255),
  plan_id        INT NOT NULL,
  CONSTRAINT fk_vendor_plan FOREIGN KEY (plan_id) REFERENCES SubscriptionPlan(plan_id)
);

CREATE TABLE Category (
  category_id SERIAL PRIMARY KEY,
  name        VARCHAR(100) NOT NULL UNIQUE,
  description TEXT
);

CREATE TABLE Product (
  product_id      SERIAL PRIMARY KEY,
  name            VARCHAR(150) NOT NULL,
  description     TEXT,
  price           DECIMAL(12,2) NOT NULL,
  stock_quantity  INT NOT NULL DEFAULT 0,
  status          VARCHAR(20) NOT NULL CHECK (status IN ('active','inactive')),
  vendor_id       INT NOT NULL,
  CONSTRAINT fk_product_vendor FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
);

CREATE TABLE ProductCategory (
  product_id  INT NOT NULL,
  category_id INT NOT NULL,
  PRIMARY KEY (product_id, category_id),
  CONSTRAINT fk_pc_product  FOREIGN KEY (product_id)  REFERENCES Product(product_id),
  CONSTRAINT fk_pc_category FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Customer (
  customer_id SERIAL PRIMARY KEY,
  name        VARCHAR(120) NOT NULL,
  email       VARCHAR(150) NOT NULL UNIQUE,
  phone       VARCHAR(50),
  address     VARCHAR(255)
);

CREATE TABLE "Order" (
  order_id     SERIAL PRIMARY KEY,
  order_date   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  total_amount DECIMAL(12,2) NOT NULL,
  status       VARCHAR(30) NOT NULL,
  customer_id  INT NOT NULL,
  CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE OrderItem (
  order_item_id SERIAL PRIMARY KEY,
  quantity      INT NOT NULL,
  unit_price    DECIMAL(12,2) NOT NULL,
  subtotal      DECIMAL(12,2) NOT NULL,
  order_id      INT NOT NULL,
  product_id    INT NOT NULL,
  CONSTRAINT fk_oi_order   FOREIGN KEY (order_id)   REFERENCES "Order"(order_id),
  CONSTRAINT fk_oi_product FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Payment (
  payment_id   SERIAL PRIMARY KEY,
  method       VARCHAR(30) NOT NULL,
  amount       DECIMAL(12,2) NOT NULL,
  payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status       VARCHAR(30) NOT NULL,
  order_id     INT NOT NULL UNIQUE,
  CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES "Order"(order_id)
);
