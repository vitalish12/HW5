-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
alter table products add constraint chk_products_unit_price check (unit_price > 0)

select unit_price
from products

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
alter table products add constraint chk_products_discontinued check (discontinued in (0, 1))

select discontinued
from products

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
select * into new_products from products where discontinued = 1

select discontinued
from new_products

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key.
-- Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
ALTER TABLE order_details DROP CONSTRAINT fk_order_details_products;
DELETE FROM products WHERE discontinued = 1

DELETE FROM order_details WHERE product_id NOT IN (SELECT product_id FROM products);
DELETE FROM orders WHERE order_id NOT IN (SELECT order_id FROM order_details);
ALTER TABLE order_details ADD CONSTRAINT fk_order_details_products FOREIGN KEY(product_id) REFERENCES products(product_id);