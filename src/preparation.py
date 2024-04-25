import duckdb

def get_sql_text(text):
    with open(f"./src/sql_file/{text}.sql") as fp:
        return fp.read()

def run_sql(text):
    duckdb.sql(get_sql_text(text))

def main():
    run_sql("orders")
    run_sql("all_events")
    run_sql("customers")

main()
