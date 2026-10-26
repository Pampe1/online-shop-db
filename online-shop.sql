--Client Side

create table country (
   country VARCHAR(50) unique not null,
   country_id SERIAL primary key
);

create table city (
   city VARCHAR(50) not null,
   city_id INT primary key,
   country_id INT references country(country_id)
);

create table address (
   street VARCHAR(50) not null,
   address_id SERIAL primary key,z
   city_id INT references city(city_id)
);

create table customers (
   customer_id SERIAL primary key,
   customer_email VARCHAR(50) unique,
   first_name VARCHAR(50) not null,
   last_name VARCHAR(50) not null,
   address INT references address(address_id)
);


--Product Side

create table category (
   category_name VARCHAR(50) not null unique,
   category_id SERIAL primary key
);



create table products (
   category_id INT references category(category_id),
   product_title VARCHAR(50) not null,
   product_id SERIAL primary key,
   price numeric check (price > 0)
);


create table warehouse (
   product_id INT references products(product_id),
   quantity INT check (quantity > 0)
);


-- Order Side

create type order_status_enum as enum ('new', 'paid', 'shipped', 'cancelled');

create table orders (
customer_id INT references customers(customer_id),
order_id SERIAL primary key,
status order_status_enum not null, 
order_date date
);

create table order_items (
   order_id INT references orders(order_id),
   product_id INT references products(product_id),
   product_quantity INT check (product_quantity > 0),
   price_at_moment numeric check (price_at_moment > 0)
);


--Index

create index i_city_country_id on city(country_id);
create index i_address_city_id on address(city_id);
create index i_customers_address on customers(address);
create index i_products_category_id on products(category_id);
create index i_warehouse_product_id on warehouse(product_id);
create index i_orders_customer_id on orders(customer_id);
create index i_order_items_order_id on order_items(order_id);
create index i_order_items_product_id on order_items(product_id);











