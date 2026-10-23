-- 00_schema.sql
-- Olist e-commerce dataset: raw tables, loaded as-is.
-- Column names match the CSV headers exactly (including Olist's own typo "lenght"),
-- so the import maps cleanly. Primary/foreign keys are added on Day 4, after the data is in.

DROP TABLE IF EXISTS product_category_name_translation;
DROP TABLE IF EXISTS order_reviews;
DROP TABLE IF EXISTS order_payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS sellers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS geolocation;

CREATE TABLE customers (
    customer_id               TEXT,   -- one per ORDER, not per person
    customer_unique_id        TEXT,   -- the real person
    customer_zip_code_prefix  TEXT,   -- TEXT on purpose: keeps leading zeros
    customer_city             TEXT,
    customer_state            TEXT
);

CREATE TABLE sellers (
    seller_id                 TEXT,
    seller_zip_code_prefix    TEXT,
    seller_city               TEXT,
    seller_state              TEXT
);

CREATE TABLE products (
    product_id                      TEXT,
    product_category_name           TEXT,
    product_name_lenght             INTEGER,
    product_description_lenght      INTEGER,
    product_photos_qty              INTEGER,
    product_weight_g                INTEGER,
    product_length_cm               INTEGER,
    product_height_cm               INTEGER,
    product_width_cm                INTEGER
);

CREATE TABLE orders (
    order_id                        TEXT,
    customer_id                     TEXT,
    order_status                    TEXT,
    order_purchase_timestamp        TIMESTAMP,
    order_approved_at               TIMESTAMP,
    order_delivered_carrier_date    TIMESTAMP,
    order_delivered_customer_date   TIMESTAMP,
    order_estimated_delivery_date   TIMESTAMP
);

CREATE TABLE order_items (
    order_id             TEXT,
    order_item_id        INTEGER,   -- item number inside the order (1, 2, 3...)
    product_id           TEXT,
    seller_id            TEXT,
    shipping_limit_date  TIMESTAMP,
    price                NUMERIC(10,2),
    freight_value        NUMERIC(10,2)
);

CREATE TABLE order_payments (
    order_id               TEXT,
    payment_sequential     INTEGER,
    payment_type           TEXT,
    payment_installments   INTEGER,
    payment_value          NUMERIC(10,2)
);

CREATE TABLE order_reviews (
    review_id                 TEXT,   -- NOT unique in the raw data
    order_id                  TEXT,
    review_score              INTEGER,
    review_comment_title      TEXT,
    review_comment_message    TEXT,
    review_creation_date      TIMESTAMP,
    review_answer_timestamp   TIMESTAMP
);

CREATE TABLE geolocation (
    geolocation_zip_code_prefix  TEXT,
    geolocation_lat              DOUBLE PRECISION,
    geolocation_lng              DOUBLE PRECISION,
    geolocation_city             TEXT,
    geolocation_state            TEXT
);

CREATE TABLE product_category_name_translation (
    product_category_name          TEXT,
    product_category_name_english  TEXT
);
