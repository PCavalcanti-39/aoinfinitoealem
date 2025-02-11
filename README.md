# Jornada Engenharia de dados
![Desafio Engenheiro de Dados](Desafio%20-%20Jornada%20Engenharia%20de%20Dados.png "Desafio Engenheiro de Dados")

Bem-vindo ao Mapa do Engenheiro de Dados, um programa prático e desafiador que recria situações reais enfrentadas por profissionais da área de dados. Neste módulo, você será guiado na construção de uma arquitetura robusta e paralela, que simula um ambiente dinâmico e ininterrupto, tal como ocorre no mercado.

Ao longo do curso, você aprenderá os fundamentos e aplicará técnicas avançadas de modelagem de dados, desenvolvendo consultas transacionais e analíticas em SQL, alcançando um nível de maestria.

# Liga Sudoers - Arquitetura de Big Data

Este repositório visa mostrar o processo trandicional de geração de dados em ambiente transacionais e ETL para ambiente analiticos. Ao subir os containeres serão:
  * 1 ambiente PostgreSQL com modelagem transacional, usando 3 forma normal (3FN)
  * 1 ambiente PostgreSQL com modelagem dimensional. usando star schema. 
  * 1 ambiente com Debezium para CDC.
  * 1 ambiente com Kafka para Streaming.
  * 1 ambiente com Zookeeper para apoio aos serviços.
  * 1 ambiente com Airflow para orquestração de pipelines.
  * 1 ambiente com DBT para Transformação de dados.
  * 1 ambiente com Spark para processamento distribuído.
  * 1 ambiente com MinIO para armazenamento distribuído.
  
  
  Dentro do repositório teremos os scripts em Python que irão simular a entrada de dados:
  * liga_sudoers_historico.py - Gera dados históricos com pedidos com data retroativas, não gera novos produtos nem novos clientes. Gera 1% de dados que serão considerados fraude para treinamento do modelo. 
  * liga_sudoers_streaming.py - Gera dados streamind com pedidos com data atual, gera novos clientes e registra novos pedidos. Gera 5% de dados que serão considerados fraude para treinamento do modelo. 

  [Vídeo Explicativo](https://youtu.be/Kc-mmy8eMcA)


## Estrutura da Fraude

A fraude é usada para treinar o modelo de Machine Learning que será usado para identificar fraudes em tempo real. O ambiente dimensional (DataWarehouse) extrai os dados via ETL (DBT) e popula as informações no nosso Delta Lake para ser usado como ambiente analitico. Esse é um processo mais comum em ambientes de big data.

A fraude é encontrada no geohash (Lat/Lon) da pessoa que fez o pedido. Será considerado fraude qualquer posição geohash fora dos estados de SP, MG e RJ. Ou seja, caso a compra seja de uma posição fora dos estados, deverá ser marcada como fraude. 

A fraude é encontrar no dispositivo da pessoa que fez o pedido. Será considerado fraude qualquer pedido que tenha um dispositivo diferente dos anteriores na hora da compra. Ou seja, se a pessoas comprou anteriormente com Iphone, e agora tentou comprar com um Samsung o pedido será marcado como fraude. 

## Estrutura do Projeto
```bash
.
├── airflow_dags
├── dbt_project
│   ├── dbt_project.yml
│   ├── logs
│   │   └── dbt.log
│   ├── models
│   │   └── example_model.sql
│   └── profiles.yml
├── debezium-init
│   ├── 01_enable_replication.sql
│   ├── connect-log4j.properties
│   └── postgres-connector.json
├── delta_lake
│   ├── entrypoint.sh
│   ├── jars
│   │   ├── delta-core_2.12-2.4.0.jar
│   │   └── delta-storage-2.4.0.jar
│   └── pyspark
├── docker-compose.yml
├── kafka
│   └── server.properties
├── postgresql-init
│   └── 02_create_airflow_db.sql
├── quickstart
│   ├── organizations.csv
│   └── people.zip
└── README.md
```
## Perfil e responsabilidades

Perfis de profissionais e suas responsabilidades no dia a dia dos processos mostrados.
 - Data Architect (Arquiteto de Dados)
 - Data Engineer (Engenheiro de Dados)
 - Data Scientist (Cientista de Dados)
 - Platform Engineer (Engenheiro de Plataforma)
 - Machine Learning Engineer - MLOps (Engenheiro de Machine Learning - MLOps)
 - BI Analyst (Analista de BI)
 - Data Administrator (Administrador de Dados)
 - DevOps Engineer (Engenheiro de DevOps)


### Data Architect (Arquiteto de Dados)

Responsável por:

    Desenhar e definir a arquitetura do sistema para suportar cargas de trabalho de streaming e batch.
    Escolher tecnologias e ferramentas que atendam aos requisitos do negócio e escalabilidade.

Tarefas:

    Definir o fluxo de dados entre PostgreSQL, Kafka, Airflow/DBT e DataLake/DeltaLake.
    Criar estratégias de particionamento, armazenamento e governança no DeltaLake.
    Propor integrações para Machine Learning e GenAI.


### Data Engineer (Engenheiro de Dados)

Responsável por:

    Criar e gerenciar pipelines de dados que integram diferentes fontes, como PostgreSQL, Debezium, Kafka e DataLake/DeltaLake.
    Configurar e otimizar a ingestão de dados em streaming e batch.
    Garantir a qualidade, consistência e segurança dos dados ao longo do pipeline.

Tarefas:

    Configurar o Debezium para capturar alterações no PostgreSQL (CDC).
    Configurar Kafka para ingestão e transformação em tempo real.
    Desenvolver pipelines de dados no Airflow e transformações no DBT.
    Gerenciar o DeltaLake/Lakehouse, garantindo particionamento, versionamento e governança de dados.



### Data Scientist (Cientista de Dados)

Responsável por:

    Explorar, analisar e criar modelos preditivos ou de Machine Learning usando os dados do DataLake/DeltaLake.
    Desenvolver soluções avançadas que aproveitem as capacidades de Machine Learning e GenAI.

Tarefas:

    Criar pipelines de Machine Learning conectados ao DeltaLake.
    Realizar análises exploratórias e preparar dados para modelos.
    Integrar resultados de Machine Learning com Dashboards e soluções de GenAI.

### Platform Engineer (Engenheiro de Plataforma)    
Se o foco for na infraestrutura e na administração do ambiente (clusters, redes, segurança, etc.), o Engenheiro de Plataforma ou Engenheiro de Infraestrutura pode ser o responsável. 
Esse profissional cuida de:

    Deploy e manutenção dos clusters.
    Configuração de balanceamento de carga, alta disponibilidade e recuperação de desastres.
    Monitoramento do desempenho ferramentas como Prometheus, Grafana ou outro.

### Machine Learning Engineer - MLOps (Engenheiro de Machine Learning - MLOps)

Responsável por:

    Produzir e manter os modelos de Machine Learning em produção.
    Garantir a escalabilidade, monitoramento e re-treinamento dos modelos.

Tarefas:

    Conectar pipelines do DataLake/DeltaLake ao ambiente de Machine Learning.
    Configurar ferramentas de MLOps para treinamento e deploy de modelos.
    Monitorar a performance dos modelos e realizar ajustes conforme necessário.

### BI Analyst (Analista de BI)

Responsável por:

    Criar visualizações e relatórios que traduzam dados em insights para o negócio.
    Garantir que os Dashboards consumam dados diretamente do DeltaLake ou via APIs.

Tarefas:

    Desenvolver dashboards conectados ao DeltaLake.
    Traduzir necessidades de negócio em relatórios acionáveis.
    Manter e ajustar visualizações conforme mudanças nos dados ou no pipeline.

### Data Administrator (Administrador de Dados)

Responsável por:

    Garantir a segurança, qualidade e conformidade dos dados ao longo do sistema.
    Implementar políticas de acesso, privacidade e governança.

Tarefas:

    Monitorar permissões e acessos no DeltaLake e nos pipelines.
    Configurar e gerenciar políticas de segurança e retenção de dados.
    Realizar auditorias regulares para garantir conformidade com normas como LGPD/GPDR.

### DevOps Engineer (Engenheiro de DevOps)

Responsável por:

    Configurar, monitorar e escalar a infraestrutura que suporta o ambiente.
    Automatizar deploys e manutenção do sistema.

Tarefas:

    Configurar clusters de Kafka, DeltaLake e Airflow.
    Garantir alta disponibilidade para PostgreSQL e outros componentes.
    Criar pipelines CI/CD para deploy de código e infra.


### Database Administrator (DBA) ou Data Architect
Modelagem de Banco de Dados Transacional

    Profissional: Database Administrator (DBA) ou Data Architect
        Responsabilidades:
            Planejar e implementar a estrutura de bancos de dados relacionais.
            Garantir normalização, integridade referencial e alta performance em operações transacionais.
            Criar índices, restrições, triggers e stored procedures para otimizar operações.
            Monitorar e otimizar o desempenho do banco. 

### Data Warehouse Specialist ou Data Architect            
Modelagem Dimensional

    Profissional: Data Warehouse Specialist ou Data Architect
        Responsabilidades:
            Projetar esquemas dimensionais como Star Schema e Snowflake Schema.
            Criar tabelas de fato e dimensão para facilitar consultas analíticas.
            Trabalhar com conceitos como surrogate keys, granularidade e hierarquias.
            Garantir que os modelos atendam às necessidades de relatórios e análises.


### Data Engineer
Profissional: Data Engineer

    Responsabilidades:
        Desenvolver processos de ETL/ELT para extrair, transformar e carregar dados em Data Warehouses ou Data Lakes.
        Automação e orquestração de fluxos de dados usando ferramentas como Apache Airflow, Apache Hop, Talend ou Python.
        Integrar dados de múltiplas fontes e garantir qualidade e consistência.
        Monitorar e corrigir falhas nos pipelines para garantir alta disponibilidade.

### Data Analyst ou Business Intelligence (BI) Analyst
Criação de Dashboards

    Profissional: Data Analyst ou Business Intelligence (BI) Analyst
        Responsabilidades:
            Criar visualizações e relatórios interativos para tomada de decisão.
            Utilizar ferramentas de BI como Power BI, Tableau, Looker ou Metabase.
            Definir métricas e KPIs com base nos requisitos de negócios.
            Trabalhar diretamente com as partes interessadas para transformar dados em insights acionáveis.

## Pré-requisitos

- Python 3.x
- Biblioteca `psycopg2`
- Biblioteca `Faker`


## Antes de Executar


### Instalação do Docker Compose
```bash
sudo apt update
sudo apt install docker-compose-plugin
```

### Verificação da Versão (opcional)
```bash
docker compose version
```


## Como Executar

### Iniciar Docker pela primeira vez (somente a primeira vez que rodar o processo)
```bash
docker compose up --build
```

### Iniciar Docker pela segunda vez
```bash
docker compose up 
```

### Parar o Docker Compose caso esteja rodando
```bash
docker compose stop
```

# Modo Terminal 

### Iniciando o armazenamento distribuído com MinIO:

Logando no container para configurar os buckets.
```bash
docker exec -it minio sh
```


### Configurar o MINIO
Adicionar o alias para acessar ao ambiente. 
```bash
mc alias set local http://minio:9000 sudoers123 sudoers1234
```


### Crie um bucket para armazenar os dados:
Criar os buckets que irão servir para armazenar os dados. Criaremos as camadas raw, trusted e refined para o Data Lake.
```bash
mc mb local/raw
mc mb local/trusted
mc mb local/refined
```


### Copiar arquivo para dentro do MINIO
```bash
mc cp /home/dim_pessoas.csv  local/raw/dim_pessoas/dim_pessoas.csv
```

### Sete o bucket para que sejam públicos.
```bash
mc anonymous set public local/raw
mc anonymous set public local/trusted
mc anonymous set public local/refined
```

### Utilizar o AWS CLI (Opcional)
O MinIO é compatível com o protocolo S3, então você também pode usar o aws-cli para listar e visualizar arquivos.
Faça a configuração no host.

    Configure o aws-cli para o MinIO:
        Configure o perfil para o MinIO:

```bash
aws configure --profile minio

    Access Key: sudoers123
    Secret Key: sudoers1234
    Default region: Deixe vazio
    Default output: json
```

Liste os buckets:

```bash
aws s3 ls --endpoint-url http://localhost:9000 --profile minio

# Liste os arquivos em um bucket:

aws s3 ls s3://raw --endpoint-url http://localhost:9000 --profile minio
```



# Visualizar UI
Abra o browser na sua máquina e acesso a url:`http://localhost:9000`

```bash
user:sudoers123
pass:sudoers1234
```

## Modo Nutela
Via UI faça a criação de um bucket com nome `staging`



# Continue no quickstart/README.md