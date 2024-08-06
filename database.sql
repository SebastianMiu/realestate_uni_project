CREATE DATABASE IF NOT EXISTS AgentieImobiliara;
USE AgentieImobiliara;

-- Crearea tabelelor
CREATE TABLE AgentiImobiliari (
    ID_agent INT AUTO_INCREMENT PRIMARY KEY,
    Nume_agent VARCHAR(100) NOT NULL,
    Nr_proprietati INT NOT NULL,
    Nr_telefon VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Proprietari (
    ID_proprietar INT AUTO_INCREMENT PRIMARY KEY,
    Nume_proprietar VARCHAR(100) NOT NULL,
    Nr_telefon VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Negociere BOOLEAN NOT NULL,
    ID_agent INT,
    FOREIGN KEY (ID_agent) REFERENCES AgentiImobiliari(ID_agent)
);

CREATE TABLE Proprietati (
    ID_proprietate INT AUTO_INCREMENT PRIMARY KEY,
    ID_agent INT,
    Sector INT NOT NULL,
    Nr_Camere INT NOT NULL,
    FOREIGN KEY (ID_agent) REFERENCES AgentiImobiliari(ID_agent)
);

CREATE TABLE DetaliiProprietate (
    ID_proprietate INT,
    Serviciu ENUM('vanzare', 'inchiriere', 'regim hotelier') NOT NULL,
    Tip_imobil VARCHAR(50) NOT NULL,
    Zona VARCHAR(50) NOT NULL,
    Suprafata FLOAT NOT NULL,
    Confort VARCHAR(20) NOT NULL,
    Risc_seismic BOOLEAN NOT NULL,
    Loc_de_parcare BOOLEAN NOT NULL,
    Pret DECIMAL(10, 2) NOT NULL,
    ID_proprietar INT,
    Valabilitate_incepand_cu DATE NOT NULL,
    PRIMARY KEY (ID_proprietate),
    FOREIGN KEY (ID_proprietate) REFERENCES Proprietati(ID_proprietate),
    FOREIGN KEY (ID_proprietar) REFERENCES Proprietari(ID_proprietar)
);

CREATE TABLE Specificatii (
    ID_spec INT AUTO_INCREMENT PRIMARY KEY,
    Serviciu ENUM('vanzare', 'inchiriere', 'regim hotelier') NOT NULL,
    Comision FLOAT NOT NULL,
    Negociere BOOLEAN NOT NULL,
    TVA FLOAT NOT NULL
);

CREATE TABLE Cerere (
    ID_cerere INT AUTO_INCREMENT PRIMARY KEY,
    Nume_client VARCHAR(100) NOT NULL,
    Nr_telefon_client VARCHAR(15) NOT NULL,
    ID_proprietate INT,
    Oferta DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_proprietate) REFERENCES Proprietati(ID_proprietate)
);


INSERT INTO AgentiImobiliari (Nume_agent, Nr_proprietati, Nr_telefon, Email) VALUES
('Ion Popescu', 5, '0712345678', 'ion.popescu@gmail.com'),
('Maria Vasilescu', 8, '0723456789', 'maria.vasilescu@gmail.com'),
('Andrei Ionescu', 3, '0734567890', 'andrei.ionescu@gmail.com'),
('Elena Georgescu', 12, '0712345671', 'elena.georgescu@gmail.com'),
('Vasile Ionescu', 7, '0723456782', 'vasile.ionescu@gmail.com'),
('Cristina Dumitrescu', 4, '0734567893', 'cristina.dumitrescu@gmail.com'),
('Adrian Mihai', 10, '0745678904', 'adrian.mihai@gmail.com'),
('Ioana Popa', 6, '0756789015', 'ioana.popa@gmail.com'),
('George Radulescu', 9, '0767890126', 'george.radulescu@gmail.com'),
('Ana Petrescu', 2, '0778901237', 'ana.petrescu@gmail.com'),
('Bogdan Pop', 5, '0789012348', 'bogdan.pop@gmail.com'),
('Diana Marin', 8, '0790123459', 'diana.marin@gmail.com'),
('Florin Tudor', 3, '0701234560', 'florin.tudor@gmail.com'),
('Gabriela Vasiliu', 12, '0712345671', 'gabriela.vasiliu@gmail.com'),
('Marius Ion', 7, '0723456782', 'marius.ion@gmail.com'),
('Carmen Dragomir', 4, '0734567893', 'carmen.dragomir@gmail.com'),
('Dan Marin', 10, '0745678904', 'dan.marin@gmail.com'),
('Nicoleta Popa', 6, '0756789015', 'nicoleta.popa@gmail.com'),
('Stefan Georgescu', 9, '0767890126', 'stefan.georgescu@gmail.com'),
('Laura Enescu', 2, '0778901237', 'laura.enescu@gmail.com');

