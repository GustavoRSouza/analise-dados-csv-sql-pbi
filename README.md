# Onde tudo começou

Esse projeto representa minha primeira experiência como BI Analyst em 2021. Quando antes do projeto ter sido realizado, a análise dos dados da empresa cuja qual fui contratado, era feita por meio de CTRL+C & CTRL+V do ERP direto em uma planilha de Excel.

> Antes da execução desse projeto, os relatórios diários demoravam cerca de 4 horas até ficarem prontos. E posteriormente consegui melhorar o tempo das analises para no máximo 30 minutos, quando a maior parte do tempo era apenas validando os dados para garantir a precição dos numeros nos paineis do dashboard.

> O dataset presente nesse projeto não representa exatamente a estrutura de dados do projeto real. Pois, o intuito real desse projeto é mostrar apenas as tecnologias e os processos utilizados para otimizar as analises e transformar a cultura da empresa em data driven.

A fonte de dados desse projeto é o 'Brazilian E-Commerce Public Dataset by Olist' e foi extraido do Kaggle.

Mais informações sobre esse dataset no link abaixo:

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data


# Arquitetura & Stack do Projeto
```bash
ERP+CSV     = Source
psql        = ingestão (Source ➡️ RAW)
SQL         = Modelagem & Load (RAW ➡️ Staging ➡️ Intermediate ➡️ DW ➡️ Análises)
.bat        = Orquestração
```



# Estrutura 
```bash
analise-dados-csv-sql-pbi/
│
├── dataset/
│   └── csv
│
├── sql/
│   ├── create_tables.sql
│   ├── ingestion_and_load.sql
│   └── create_and_load_analytcs.pbix
│
├── dashboard/
│   └── powerbi.pbix
│
└── README.md
```

# Fase Inicial - Criar/Popular um DB Local

### Ferramentas utilizadas na primeira fase:
-   Excel para validar os nomes das colunas que serão criadas;
-   PostgreSQL para criar as tabelas na camada raw;
-   psql para ingerir os dados dos CSVs no banco de dados.

#### Baixar os dados do ERP: 
Os dados de vendas, compras, clientes, vendedores e logística eram extraidos em formato CSV de dentro de um ERP e salvos em uma pasta que eu chamei de dataset.

#### Criar as tabelas da camada raw no Banco de Dados:
As tabelas da camada raw foram criadas com todas as colunas do tipo text. Pois, eu quis garantir a carga total dos dados e corrigir quaisquer tipo de anomalias após os dados já estivessem presentes no banco de dados.

Exemplo de uma das tabelas:
```SQL
create table if not exists raw.customers (
	customer_id text
	,customer_unique_id text
	,customer_zip_code_prefix text
	,customer_city text
	,customer_state text
);
```

#### Realizar a ingestão dos dados na camada raw:
Para a ingestão e cargas dos dados eu escolhi o tipo Full Load. Onde os dados já existentes são truncados e em seguida todos são carregados novamente.

Foi a forma mais rapida e eficiente considerando o baixo volume de dados e as mudanças quase que recorrentes feitas dentro do ERP e das regras de negócio.

A carga da camada raw foi feita no psql, que é a maneira menos burocratica em questões de segurança do SGBD, quando precisamos acessar arquivos dentro da nossa maquina local.
<br><br>

Exemplo da primeira carga uma das tabelas na camada raw:
```bash
\copy raw.customers, from 'C:\Users\gusta\projects\analise-dados-csv-sql-pbi\dataset\olist_customers_dataset.csv' with (format csv, header true, null '', encoding 'UTF8');
```
Exemplo do Refresh dos dados após a primeira carga na camada raw:
```bash
truncate raw.customers;

\copy raw.customers, from 'C:\Users\gusta\projects\analise-dados-csv-sql-pbi\dataset\olist_customers_dataset.csv' with (format csv, header true, null '', encoding 'UTF8');
```

# Segunda Fase - Criar/Popular a camada Staging

### Ferramentas utilizadas na segunda fase:
-   SQL para modelar as tabelas do Schema e gerar o script de Load entre a camada RAW e a camada Staging.

#### Objetivo da camada Staging:
Estruturar os dados brutos provenientes da camada Raw, aplicando tipagem apropriada, padronização de campos e ajustes técnicos iniciais, garantindo consistência estrutural antes das transformações de negócio.

Exemplo de uma das tabelas:
```SQL
create table if not exists staging.stg_order_items (
	order_id text
	,order_item_id bigint
	,product_id text
	,seller_id text
	,shipping_limit_date timestamp
	,price double precision
	,freight_value double precision
); 
```

Carga de uma das tabelas:
```SQL
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
```
> Em todas as tabelas foram aplicadas as funções nullif() e trim() para tratar inconsistências comuns em dados brutos. Como os dados foram inicialmente carregados como text, esse processo garante a remoção de espaços desnecessários e a conversão de strings vazias em valores NULL antes da tipagem.