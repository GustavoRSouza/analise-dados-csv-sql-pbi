create schema if not exists raw;

-- TODOS OS DADOS SERÃO CARREGADOS COMO text PARA GARANTIR A CARGA COMPLETA
create table if not exists raw.customers (
	customer_id text
	,customer_unique_id text
	,customer_zip_code_prefix text
	,customer_city text
	,customer_state text
);

create table if not exists raw.geolocation (
	geolocation_zip_code_prefix text
	,geolocation_lat text
	,geolocation_lng text
	,geolocation_city text
	,geolocation_state text
); 

create table if not exists raw.order_items (
	order_id text
	,order_item_id text
	,product_id text
	,seller_id text
	,shipping_limit_date text
	,price text
	,freight_value text
); 

create table if not exists raw.order_payments (
	order_id text
	,payment_sequential text
	,payment_type text
	,payment_installments text
	,payment_value text
); 

create table if not exists raw.order_reviews (
	review_id text
	,order_id text
	,review_score text
	,review_comment_title text
	,review_comment_message text
	,review_creation_date text
	,review_answer_timestamp text
); 

create table if not exists raw.orders (
	order_id text
	,customer_id text
	,order_status text
	,order_purchase_timestamp text
	,order_approved_at text
	,order_delivered_carrier_date text
	,order_delivered_customer_date text
	,order_estimated_delivery_date text
); 

create table if not exists raw.products (
	product_id text
	,product_category_name text
	,product_name_lenght text
	,product_description_lenght text
	,product_photos_qty text
	,product_weight_g text
	,product_length_cm text
	,product_height_cm text
	,product_width_cm text
); 

create table if not exists raw.sellers (
	seller_id text
	,seller_zip_code_prefix text
	,seller_city text
	,seller_state text
); 

create table if not exists raw.product_category_name (
	product_category_name text
	,product_category_name_english text
); 


-- STAGING
create schema if not exists staging;

create table if not exists staging.stg_customers (
	customer_id text
	,customer_unique_id text
	,customer_zip_code_prefix bigint
	,customer_city text
	,customer_state text
);

create table if not exists staging.stg_geolocation (
	geolocation_zip_code_prefix bigint
	,geolocation_lat double precision
	,geolocation_lng double precision
	,geolocation_city text
	,geolocation_state text
); 

create table if not exists staging.stg_order_items (
	order_id text
	,order_item_id bigint
	,product_id text
	,seller_id text
	,shipping_limit_date timestamp
	,price double precision
	,freight_value double precision
); 

create table if not exists staging.stg_order_payments (
	order_id text
	,payment_sequential int
	,payment_type text
	,payment_installments int
	,payment_value double precision
); 

create table if not exists staging.stg_order_reviews (
	review_id text
	,order_id text
	,review_score int
	,review_comment_title text
	,review_comment_message text
	,review_creation_date timestamp
	,review_answer_timestamp timestamp
); 

create table if not exists staging.stg_orders (
	order_id text
	,customer_id text
	,order_status text
	,order_purchase_timestamp timestamp
	,order_approved_at timestamp
	,order_delivered_carrier_date timestamp
	,order_delivered_customer_date timestamp
	,order_estimated_delivery_date timestamp
); 

create table if not exists staging.stg_products (
	product_id text
	,product_category_name text
	,product_name_lenght int
	,product_description_lenght int
	,product_photos_qty int
	,product_weight_g int
	,product_length_cm int
	,product_height_cm int
	,product_width_cm int
); 
select * from raw.sellers
create table if not exists staging.stg_sellers (
	seller_id text
	,seller_zip_code_prefix bigint
	,seller_city text
	,seller_state text
); 

create table if not exists staging.stg_product_category_name (
	product_category_name text
	,product_category_name_english text
); 