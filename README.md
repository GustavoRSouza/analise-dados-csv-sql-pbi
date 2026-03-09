# Onde tudo começou

Esse projeto representa minha primeira experiência como BI Analyst em 2021. Quando antes do projeto ter sido realizado, a análise dos dados da empresa cuja qual fui contratado, era feita por meio de CTRL+C & CTRL+V do ERP direto em uma planilha de Excel.

> Antes da execução desse projeto, os relatórios diários demoravam cerca de 4 horas até ficarem prontos. E posteriormente consegui melhorar o tempo das analises para no máximo 30 minutos, quando a maior parte do tempo era apenas validando os dados para garantir a precição dos numeros nos paineis do dashboard.

> O dataset presente nesse projeto não representa exatamente a estrutura de dados do projeto real. Pois, o intuito real desse projeto é mostrar apenas as tecnologias e os processos utilizados para otimizar as analises e transformar a cultura da empresa em data driven.

## Arquitetura & Stack
```bash
ERP+CSV     = Source
psql        = ingestão (Source ➡️ RAW)
SQL         = Transformação (RAW ➡️ Staging)
SQL         = Transformação (Staging ➡️ DW)
SQL         = Transformação (DW ➡️ Análises)
Power BI    = Visualização
```



## Estrutura 
```bash
project/
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

## Fase Inicial - Criar/Popular um DB Local

Ferramentas utilizadas:
-   Excel para validar os nomes das colunas que serão criadas;
-   PostgreSQL para criar as tabelas na camada raw;
-   psql para ingerir os dados do CSV para o banco de dados.

#### Baixar os dados do ERP: 
Os dados de vendas, compras, clientes, vendedores e logística eram extraidos em formato CSV de dentro de um ERP e salvos em uma pasta que eu chamei de dataset.

#### Criar as tabelas:
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

#### Realizar a ingestão dos dados:
Para a ingestão e cargas dos dados eu escolhi o tipo Full Load. Onde os dados já existentes são truncados e em seguida todos são carregados novamente.

Era a forma mais rapida e eficiente considerando o baixo volume de dados e as mudanças quase que recorrentes feitas dentro do ERP e das regras de negócio.

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
