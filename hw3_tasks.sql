-- ============================================================
-- Фінальний проєкт — pandemic database
-- Завдання 2–5
-- Запускати після hw3_schema.sql та імпорту даних
-- ============================================================

USE pandemic;

-- ============================================================
-- Завдання 2 — Нормалізація до 3НФ
-- Entity та Code повторюються → виносимо в окрему таблицю
-- ============================================================

DROP TABLE IF EXISTS infectious_cases_normalized;
DROP TABLE IF EXISTS entities;

-- Таблиця entities (довідник країн/регіонів)
CREATE TABLE entities (
    id     INT          NOT NULL AUTO_INCREMENT,
    Entity VARCHAR(255) NOT NULL,
    Code   VARCHAR(10),
    PRIMARY KEY (id)
);

-- Заповнюємо унікальними комбінаціями Entity + Code
INSERT INTO entities (Entity, Code)
SELECT DISTINCT Entity, Code
FROM infectious_cases
ORDER BY Entity;

-- Нормалізована таблиця infectious_cases_normalized
CREATE TABLE infectious_cases_normalized (
    id                    INT AUTO_INCREMENT PRIMARY KEY,
    entity_id             INT NOT NULL,
    Year                  YEAR,
    Number_yaws           DOUBLE,
    polio_cases           DOUBLE,
    cases_guinea_worm     DOUBLE,
    Number_rabies         DOUBLE,
    Number_malaria        DOUBLE,
    Number_hiv            DOUBLE,
    Number_tuberculosis   DOUBLE,
    Number_smallpox       DOUBLE,
    Number_cholera_cases  DOUBLE,
    CONSTRAINT fk_ic_entity
        FOREIGN KEY (entity_id) REFERENCES entities (id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Переносимо дані
INSERT INTO infectious_cases_normalized (
    entity_id, Year, Number_yaws, polio_cases, cases_guinea_worm,
    Number_rabies, Number_malaria, Number_hiv, Number_tuberculosis,
    Number_smallpox, Number_cholera_cases
)
SELECT
    e.id,
    ic.Year,
    ic.Number_yaws,
    ic.polio_cases,
    ic.cases_guinea_worm,
    ic.Number_rabies,
    ic.Number_malaria,
    ic.Number_hiv,
    ic.Number_tuberculosis,
    ic.Number_smallpox,
    ic.Number_cholera_cases
FROM infectious_cases ic
JOIN entities e ON ic.Entity = e.Entity AND (ic.Code = e.Code OR (ic.Code IS NULL AND e.Code IS NULL));

-- Перевірити довідник entities
SELECT * FROM entities LIMIT 10;

-- Перевірити нормалізовану таблицю з джойном
SELECT e.Entity, e.Code, n.Year, n.Number_malaria, n.Number_tuberculosis
FROM infectious_cases_normalized n
JOIN entities e ON n.entity_id = e.id
LIMIT 20;

-- Порівняти кількість рядків
SELECT COUNT(*) FROM infectious_cases;
SELECT COUNT(*) FROM infectious_cases_normalized;

-- ============================================================
-- Завдання 3 — Аналіз: AVG, MIN, MAX, SUM для Number_rabies
-- Групувати за Entity/Code (або entity_id)
-- Відфільтрувати порожні значення Number_rabies
-- Сортувати за avg DESC, вивести 10 рядків
-- ============================================================

SELECT
    e.Entity,
    e.Code,
    AVG(n.Number_rabies) AS avg_rabies,
    MIN(n.Number_rabies) AS min_rabies,
    MAX(n.Number_rabies) AS max_rabies,
    SUM(n.Number_rabies) AS sum_rabies
FROM infectious_cases_normalized n
JOIN entities e ON n.entity_id = e.id
WHERE n.Number_rabies IS NOT NULL
  AND n.Number_rabies != 0
GROUP BY e.Entity, e.Code
ORDER BY avg_rabies DESC
LIMIT 10;

-- ============================================================
-- Завдання 4 — Колонка різниці в роках
-- first_jan: дата 1 січня відповідного року
-- current_dt: поточна дата
-- year_diff: різниця в роках між поточною датою та 1 січня року
-- ============================================================

SELECT
    Year,
    MAKEDATE(Year, 1)                                 AS first_jan,
    CURDATE()                                         AS current_dt,
    TIMESTAMPDIFF(YEAR, MAKEDATE(Year, 1), CURDATE()) AS year_diff
FROM infectious_cases_normalized
GROUP BY Year
ORDER BY Year;

-- ============================================================
-- Завдання 5 — Власна функція year_diff_from_now(year_val)
-- Приймає рік (INT), повертає різницю в роках між
-- поточною датою та 1 січня вказаного року (INT)
-- ============================================================

DROP FUNCTION IF EXISTS year_diff_from_now;

CREATE FUNCTION year_diff_from_now(year_val INT)
RETURNS INT
DETERMINISTIC
RETURN TIMESTAMPDIFF(YEAR, MAKEDATE(year_val, 1), CURDATE());

-- Застосовуємо функцію до таблиці
SELECT
    Year,
    MAKEDATE(Year, 1)        AS first_jan,
    CURDATE()                AS current_dt,
    year_diff_from_now(Year) AS year_diff
FROM infectious_cases_normalized
GROUP BY Year
ORDER BY Year;
