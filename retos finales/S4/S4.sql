CREATE DATABASE IF NOT EXISTS Class4Isai;
use Class4Isai;
-- UserID::Gender::Age::Occupation::Zip-code
CREATE TABLE users (
	UserID INT PRIMARY KEY,
    Gender VARCHAR(1),
    Age INT,
    Occupation INT,
    Zip_code VARCHAR(20)
);

DROP TABLE users;

-- Definir los campos y tipos de datos para la tabla movies haciendo uso de los archivos movies.dat y README.
-- MovieID::Title::Genres
-- Crear la tabla movies (recuerda usar el mismo nombre del archivo sin la extensión para vincular nombres de tablas con archivos).
CREATE TABLE movies (
	MovieID INT PRIMARY KEY,
    Title VARCHAR(80),
    Genres VARCHAR(80)
);
-- Definir los campos y tipos de datos para la tabla ratings haciendo uso de los archivos ratings.dat y README.
-- UserID::MovieID::Rating::Date
-- Crear la tabla ratings (recuerda usar el mismo nombre del archivo sin la extensión para vincular nombres de tablas con archivos)
CREATE TABLE ratings (
	UserID INT ,
    MovieID INT,
    Rating INT,
    Date BIGINT,
    CONSTRAINT RATINGS_FK1 FOREIGN KEY (UserID) REFERENCES users(UserID),
    CONSTRAINT RATINGS_FK2 FOREIGN KEY (MovieID) REFERENCES movies(MovieID)
);

select * from movies;
DELETE FROM movies WHERE MovieID > 0;