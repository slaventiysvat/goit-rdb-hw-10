# GoIT RDB HW-10 — Pandemic Database (Нормалізація та аналіз)

## Передумови

- MySQL Server 8.0+
- MySQL Workbench (або будь-який MySQL клієнт)
- Файл `infectious_cases.csv` (є в цій папці)

## Як запустити

### Крок 1 — Створення схеми (один раз)

1. Відкрийте `hw3_schema.sql` у MySQL Workbench.
2. Виконайте весь файл (**Ctrl + Shift + Enter**) — створює базу `pandemic` та таблицю `infectious_cases`.

### Крок 2 — Імпорт даних (один раз)

1. У лівій панелі Workbench розгорніть `pandemic` → `Tables` → ПКМ на `infectious_cases`.
2. Оберіть **Table Data Import Wizard**.
3. Вкажіть шлях до `infectious_cases.csv` та виконайте імпорт.
4. Перевірка: `SELECT COUNT(*) FROM infectious_cases;` має повернути **10521**.

### Крок 3 — Виконання завдань

1. Відкрийте `hw3_tasks.sql`.
2. Виконайте весь файл або окремі блоки (виділіть потрібний блок → **Ctrl + Shift + Enter**).

> **Увага:** `hw3_tasks.sql` можна запускати повторно скільки завгодно разів.  
> `hw3_schema.sql` запускати **лише один раз** — він видаляє та перестворює базу.

## Завдання

| # | Файл | Опис |
|---|------|------|
| 1 | `hw3_schema.sql` | Створення схеми та таблиці для імпорту |
| 2 | `hw3_tasks.sql` | Нормалізація до 3НФ: таблиці `entities` та `infectious_cases_normalized` |
| 3 | `hw3_tasks.sql` | AVG, MIN, MAX, SUM для `Number_rabies` по країнах |
| 4 | `hw3_tasks.sql` | Різниця в роках між датою запису та поточною датою |
| 5 | `hw3_tasks.sql` | Власна функція `year_diff_from_now(year_val)` |

## Скріншоти результатів

| Файл | Завдання |
|------|----------|
| `Створення Shema Pandemic.png` | Завдання 1 — схема |
| `Importing Data to Schema Pandemic.png` | Завдання 1 — імпорт |
| `Task1_Table1.png` | Завдання 1 |
| `Task2_Table1.png` | Завдання 2 |
| `Task2_Table2.png` | Завдання 2 |
| `Task2_Table3.png` | Завдання 2 |
| `Task3_Table1.png` | Завдання 3 |
| `Task5_Table1.png` | Завдання 5 |

