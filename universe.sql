
CREATE DATABASE universe;

\c universe



CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    galaxy_type TEXT,
    distance_from_earth NUMERIC,        -- million light years
    diameter_light_years INT,
    has_supermassive_black_hole BOOLEAN
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    galaxy_id INT REFERENCES galaxy(galaxy_id),
    spectral_type TEXT,
    mass_solar_masses NUMERIC,
    age_million_years INT,
    is_variable BOOLEAN
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    star_id INT REFERENCES star(star_id),
    planet_type TEXT,
    mass_earth_masses NUMERIC,
    orbital_period_days INT,
    has_life BOOLEAN,
    is_spherical BOOLEAN DEFAULT TRUE
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    planet_id INT REFERENCES planet(planet_id),
    diameter_km INT,
    orbital_period_days NUMERIC,
    has_atmosphere BOOLEAN
);


CREATE TABLE comet (
    comet_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    orbital_period_years NUMERIC,
    last_seen_year INT,
    is_periodic BOOLEAN
);


INSERT INTO galaxy (name, galaxy_type, distance_from_earth, diameter_light_years, has_supermassive_black_hole) VALUES
('Milky Way', 'Barred Spiral', 0, 105700, TRUE),
('Andromeda', 'Spiral', 2537000, 220000, TRUE),
('Triangulum', 'Spiral', 2730000, 60000, FALSE),
('Whirlpool Galaxy', 'Spiral', 23000000, 60000, TRUE),
('Sombrero Galaxy', 'Spiral', 29300000, 50000, TRUE),
('Large Magellanic Cloud', 'Irregular', 163000, 14000, FALSE);


INSERT INTO star (name, galaxy_id, spectral_type, mass_solar_masses, age_million_years, is_variable) VALUES
('Sun', 1, 'G2V', 1.0, 4600, FALSE),
('Sirius', 1, 'A1V', 2.02, 230, FALSE),
('Betelgeuse', 1, 'M1-2', 16.5, 8000, TRUE),
('Proxima Centauri', 1, 'M5.5V', 0.12, 4850, TRUE),
('Rigel', 1, 'B8Ia', 21.0, 8000, FALSE),
('Vega', 1, 'A0V', 2.14, 455, FALSE);

-- Planets (12): 8 real solar system planets + 4 known exoplanets
INSERT INTO planet (name, star_id, planet_type, mass_earth_masses, orbital_period_days, has_life, is_spherical) VALUES
('Mercury', 1, 'Terrestrial', 0.055, 88, FALSE, TRUE),
('Venus', 1, 'Terrestrial', 0.815, 225, FALSE, TRUE),
('Earth', 1, 'Terrestrial', 1.0, 365, TRUE, TRUE),
('Mars', 1, 'Terrestrial', 0.107, 687, FALSE, TRUE),
('Jupiter', 1, 'Gas Giant', 317.8, 4333, FALSE, TRUE),
('Saturn', 1, 'Gas Giant', 95.2, 10759, FALSE, TRUE),
('Uranus', 1, 'Ice Giant', 14.5, 30687, FALSE, TRUE),
('Neptune', 1, 'Ice Giant', 17.1, 60190, FALSE, TRUE),
('Proxima Centauri b', 4, 'Terrestrial', 1.27, 11, FALSE, TRUE),
('HD 209458 b', 2, 'Gas Giant', 220, 3.5, FALSE, TRUE),
('Kepler-452b', 5, 'Terrestrial', 5.0, 385, FALSE, TRUE),
('51 Pegasi b', 6, 'Gas Giant', 150, 4.2, FALSE, TRUE);

-- Moons (20)
INSERT INTO moon (name, planet_id, diameter_km, orbital_period_days, has_atmosphere) VALUES
-- Earth
('Moon', 3, 3474, 27.3, FALSE),
-- Mars
('Phobos', 4, 22, 0.32, FALSE),
('Deimos', 4, 12, 1.26, FALSE),
-- Jupiter
('Io', 5, 3643, 1.77, FALSE),
('Europa', 5, 3122, 3.55, FALSE),
('Ganymede', 5, 5268, 7.15, FALSE),
('Callisto', 5, 4821, 16.7, FALSE),
-- Saturn
('Titan', 6, 5150, 15.9, TRUE),
('Enceladus', 6, 504, 1.37, FALSE),
('Mimas', 6, 396, 0.94, FALSE),
('Rhea', 6, 1527, 4.5, FALSE),
('Iapetus', 6, 1469, 79.3, FALSE),
-- Uranus
('Titania', 7, 1578, 8.7, FALSE),
('Oberon', 7, 1523, 13.5, FALSE),
('Miranda', 7, 471, 1.41, FALSE),
('Ariel', 7, 1158, 2.52, FALSE),
('Umbriel', 7, 1169, 4.14, FALSE),
-- Neptune
('Triton', 8, 2707, 5.88, TRUE),
('Nereid', 8, 340, 360.1, FALSE),
('Proteus', 8, 420, 1.12, FALSE);

-- Comets (5)
INSERT INTO comet (name, description, orbital_period_years, last_seen_year, is_periodic) VALUES
('Halley''s Comet', 'The most famous periodic comet, visible from Earth every 76 years', 76, 1986, TRUE),
('Hale-Bopp', 'One of the brightest comets seen in the 20th century', 2533, 1997, TRUE),
('Comet NEOWISE', 'Bright comet discovered in 2020, visible to the naked eye', 6800, 2020, TRUE),
('Encke', 'Has the shortest known orbital period of any comet', 3.3, 2023, TRUE),
('Hyakutake', 'Passed very close to Earth in 1996', 70000, 1996, TRUE);
