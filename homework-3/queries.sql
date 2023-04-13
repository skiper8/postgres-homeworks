-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT customers.company_name, CONCAT(first_name, ' ', last_name) AS employee_name FROM customers
JOIN orders USING(customer_id)
JOIN employees USING(employee_id)
JOIN shippers ON orders.ship_via=shippers.shipper_id
WHERE customers.city='London' AND employees.city='London' AND shippers.company_name='United Package';

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT product_name, units_in_stock, suppliers.contact_name, suppliers.phone FROM products
INNER JOIN suppliers USING(supplier_id)
INNER JOIN categories USING(category_id)
WHERE categories.category_name IN ('Condiments', 'Dairy Products')
AND products.units_in_stock<25
AND products.discontinued=0
ORDER BY products.units_in_stock DESC;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name FROM customers
WHERE customers.customer_id NOT IN(SELECT customer_id FROM orders);

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT product_name FROM products
INNER JOIN order_details USING(product_id)
WHERE product_id IN (SELECT product_id FROM order_details) AND order_details.quantity = 10;