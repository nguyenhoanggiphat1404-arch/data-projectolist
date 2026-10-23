-- 02_keys.sql
-- Day 4: add primary and foreign keys now that the data is loaded.
-- If any statement fails, the error tells you exactly which rows break the rule:
-- that is a data finding, write it in docs/03_assumptions.md.

-- Primary keys (only where the raw data really is unique)
ALTER TABLE customers  ADD PRIMARY KEY (customer_id);
ALTER TABLE orders     ADD PRIMARY KEY (order_id);
ALTER TABLE products   ADD PRIMARY KEY (product_id);
ALTER TABLE sellers    ADD PRIMARY KEY (seller_id);
ALTER TABLE order_items    ADD PRIMARY KEY (order_id, order_item_id);
ALTER TABLE order_payments ADD PRIMARY KEY (order_id, payment_sequential);

-- order_reviews: deliberately NO primary key.
-- review_id repeats in the raw file, and some orders have several reviews.
-- geolocation: no key either (many rows per zip prefix).

-- Foreign keys
ALTER TABLE orders         ADD FOREIGN KEY (customer_id) REFERENCES customers (customer_id);
ALTER TABLE order_items    ADD FOREIGN KEY (order_id)    REFERENCES orders (order_id);
ALTER TABLE order_items    ADD FOREIGN KEY (product_id)  REFERENCES products (product_id);
ALTER TABLE order_items    ADD FOREIGN KEY (seller_id)   REFERENCES sellers (seller_id);
ALTER TABLE order_payments ADD FOREIGN KEY (order_id)    REFERENCES orders (order_id);
ALTER TABLE order_reviews  ADD FOREIGN KEY (order_id)    REFERENCES orders (order_id);

-- Quick sanity checks for the two traps from the project notes:

-- 1) customer_id is per order, customer_unique_id is the person.
--    Expect unique people to be clearly fewer than orders.
SELECT COUNT(*)                           AS orders_rows,
       COUNT(DISTINCT customer_unique_id) AS unique_people
FROM customers;

-- 2) Orders with more than one review.
SELECT COUNT(*) AS orders_with_multiple_reviews
FROM (
    SELECT order_id
    FROM order_reviews
    GROUP BY order_id
    HAVING COUNT(*) > 1
) t;
