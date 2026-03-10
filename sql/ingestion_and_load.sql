-- INGESTÃO RAW (comandos devem ser inseridos linha a linha no psql)
truncate raw.customers,raw.geolocation,raw.order_items,raw.order_payments,raw.order_reviews,raw.orders,raw.products,raw.sellers,raw.product_category_name;
\copy raw.customers from 'C:\Users\gusta\projects\analise-dados-csv-sql-pbi\dataset\olist_customers_dataset.csv' with (format csv, header true, null '', encoding 'UTF8');
\copy raw.geolocation from 'C:\Users\gusta\projects\analise-dados-csv-sql-pbi\dataset\olist_geolocation_dataset.csv' with (format csv, header true, null '', encoding 'UTF8');
\copy raw.order_items from 'C:\Users\gusta\projects\analise-dados-csv-sql-pbi\dataset\olist_order_items_dataset.csv' with (format csv, header true, null '', encoding 'UTF8');
\copy raw.order_payments from 'C:\Users\gusta\projects\analise-dados-csv-sql-pbi\dataset\olist_order_payments_dataset.csv' with (format csv, header true, null '', encoding 'UTF8');
\copy raw.order_reviews from 'C:\Users\gusta\projects\analise-dados-csv-sql-pbi\dataset\olist_order_reviews_dataset.csv' with (format csv, header true, null '', encoding 'UTF8');
\copy raw.orders from 'C:\Users\gusta\projects\analise-dados-csv-sql-pbi\dataset\olist_orders_dataset.csv' with (format csv, header true, null '', encoding 'UTF8');
\copy raw.products from 'C:\Users\gusta\projects\analise-dados-csv-sql-pbi\dataset\olist_products_dataset.csv' with (format csv, header true, null '', encoding 'UTF8');
\copy raw.sellers from 'C:\Users\gusta\projects\analise-dados-csv-sql-pbi\dataset\olist_sellers_dataset.csv' with (format csv, header true, null '', encoding 'UTF8');
\copy raw.product_category_name from 'C:\Users\gusta\projects\analise-dados-csv-sql-pbi\dataset\product_category_name_translation.csv' with (format csv, header true, null '', encoding 'UTF8');


-- LOAD STAGING
insert into staging.stg_customers (
	customer_id
	,customer_unique_id
	,customer_zip_code_prefix
	,customer_city
	,customer_state
)
select
	nullif(trim(customer_id),'')
	,nullif(trim(customer_unique_id),'')
	,nullif(trim(customer_zip_code_prefix),'')::bigint
	,nullif(trim(customer_city),'')
	,nullif(trim(customer_state),'')
from
	raw.customers;

insert into staging.stg_geolocation (
	geolocation_zip_code_prefix
	,geolocation_lat
	,geolocation_lng
	,geolocation_city
	,geolocation_state
)
select
	nullif(trim(geolocation_zip_code_prefix),'')::bigint
	,nullif(trim(geolocation_lat),'')::double precision
	,nullif(trim(geolocation_lng),'')::double precision
	,nullif(trim(geolocation_city),'')
	,nullif(trim(geolocation_state),'')
from
	raw.geolocation;

insert into staging.stg_order_items (
	order_id
	,order_item_id
	,product_id
	,seller_id
	,shipping_limit_date
	,price
	,freight_value
)
select
	nullif(trim(order_id),'')
	,nullif(trim(order_item_id),'')::bigint
	,nullif(trim(product_id),'')
	,nullif(trim(seller_id),'')
	,nullif(trim(shipping_limit_date),'')::timestamp
	,nullif(trim(price),'')::double precision
	,nullif(trim(freight_value),'')::double precision
from
	raw.order_items;

insert into staging.stg_order_payments (
	order_id
	,payment_sequential
	,payment_type
	,payment_installments
	,payment_value
)
select
	nullif(trim(order_id),'')
	,nullif(trim(payment_sequential),'')::int
	,nullif(trim(payment_type),'')
	,nullif(trim(payment_installments),'')::int
	,nullif(trim(payment_value),'')::double precision
from
	raw.order_payments; 

insert into staging.stg_order_reviews (
	review_id
	,order_id
	,review_score
	,review_comment_title
	,review_comment_message
	,review_creation_date
	,review_answer_timestamp
)
select
	nullif(trim(review_id),'')
	,nullif(trim(order_id),'')
	,nullif(trim(review_score),'')::int
	,nullif(trim(review_comment_title),'')
	,nullif(trim(review_comment_message),'')
	,nullif(trim(review_creation_date),'')::timestamp
	,nullif(trim(review_answer_timestamp),'')::timestamp
from
	raw.order_reviews; 
	
insert into staging.stg_orders (
	order_id
	,customer_id
	,order_status
	,order_purchase_timestamp
	,order_approved_at
	,order_delivered_carrier_date
	,order_delivered_customer_date
	,order_estimated_delivery_date
)
select
	nullif(trim(order_id),'')
	,nullif(trim(customer_id),'')
	,nullif(trim(order_status),'')
	,nullif(trim(order_purchase_timestamp),'')::timestamp
	,nullif(trim(order_approved_at),'')::timestamp
	,nullif(trim(order_delivered_carrier_date),'')::timestamp
	,nullif(trim(order_delivered_customer_date),'')::timestamp
	,nullif(trim(order_estimated_delivery_date),'')::timestamp
from
	raw.orders; 
	
insert into staging.stg_products (
	product_id
	,product_category_name
	,product_name_lenght
	,product_description_lenght
	,product_photos_qty
	,product_weight_g
	,product_length_cm
	,product_height_cm
	,product_width_cm
)
select
	nullif(trim(product_id),'')
	,nullif(trim(product_category_name),'')
	,nullif(trim(product_name_lenght),'')::int
	,nullif(trim(product_description_lenght),'')::int
	,nullif(trim(product_photos_qty),'')::int
	,nullif(trim(product_weight_g),'')::int
	,nullif(trim(product_length_cm),'')::int
	,nullif(trim(product_height_cm),'')::int
	,nullif(trim(product_width_cm),'')::int
from
	raw.products;  

insert into staging.stg_sellers (
	seller_id
	,seller_zip_code_prefix
	,seller_city
	,seller_state
)
select
	nullif(trim(seller_id),'')
	,nullif(trim(seller_zip_code_prefix),'')::bigint
	,nullif(trim(seller_city),'')
	,nullif(trim(seller_state),'')
from
	raw.sellers;  

insert into staging.stg_product_category_name (
	product_category_name
	,product_category_name_english
)
select
	nullif(trim(product_category_name),'')
	,nullif(trim(product_category_name_english),'')
from
	raw.product_category_name;  