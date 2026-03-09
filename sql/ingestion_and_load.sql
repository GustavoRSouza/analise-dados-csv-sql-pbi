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
