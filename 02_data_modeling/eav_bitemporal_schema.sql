-- Таблица ингредиентов (Entity)
CREATE TABLE Ingredients (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- Атрибуты ингредиентов (Attribute-Value)
CREATE TABLE IngredientAttributes (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ingredient_id BIGINT REFERENCES Ingredients(id),
    attribute_name VARCHAR(255) NOT NULL,
    attribute_value VARCHAR(255) NOT NULL
);

-- Битемпоральная таблица сроков годности
CREATE TABLE IngredientValidity (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ingredient_id BIGINT REFERENCES Ingredients(id),
    valid_from DATE NOT NULL,
    valid_to DATE,
    recorded_from TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    recorded_to TIMESTAMP
);
