import airflow
from airflow.operators.python_operator import PythonOperator
from airflow.models import DAG

import time
from pprint import pprint

args = {"owner": "Boston Python", "start_date": airflow.utils.dates.days_ago(2)}

dag = DAG(dag_id="run_me_first", default_args=args, schedule_interval=None)


def print_context(ds, **kwargs):
    pprint("First Airflow task is running with ds: {} and kwargs: {}".format(ds, kwargs))


def print_iteration(loop_iteration):
    pprint(f"I am the {loop_iteration}th task created!")


first_task = PythonOperator(
    task_id="print_context", provide_context=True, python_callable=print_context, dag=dag
)

for i in range(5):
    loop_task = PythonOperator(
        task_id=f"created_in_loop_{i}", python_callable=print_context, dag=dag, op_args=[i]
    )
    first_task >> loop_task
