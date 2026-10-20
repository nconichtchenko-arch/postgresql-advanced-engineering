-- Хаб "Person"
CREATE TABLE Hub_Person (
    person_id BIGINT PRIMARY KEY,
    load_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50)
);

-- Спутник "Person"
CREATE TABLE Sat_Person (
    person_id BIGINT REFERENCES Hub_Person(person_id),
    name VARCHAR(255),
    age INT,
    gender VARCHAR(10),
    address TEXT,
    load_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hash_diff VARCHAR(64),
    PRIMARY KEY (person_id, load_date)
);

-- Хаб "Pizzeria"
CREATE TABLE Hub_Pizzeria (
    pizzeria_id BIGINT PRIMARY KEY,
    load_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50)
);

-- Спутник "Pizzeria"
CREATE TABLE Sat_Pizzeria (
    pizzeria_id BIGINT REFERENCES Hub_Pizzeria(pizzeria_id),
    name VARCHAR(255),
    rating NUMERIC(3, 2),
    load_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hash_diff VARCHAR(64),
    PRIMARY KEY (pizzeria_id, load_date)
);

-- Линк "PersonVisits"
CREATE TABLE Link_PersonVisits (
    link_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    person_id BIGINT REFERENCES Hub_Person(person_id),
    pizzeria_id BIGINT REFERENCES Hub_Pizzeria(pizzeria_id),
    visit_date DATE NOT NULL,
    load_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
