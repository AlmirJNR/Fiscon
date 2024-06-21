-- MIGRATION
CREATE TABLE IF NOT EXISTS state
(
    id      SMALLSERIAL PRIMARY KEY,
    acronym VARCHAR(2) UNIQUE
);

CREATE TABLE IF NOT EXISTS client
(
    id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    state_id     SMALLSERIAL REFERENCES state (id),
    name         VARCHAR(128),
    company_name VARCHAR(128),
    email        VARCHAR(128) UNIQUE
);

CREATE TABLE IF NOT EXISTS phone_type
(
    id          SMALLSERIAL PRIMARY KEY,
    description VARCHAR(32) UNIQUE
);

CREATE TABLE IF NOT EXISTS phone
(
    id        uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    phone_type_id   SMALLSERIAL REFERENCES phone_type (id),
    client_id uuid REFERENCES client (id),
    number    VARCHAR(64) UNIQUE
);

-- SEEDS
INSERT INTO state
VALUES (DEFAULT, 'MG'),
       (DEFAULT, 'SP')
ON CONFLICT DO NOTHING;

INSERT
INTO client
VALUES (DEFAULT, (SELECT id FROM state WHERE acronym = 'MG'), 'Almir', 'Almir&Tech', 'almirafjr.dev+mg@gmail.com'),
       (DEFAULT, (SELECT id FROM state WHERE acronym = 'SP'), 'Almir', 'Almir&Tech', 'almirafjr.dev+sp@gmail.com')
ON CONFLICT DO NOTHING;

INSERT INTO phone_type
VALUES (DEFAULT, 'personal'),
       (DEFAULT, 'comercial'),
       (DEFAULT, 'cellphone')
ON CONFLICT DO NOTHING;

WITH selected_client AS (SELECT client.id
                         FROM client
                                  INNER JOIN state ON state.id = client.state_id
                         WHERE email ILIKE 'almirafjr%'
                           AND acronym = 'MG')
INSERT
INTO phone
VALUES (DEFAULT, (SELECT id FROM phone_type WHERE description = 'personal'),
        (SELECT selected_client.id FROM selected_client), '+553190000-0000'),
       (DEFAULT, (SELECT id FROM phone_type WHERE description = 'comercial'),
        (SELECT selected_client.id FROM selected_client), '+55313456-0000'),
       (DEFAULT, (SELECT id FROM phone_type WHERE description = 'cellphone'),
        (SELECT selected_client.id FROM selected_client), '+553191111-0000')
ON CONFLICT DO NOTHING;

WITH selected_client AS (SELECT client.id
                         FROM client
                                  INNER JOIN state ON state.id = client.state_id
                         WHERE email ILIKE 'almirafjr%'
                           AND acronym = 'SP')
INSERT
INTO phone
VALUES (DEFAULT, (SELECT id FROM phone_type WHERE description = 'personal'),
        (SELECT selected_client.id FROM selected_client), '+551190000-0000'),
       (DEFAULT, (SELECT id FROM phone_type WHERE description = 'comercial'),
        (SELECT selected_client.id FROM selected_client), '+55113456-0000'),
       (DEFAULT, (SELECT id FROM phone_type WHERE description = 'cellphone'),
        (SELECT selected_client.id FROM selected_client), '+551191111-0000')
ON CONFLICT DO NOTHING;

-- QUERIES
SELECT client.id AS "código", client.company_name as "razão social", client.email as "e-mail", phone.number as "telefone(s)"
FROM client
         INNER JOIN state ON client.state_id = state.id
         INNER JOIN phone ON client.id = phone.client_id
WHERE state.acronym = 'SP';