INSERT INTO Proprietari (Nume_proprietar, Nr_telefon, Email, Negociere, ID_agent) VALUES
('Vasile Georgescu', '0745678901', 'vasile.georgescu@gmail.com', TRUE, 1),
('Elena Popa', '0756789012', 'elena.popa@gmail.com', FALSE, 2),
('Mihai Marin', '0767890123', 'mihai.marin@gmail.com', TRUE, 3),
('Iulia Dinu', '0778901234', 'iulia.dinu@gmail.com', TRUE, 4),
('Sorin Mihailescu', '0789012345', 'sorin.mihailescu@gmail.com', FALSE, 5),
('Adina Radu', '0790123456', 'adina.radu@gmail.com', TRUE, 6),
('Florin Ilie', '0701234567', 'florin.ilie@gmail.com', FALSE, 7),
('Oana Georgescu', '0712345678', 'oana.georgescu@gmail.com', TRUE, 8),
('Paul Ivan', '0723456789', 'paul.ivan@gmail.com', TRUE, 9),
('Roxana Ionescu', '0734567890', 'roxana.ionescu@gmail.com', FALSE, 10),
('Marius Stan', '0745678901', 'marius.stan@gmail.com', TRUE, 1),
('Gabriela Popescu', '0756789012', 'gabriela.popescu@gmail.com', FALSE, 2),
('Cristian Vasilescu', '0767890123', 'cristian.vasilescu@gmail.com', TRUE, 3),
('Alina Dumitru', '0778901234', 'alina.dumitru@gmail.com', TRUE, 4),
('Dan Pop', '0789012345', 'dan.pop@gmail.com', FALSE, 5),
('Irina Vlad', '0790123456', 'irina.vlad@gmail.com', TRUE, 6),
('George Dobre', '0701234567', 'george.dobre@gmail.com', FALSE, 7),
('Ana Sandu', '0712345678', 'ana.sandu@gmail.com', TRUE, 8),
('Adrian Ene', '0723456789', 'adrian.ene@gmail.com', TRUE, 9),
('Laura Tudor', '0734567890', 'laura.tudor@gmail.com', FALSE, 10),
('Maria Dragan','0755894123','maria.dragan@gmail.com',TRUE,1);

INSERT INTO Proprietati (ID_agent, Sector, Nr_Camere) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 4),
(4, 4, 2),
(5, 5, 1),
(6, 6, 3),
(7, 3, 2),
(8, 6, 4),
(9, 4, 1),
(10, 2, 3),
(1, 5, 4),
(2, 5, 2),
(3, 1, 3),
(4, 5, 2),
(5, 1, 4),
(6, 2, 1),
(7, 6, 3),
(8, 4, 2),
(9, 6, 4),
(10, 1, 3);

