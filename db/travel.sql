DROP TABLE cities;
DROP TABLE coutries;

CREATE TABLE countries
(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  visited BOOLEAN
);

CREATE TABLE cities
(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  visited BOOLEAN,
  country_id INT8 REFERENCES countries(id)
);
v
