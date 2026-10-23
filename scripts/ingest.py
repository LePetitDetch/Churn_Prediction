from pathlib import Path

import duckdb

ROOT = Path(__file__).resolve().parents[1]
CSV_PATH = ROOT / "data" / "raw" / "Churn.csv"
DB_PATH = ROOT / "warehouse" / "churn.duckdb"

con = duckdb.connect(str(DB_PATH))
con.execute("CREATE SCHEMA IF NOT EXISTS raw")
con.execute(f"""
    CREATE OR REPLACE TABLE raw.customers AS
    SELECT * FROM read_csv('{CSV_PATH.as_posix()}', header = true, all_varchar = true)
""")

rows = con.execute("SELECT count(*) FROM raw.customers").fetchall()[0][0]
print(f"{rows} lignes chargées dans raw.customers")

columns = con.execute("DESCRIBE raw.customers").fetchall()
for name, col_type, *_ in columns:
    print(f"  {name:<20} {col_type}")

con.close()