"""
Генерує infectious_cases_data.sql з INSERT-statements з infectious_cases.csv
Порожні значення перетворює на NULL
"""
import csv
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
CSV_FILE = os.path.join(BASE_DIR, "infectious_cases.csv")
OUTPUT_FILE = os.path.join(BASE_DIR, "infectious_cases_data.sql")

COLUMNS = [
    "Entity", "Code", "Year", "Number_yaws", "polio_cases",
    "cases_guinea_worm", "Number_rabies", "Number_malaria",
    "Number_hiv", "Number_tuberculosis", "Number_smallpox", "Number_cholera_cases"
]

def escape(value):
    if value is None or value.strip() == "":
        return "NULL"
    value = value.replace("\\", "\\\\").replace("'", "\\'")
    return f"'{value}'"

rows = []
with open(CSV_FILE, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        values = ", ".join(escape(row.get(c, "")) for c in COLUMNS)
        rows.append(f"({values})")

col_list = ", ".join(COLUMNS)
batch_size = 100

with open(OUTPUT_FILE, "w", encoding="utf-8") as out:
    out.write("USE pandemic;\n\n")
    for i in range(0, len(rows), batch_size):
        batch = rows[i:i + batch_size]
        out.write(f"INSERT INTO infectious_cases ({col_list}) VALUES\n")
        out.write(",\n".join(f"  {r}" for r in batch))
        out.write(";\n\n")

print(f"Готово! {len(rows)} рядків → {OUTPUT_FILE}")
