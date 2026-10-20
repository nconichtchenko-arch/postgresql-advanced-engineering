-- Создаем схему
CREATE SCHEMA IF NOT EXISTS pavel_onitchchenko;

-- Таблица для справочника ролей
CREATE TABLE pavel_onitchchenko.roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(255) NOT NULL
);

-- Таблица для участников проекта
CREATE TABLE pavel_onitchchenko.employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role_id INT REFERENCES pavel_onitchchenko.roles(role_id),
    manager_id INT REFERENCES pavel_onitchchenko.employees(employee_id)
);

-- Заполняем справочник ролей
INSERT INTO pavel_onitchchenko.roles (role_name) VALUES 
('лидер проекта'), 
('тимилд команды разработчиков'), 
('frontend разработчик'), 
('backend разработчик'), 
('тимилд команды специалистов по тестированию');

-- Заполняем таблицу сотрудников
INSERT INTO pavel_onitchchenko.employees (name, role_id, manager_id) VALUES 
('Сергей Петров', 1, NULL), -- Лидер
('Ильяс Мухаметшин', 2, 1), -- Тимлид
('Анна Потапова', 5, 1),    -- Тимлид тестирования
('Иван Иванов', 3, 2),      -- Frontend
('Екатерина Андреева', 4, 2); -- Backend