INSERT INTO DetaliiProprietate (ID_proprietate, Serviciu, Tip_imobil, Zona, Suprafata, Confort, Risc_seismic, Loc_de_parcare, Pret, ID_proprietar, Valabilitate_incepand_cu) VALUES
(1, 'vanzare', 'apartament', 'Crangasi', 75.5, 'lux', FALSE, TRUE, 75000.00, 1, '2024-01-01'),
(2, 'inchiriere', 'casa', 'Dristor', 150.0, 'mediu', FALSE, FALSE, 1200.00, 2, '2024-02-01'),
(3, 'regim hotelier', 'garsoniera', 'Gorjului', 35.0, 'standard', TRUE, TRUE, 200.00, 3, '2024-03-01'),
(4, 'vanzare', 'apartament', 'Aviatorilor', 60.0, 'lux', TRUE, TRUE, 80000.00, 4, '2024-04-01'),
(5, 'inchiriere', 'casa', 'Lujerului', 180.0, 'mediu', FALSE, TRUE, 1500.00, 5, '2024-05-01'),
(6, 'vanzare', 'apartament', 'Politehnica', 85.0, 'lux', TRUE, TRUE, 85000.00, 6, '2024-06-01'),
(7, 'inchiriere', 'casa', 'Berceni', 200.0, 'mediu', FALSE, TRUE, 1600.00, 7, '2024-07-01'),
(8, 'regim hotelier', 'garsoniera', 'Popesti-Leordeni', 40.0, 'standard', TRUE, TRUE, 250.00, 8, '2024-08-01'),
(9, 'vanzare', 'apartament', 'Giurgiului', 70.0, 'lux', TRUE, TRUE, 90000.00, 9, '2024-09-01'),
(10, 'inchiriere', 'casa', 'Rahova', 220.0, 'mediu', FALSE, TRUE, 1700.00, 10, '2024-10-01'),
(11, 'vanzare', 'apartament', 'Cotroceni', 95.0, 'lux', TRUE, TRUE, 95000.00, 1, '2024-11-01'),
(12, 'inchiriere', 'casa', 'Pantelimon', 240.0, 'mediu', FALSE, TRUE, 1800.00, 2, '2024-12-01'),
(13, 'regim hotelier', 'Colentina', 'Sector 1', 50.0, 'standard', TRUE, TRUE, 300.00, 3, '2024-01-01'),
(14, 'vanzare', 'apartament', 'Tei', 80.0, 'lux', TRUE, TRUE, 100000.00, 4, '2024-02-01'),
(15, 'inchiriere', 'casa', 'Oltenitei', 260.0, 'mediu', FALSE, TRUE, 1900.00, 5, '2024-03-01'),
(16, 'vanzare', 'apartament', 'Tineretului', 90.0, 'lux', FALSE, TRUE, 105000.00, 6, '2024-04-01'),
(17, 'inchiriere', 'casa', 'Vitan', 280.0, 'mediu', FALSE, TRUE, 2000.00, 7, '2024-05-01'),
(18, 'regim hotelier', 'garsoniera', 'Titan', 60.0, 'standard', TRUE, TRUE, 350.00, 8, '2024-06-01'),
(19, 'vanzare', 'apartament', 'Timpuri noi', 95.0, 'lux', TRUE, TRUE, 110000.00, 9, '2024-07-01'),
(20, 'inchiriere', 'casa', 'Centru Civic', 300.0, 'mediu', FALSE, TRUE, 2100.00, 10, '2024-08-01');

INSERT INTO Specificatii (Serviciu, Comision, Negociere, TVA) VALUES
('vanzare', 3.5, TRUE, 19),
('inchiriere', 50, FALSE, 19),
('regim hotelier', 0.0, TRUE, 9),
('vanzare', 3.0, TRUE, 19),
('inchiriere', 50, FALSE, 19),
('regim hotelier', 0.0, TRUE, 9),
('vanzare', 3.0, TRUE, 19),
('inchiriere', 50, FALSE, 19),
('regim hotelier', 0.0, TRUE, 9),
('vanzare', 3.2, TRUE, 19),
('inchiriere', 50, FALSE, 19),
('regim hotelier', 0.0, TRUE, 9),
('vanzare', 3.8, TRUE, 19),
('inchiriere', 50, FALSE, 19),
('regim hotelier', 0.0, TRUE, 9),
('vanzare', 3.2, TRUE, 19),
('inchiriere', 50, FALSE, 19),
('regim hotelier', 0.0, TRUE, 9),
('vanzare', 3.1, TRUE, 19),
('inchiriere', 50, FALSE, 19);


INSERT INTO Cerere (Nume_client, Nr_telefon_client, ID_proprietate, Oferta) VALUES
('Alex Popa', '0778901234', 1, 76000.00),
('Cristina Dumitrescu', '0789012345', 2, 1300.00),
('Bogdan Radulescu', '0790123456', 3, 250.00),
('Ana Petrescu', '0701234567', 4, 81000.00),
('George Mihailescu', '0712345678', 5, 1600.00),
('Mihai Alexandru', '0723456789', 6, 86000.00),
('Irina Stan', '0734567890', 7, 1700.00),
('Radu Vasile', '0745678901', 8, 300.00),
('Elena Ilie', '0756789012', 9, 91000.00),
('Florin Georgescu', '0767890123', 10, 1800.00),
('Laura Popescu', '0778901234', 11, 96000.00),
('Andrei Mihai', '0789012345', 12, 1900.00),
('Marian Tudor', '0790123456', 13, 350.00),
('Gabriela Ene', '0701234567', 14, 101000.00),
('Ioana Dragomir', '0712345678', 15, 2000.00),
('Victor Ionescu', '0723456789', 16, 106000.00),
('Daniela Georgescu', '0734567890', 17, 2100.00),
('Adrian Popa', '0745678901', 18, 400.00),
('Sorin Vasilescu', '0756789012', 19, 111000.00),
('Monica Dumitru', '0767890123', 20, 2200.00);



