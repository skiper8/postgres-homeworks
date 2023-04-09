"""Скрипт для заполнения данными таблиц в БД Postgres."""

import psycopg2
import csv

with psycopg2.connect(host="localhost",
                      database="north",
                      user="postgres",
                      password="456852") as conn:
    with conn.cursor() as cur:
        with open('north_data/customers_data.csv', 'r', encoding='UTF-8') as file:
            reader = csv.DictReader(file)
            for row in reader:
                cur.executemany("INSERT INTO customers VALUES (%s, %s, %s)",
                                [(row['customer_id'], row['company_name'], row['contact_name'])])

    with conn.cursor() as cur:
        with open('north_data/orders_data.csv', 'r', encoding='UTF-8') as file:
            reader = csv.DictReader(file)
            for row in reader:
                cur.executemany("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)",
                                [(row['order_id'], row['customer_id'], row['employee_id'], row['order_date'],
                                  row['ship_city'])])

    with conn.cursor() as cur:
        with open('north_data/employees_data.csv', 'r', encoding='UTF-8') as file:
            reader = csv.DictReader(file)
            for row in reader:
                cur.executemany("INSERT INTO employees VALUES (%s, %s, %s, %s, %s)",
                                [(row['first_name'], row['last_name'], row['title'], row['birth_date'],
                                  row['notes'])])

conn.close()
