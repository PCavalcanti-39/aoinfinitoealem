from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

# Definindo argumentos padrão para o DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
}

# Inicialização do DAG
with DAG(
    'dbt_run_dag',
    default_args=default_args,
    description='Executa o fluxo do DBT',
    schedule_interval=None,
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=['dbt', 'etl'],
) as dag:

    # Tarefa para rodar o DBT para o schema bronze
    dbt_bronze = BashOperator(
        task_id='dbt_bronze',
        bash_command='docker exec -e DBT_SCHEMA=bronze spark /.local/bin/dbt run --models bronze --project-dir /usr/app/ --profiles-dir /usr/app/',
    )

    # Tarefa para rodar o DBT para o schema silver
    dbt_silver = BashOperator(
        task_id='dbt_silver',
        bash_command='docker exec -e DBT_SCHEMA=silver spark /.local/bin/dbt run --models silver --project-dir /usr/app/ --profiles-dir /usr/app/',
    )
    
    # Tarefa para rodar o DBT para o schema gold
    dbt_gold = BashOperator(
        task_id='dbt_gold',
        bash_command='docker exec -e DBT_SCHEMA=gold spark /.local/bin/dbt run --models gold --project-dir /usr/app/ --profiles-dir /usr/app/',
    )

    # Definindo a ordem de execução
    dbt_bronze >> dbt_silver >> dbt_gold