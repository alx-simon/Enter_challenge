import duckdb

def get_sql_text(text):
    with open(f"./src/sql_file/{text}.sql") as fp:
        return fp.read()

def run_sql(text):
    print(f"Builing {text} ...")
    duckdb.sql(get_sql_text(text))
    print(f"Built {text}")

def main():
    run_sql("orders")
    run_sql("customers")
    run_sql("events")
    run_sql("analysis")
    print("All done")

main()
