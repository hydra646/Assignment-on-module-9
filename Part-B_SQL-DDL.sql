-- 3.SQL for Vendor (with PK and FK to SubscriptionPlan):;

CREATE TABLE Vendor (
  vendor_id      SERIAL PRIMARY KEY,
  business_name  VARCHAR(150) NOT NULL UNIQUE,
  contact_person VARCHAR(100) NOT NULL,
  email          VARCHAR(150) NOT NULL UNIQUE,
  phone          VARCHAR(50),
  address        VARCHAR(255),
  plan_id        INT NOT NULL,
  CONSTRAINT fk_vendor_plan FOREIGN KEY (plan_id)
    REFERENCES SubscriptionPlan(plan_id)
);

-- 4.SQL for ProductCategory (bridge for M:N Product ↔ Category):
CREATE TABLE ProductCategory (
  product_id  INT NOT NULL,
  category_id INT NOT NULL,
  PRIMARY KEY (product_id, category_id),
  CONSTRAINT fk_pc_product  FOREIGN KEY (product_id)  REFERENCES Product(product_id),
  CONSTRAINT fk_pc_category FOREIGN KEY (category_id) REFERENCES Category(category_id)
);
