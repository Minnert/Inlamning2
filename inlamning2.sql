-- SKAPA DATABAS
DROP DATABASE IF EXISTS Bokhandel;
CREATE DATABASE Bokhandel;
USE Bokhandel;

-- Skapar tabell Kund
-- KundID används som primärnyckel för att varje kund ska kunna identifieras unikt
CREATE TABLE kund (
    KundID INT AUTO_INCREMENT PRIMARY KEY,
    Namn VARCHAR(100) NOT NULL,
    Epost VARCHAR(100) NOT NULL,
    Telefon VARCHAR(30) NOT NULL,
    Adress VARCHAR(200) NOT NULL
);

-- Skapar tabell bok 
-- Bok ID används som primärnyckel 
-- ISBN är satt till UNIQUE eftersom varje bokutgåva ska ha ett unikt ISBN nummer
CREATE TABLE bok (
    BokID INT AUTO_INCREMENT PRIMARY KEY,
    Titel VARCHAR(200) NOT NULL,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    Forfattare VARCHAR(100) NOT NULL,
    Pris DECIMAL(10,2) NOT NULL,
    Lagersaldo INT NOT NULL
);
-- Skapar tabell bestallning
-- En kund kan ha många beställningar, därför kopplas kundID som FOREIGN KEY till kundtabellen
CREATE TABLE bestallning (
    BestallningsID INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT NOT NULL,
    Datum TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Totalbelopp DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (KundID) REFERENCES kund(KundID)
);

-- Skapar tabell orderrad
-- En beställning kan innehålla flera böcker därför delas beställningar upp i orderrader.
CREATE TABLE orderrad (
    OrderradID INT AUTO_INCREMENT PRIMARY KEY,
    BestallningsID INT NOT NULL,
    BokID INT NOT NULL,
    Antal INT NOT NULL,
    RadPris DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (BestallningsID) REFERENCES bestallning(BestallningsID),
    FOREIGN KEY (BokID) REFERENCES bok(BokID)
);

