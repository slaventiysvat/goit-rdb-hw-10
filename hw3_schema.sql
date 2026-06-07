-- ============================================================
-- Фінальний проєкт — pandemic database
-- Завдання 1 — Створення схеми та таблиці для імпорту даних
-- ЗАПУСКАТИ ОДИН РАЗ, після чого імпортувати infectious_cases.csv
-- через Table Data Import Wizard
-- ============================================================

DROP DATABASE IF EXISTS pandemic;
CREATE DATABASE pandemic CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pandemic;

-- Таблиця для імпорту сирих даних через Import Wizard
CREATE TABLE infectious_cases (
    id                    INT AUTO_INCREMENT PRIMARY KEY,
    Entity                VARCHAR(255),
    Code                  VARCHAR(10),
    Year                  YEAR,
    Number_yaws           DOUBLE,
    polio_cases           DOUBLE,
    cases_guinea_worm     DOUBLE,
    Number_rabies         DOUBLE,
    Number_malaria        DOUBLE,
    Number_hiv            DOUBLE,
    Number_tuberculosis   DOUBLE,
    Number_smallpox       DOUBLE,
    Number_cholera_cases  DOUBLE
);

-- Після імпорту через Import Wizard перевіряю кількість рядків:
SELECT COUNT(*) FROM infectious_cases;
