-- Функция построения иерархии с использованием рекурсивного CTE
CREATE OR REPLACE FUNCTION pavel_onitchchenko.getHierarchy(p_manager_id INT DEFAULT NULL) 
RETURNS TABLE (
    student VARCHAR(255),
    role VARCHAR(255),
    level INT,
    path_from_leader TEXT
) AS $$
WITH RECURSIVE hierarchy AS (
    -- Базовая часть (начальная точка)
    SELECT 
        e.name AS student,
        r.role_name AS role,
        1 AS level,
        e.name::TEXT AS path_from_leader
    FROM pavel_onitchchenko.employees e
    JOIN pavel_onitchchenko.roles r ON e.role_id = r.role_id
    WHERE (p_manager_id IS NULL AND e.manager_id IS NULL)
       OR e.employee_id = p_manager_id
    
    UNION ALL
    
    -- Рекурсивная часть (подчиненные)
    SELECT 
        e.name AS student,
        r.role_name AS role,
        h.level + 1 AS level,
        h.path_from_leader || ' -> ' || e.name AS path_from_leader
    FROM pavel_onitchchenko.employees e
    JOIN pavel_onitchchenko.roles r ON e.role_id = r.role_id
    JOIN hierarchy h ON e.manager_id = (SELECT employee_id FROM pavel_onitchchenko.employees WHERE name = h.student)
)
SELECT * FROM hierarchy;
$$ LANGUAGE sql;