-- Skapar tabell kundlogg
-- Detta är en separat loggtabell för att visa spårbarhet
-- och för att demonstrera användning av trigger.
CREATE TABLE kundlogg (
    LoggID INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT NOT NULL,
    Namn VARCHAR(100) NOT NULL,
    Registrerad DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Skapar Index på epost
-- Detta förbättrar och effektiviserar sökningar på kundens e-post
CREATE INDEX idx_kund_epost ON kund(Epost);

-- Adderar CONSTRAINT i tabellen bok
-- Detta säkerställer datakvaliteten i databasen så att orimliga värden inte sparas
ALTER TABLE bok
ADD CONSTRAINT chk_bok_pris CHECK (Pris > 0);

-- Adderar CONSTRAINT i tabellen bok
-- Detta säkerställer datakvaliteten i databasen så att orimliga värden inte sparas
ALTER TABLE bok
ADD CONSTRAINT chk_bok_lagersaldo CHECK (Lagersaldo >= 0);

-- Adderar CONSTRAINT i tabellen orderrad
-- Detta säkerställer datakvaliteten i databasen så att orimliga värden inte sparas
ALTER TABLE orderrad
ADD CONSTRAINT chk_orderrad_antal CHECK (Antal > 0);

-- Adderar CONSTRAINT i tabellen orderrad
-- Detta säkerställer datakvaliteten i databasen så att orimliga värden inte sparas
ALTER TABLE orderrad
ADD CONSTRAINT chk_orderrad_radpris CHECK (RadPris > 0);

-- Adderar CONSTRAINT i tabellen bestallning
-- Detta säkerställer datakvaliteten i databasen så att orimliga värden inte sparas
ALTER TABLE bestallning
ADD CONSTRAINT chk_bestallning_totalbelopp CHECK (Totalbelopp >= 0);

-- Skapar trigger
-- Trigger används för att minska lagersaldo när en orderrad läggs till
-- samt logga när en ny kund registreras
DELIMITER //

CREATE TRIGGER trg_minska_lagersaldo
AFTER INSERT ON orderrad
FOR EACH ROW
BEGIN
    UPDATE bok
    SET Lagersaldo = Lagersaldo - NEW.Antal
    WHERE BokID = NEW.BokID;
END //

-- Loggar när en ny kund skapas.
CREATE TRIGGER trg_logga_ny_kund
AFTER INSERT ON kund
FOR EACH ROW
BEGIN
    INSERT INTO kundlogg (KundID, Namn)
    VALUES (NEW.KundID, NEW.Namn);
END //

DELIMITER ;

-- TESTDATA
INSERT INTO kund (Namn, Epost, Telefon, Adress) VALUES
('Frodo Bagger', 'frodo@shire.me', '070-111 11 11', 'Baggershus, Fylke'),
('Sam Gamgi', 'sam@shire.me', '070-222 22 22', 'Gamgis gård, Fylke'),
('Gandalf Grå', 'gandalf@valinor.ma', '070-333 33 33', 'Vandraren utan adress'),
('Aragorn Elessar', 'aragorn@gondor.nu', '070-444 44 44', 'Minas Tirith, Gondor'),
('Legolas Grönblad', 'legolas@skogarna.se', '070-555 55 55', 'Mörkaskogen, Midgård');

INSERT INTO bok (Titel, ISBN, Forfattare, Pris, Lagersaldo) VALUES
('Sagan om ringen: Ringens brodraskap', '9789100123451', 'J.R.R. Tolkien', 129.00, 20),
('Sagan om ringen: De tva tornen', '9789100123452', 'J.R.R. Tolkien', 135.00, 18),
('Sagan om ringen: Konungens aterkomst', '9789100123453', 'J.R.R. Tolkien', 139.00, 15),
('Bilbo - En hobbits aventyr', '9789100123450', 'J.R.R. Tolkien', 119.00, 25);

INSERT INTO bestallning (KundID, Totalbelopp) VALUES
(1, 264.00),
(1, 119.00),
(1, 139.00),
(2, 367.00),
(4, 129.00);

INSERT INTO orderrad (BestallningsID, BokID, Antal, RadPris) VALUES
(1, 1, 1, 129.00),
(1, 2, 1, 135.00),
(2, 4, 1, 119.00),
(3, 3, 1, 139.00),
(4, 4, 2, 238.00),
(4, 3, 1, 129.00),
(5, 1, 1, 129.00);

-- HÄMTA, FILTRERA, SORTERA
SELECT * FROM kund;

SELECT * FROM bestallning;

SELECT * FROM kund
WHERE Namn LIKE 'F%';

SELECT * FROM kund
WHERE Epost LIKE '%shire.me';

SELECT Titel, Pris
FROM bok
ORDER BY Pris DESC;

-- UPDATE, DELETE, TRANSAKTION
-- Visar hur data kan uppdateras och hur transaktioner används
-- för att kunna ångra ändringar om något blir fel
UPDATE kund
SET Epost = 'frodo.bagger@shire.me'
WHERE KundID = 1;

SELECT * FROM kund
WHERE KundID = 1;

START TRANSACTION;

DELETE FROM kund
WHERE KundID = 5;

SELECT * FROM kund;

ROLLBACK;

SELECT * FROM kund
WHERE KundID = 5;

-- JOINS
-- Joins används för att kombinera information från flera tabeller
-- INNER JOIN visar endast kunder som har beställningar
SELECT k.KundID, k.Namn, b.BestallningsID, b.Datum, b.Totalbelopp
FROM kund k
INNER JOIN bestallning b ON k.KundID = b.KundID;

-- LEFT JOIN visar alla kunder, även de som inte gjort beställningar
SELECT k.KundID, k.Namn, b.BestallningsID, b.Totalbelopp
FROM kund k
LEFT JOIN bestallning b ON k.KundID = b.KundID;

-- GROUP BY OCH HAVING
-- Räknar antal beställningar per kund
SELECT k.KundID, k.Namn, COUNT(b.BestallningsID) AS AntalBestallningar
FROM kund k
LEFT JOIN bestallning b ON k.KundID = b.KundID
GROUP BY k.KundID, k.Namn;

-- Visar endast kunder som gjort fler än 2 beställningar
SELECT k.KundID, k.Namn, COUNT(b.BestallningsID) AS AntalBestallningar
FROM kund k
LEFT JOIN bestallning b ON k.KundID = b.KundID
GROUP BY k.KundID, k.Namn
HAVING COUNT(b.BestallningsID) > 2;

-- KONTROLL AV TRIGGERS
-- Dessa SELECT-satser används för att kontrollera att 
-- triggers har fungerat som tänkt:
-- bok visar om Lagersaldo minskat
-- Kundlogg visar om nya kunder Loggats
SELECT * FROM bok;
SELECT * FROM kundlogg;
SELECT * from kund 
