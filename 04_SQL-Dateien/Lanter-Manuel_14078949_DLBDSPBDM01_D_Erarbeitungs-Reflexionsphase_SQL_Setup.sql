-- =========================================================
-- DATENBANK ERSTELLEN
-- Projekt: Buchtausch-App
-- DBMS: Microsoft SQL Server Express 2022
-- =========================================================

CREATE DATABASE BuchtauschDB;
GO

USE BuchtauschDB;
GO 

-- =========================================================
-- ENTITÄT: ADRESSE
-- =========================================================

-- CREATE TABLE
CREATE TABLE Adresse (
    adresse_id INT IDENTITY(1,1) NOT NULL,
    strasse NVARCHAR(100) NOT NULL,
    hausnummer NVARCHAR(10) NOT NULL,
    plz NVARCHAR(10) NOT NULL,
    ort NVARCHAR(100) NOT NULL,
    land NVARCHAR(50) NOT NULL,
    standort GEOGRAPHY NOT NULL,

    CONSTRAINT PK_Adresse PRIMARY KEY (adresse_id),
    CONSTRAINT CK_Adresse_SRID CHECK (standort.STSrid = 4326)
);

-- INSERT DUMMY-DATEN
USE BuchtauschDB;
Go

INSERT INTO Adresse
    (strasse, hausnummer, plz, ort, land, standort)
VALUES
    (N'Friedrichstrasse',   N'50', N'10117', N'Berlin', N'Deutschland', geography::Point(52.5145, 13.3895, 4326)),
    (N'Alexanderstrasse',   N'12', N'10178', N'Berlin', N'Deutschland', geography::Point(52.5215, 13.4135, 4326)),
    (N'Schönhauser Allee',  N'85', N'10439', N'Berlin', N'Deutschland', geography::Point(52.5485, 13.4130, 4326)),
    (N'Müllerstrasse',      N'120',N'13349', N'Berlin', N'Deutschland', geography::Point(52.5560, 13.3495, 4326)),
    (N'Kantstrasse',        N'40', N'10625', N'Berlin', N'Deutschland', geography::Point(52.5060, 13.3180, 4326)),
    (N'Kottbusser Damm',    N'75', N'10967', N'Berlin', N'Deutschland', geography::Point(52.4920, 13.4230, 4326)),
    (N'Karl-Marx-Strasse',  N'110',N'12043', N'Berlin', N'Deutschland', geography::Point(52.4800, 13.4350, 4326)),
    (N'Tempelhofer Damm',   N'90', N'12101', N'Berlin', N'Deutschland', geography::Point(52.4670, 13.3850, 4326)),
    (N'Klosterstrasse',     N'25', N'13581', N'Berlin', N'Deutschland', geography::Point(52.5360, 13.1990, 4326)),
    (N'Bahnhofstrasse',     N'30', N'12555', N'Berlin', N'Deutschland', geography::Point(52.4550, 13.5760, 4326));

-- RÄUMLICHEN INDEX ERSTELLEN
USE BuchtauschDB;
Go

CREATE SPATIAL INDEX IX_Adresse_Standort
ON dbo.Adresse (standort)
USING GEOGRAPHY_AUTO_GRID;
GO

-- =========================================================
-- ENTITÄT: ZUSTAND
-- =========================================================

USE [BuchtauschDB];
GO

-- CREATE TABLE
CREATE TABLE Zustand (
    zustand_id INT IDENTITY(1,1) NOT NULL,
    bezeichnung NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_Zustand PRIMARY KEY (zustand_id),
    CONSTRAINT UQ_Zustand_Bezeichnung UNIQUE (bezeichnung)
);

-- INSERT DUMMY-DATEN

USE [BuchtauschDB];
GO

INSERT INTO Zustand (bezeichnung)
VALUES
    (N'Neuwertig'),
    (N'Sehr gut'),
    (N'Gut'),
    (N'Gebrauchsspuren'),
    (N'Stark gebraucht');

-- INSERT DUMMY-DATEN NACH FEEDBACK ZU PHASE 2

USE [BuchtauschDB];
GO

-- PHASE 3 – UMSETZUNG DES FEEDBACKS AUS PHASE 2
-- In Phase 2 wurden bewusst fünf fachlich sinnvolle Zustandswerte verwendet.
-- Im Feedback wurde diese Entscheidung inhaltlich nachvollzogen, jedoch auf die
-- formale Vorgabe von mindestens zehn Datensätzen pro Tabelle hingewiesen.
-- Daher wird die Tabelle Zustand um fünf weitere Zustandswerte ergänzt.

INSERT INTO Zustand (bezeichnung)
VALUES
    (N'Neu'),
    (N'Leichte Gebrauchsspuren'),
    (N'Deutliche Gebrauchsspuren'),
    (N'Beschädigt'),
    (N'Reparaturbedürftig');

-- =========================================================
-- ENTITÄT: VERLAG
-- =========================================================

USE [BuchtauschDB];
GO

-- CREATE TABLE
CREATE TABLE Verlag (
    verlag_id INT IDENTITY(1,1) NOT NULL,
    name NVARCHAR(150) NOT NULL,
    verlagsort NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_Verlag PRIMARY KEY (verlag_id),
    CONSTRAINT UQ_Verlag_Name_Ort UNIQUE (name, verlagsort)
);

-- INSERT DUMMY-DATEN

USE [BuchtauschDB];
GO

INSERT INTO Verlag (name, verlagsort)
VALUES
    (N'Suhrkamp Verlag',                N'Berlin'),
    (N'Aufbau Verlag',                  N'Berlin'),
    (N'Deutscher Taschenbuch Verlag',   N'München'),
    (N'Piper Verlag',                   N'München'),
    (N'Carl Hanser Verlag',             N'München'),
    (N'S. Fischer Verlag',              N'Frankfurt am Main'),
    (N'Kiepenheuer & Witsch',           N'Köln'),
    (N'Klett-Cotta',                    N'Stuttgart'),
    (N'Reclam Verlag',                  N'Ditzingen'),
    (N'Rowohlt Verlag',                 N'Hamburg');

-- =========================================================
-- ENTITÄT: GENRE
-- =========================================================

USE [BuchtauschDB];
GO

-- CREATE TABLE
CREATE TABLE Genre (
    genre_id INT IDENTITY(1,1) NOT NULL,
    bezeichnung NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_Genre PRIMARY KEY (genre_id),
    CONSTRAINT UQ_Genre_Bezeichnung UNIQUE (bezeichnung)
);


-- INSERT DUMMY-DATEN

USE [BuchtauschDB];
GO

INSERT INTO Genre (bezeichnung)
VALUES
    (N'Roman'),
    (N'Krimi'),
    (N'Thriller'),
    (N'Fantasy'),
    (N'Science-Fiction'),
    (N'Biografie'),
    (N'Sachbuch'),
    (N'Historischer Roman'),
    (N'Kinder- und Jugendbuch'),
    (N'Liebesroman');

-- =========================================================
-- ENTITÄT: AUTOR
-- =========================================================

USE [BuchtauschDB];
GO

-- CREATE TABLE
CREATE TABLE Autor (
    autor_id INT IDENTITY(1,1) NOT NULL,
    vorname NVARCHAR(100) NOT NULL,
    nachname NVARCHAR(100) NOT NULL,
    herkunftsland NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_Autor PRIMARY KEY (autor_id)
);

-- INSERT DUMMY-DATEN

USE [BuchtauschDB];
GO

INSERT INTO Autor (vorname, nachname, herkunftsland)
VALUES
    (N'Franz',      N'Kafka',       N'Tschechien'),
    (N'Hermann',    N'Hesse',       N'Deutschland'),
    (N'George',     N'Orwell',      N'Vereinigtes Königreich'),
    (N'J. K.',      N'Rowling',     N'Vereinigtes Königreich'),
    (N'J. R. R.',   N'Tolkien',     N'Vereinigtes Königreich'),
    (N'Stephen',    N'King',        N'USA'),
    (N'Agatha',     N'Christie',    N'Vereinigtes Königreich'),
    (N'Umberto',    N'Eco',         N'Italien'),
    (N'Yuval Noah', N'Harari',      N'Israel'),
    (N'Cornelia',   N'Funke',       N'Deutschland');


-- =========================================================
-- ENTITÄT: BENUTZER
-- =========================================================

USE [BuchtauschDB];
GO

-- CREATE TABLE
CREATE TABLE Benutzer (
    benutzer_id INT IDENTITY(1,1) NOT NULL,
    vorname NVARCHAR(100) NOT NULL,
    nachname NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL,
    telefon NVARCHAR(30) NULL,
    benutzerrolle NVARCHAR(30) NOT NULL,
    wohnadresse_id INT NOT NULL,

    CONSTRAINT PK_Benutzer PRIMARY KEY (benutzer_id),
    CONSTRAINT UQ_Benutzer_Email UNIQUE (email),

    CONSTRAINT CK_Benutzer_Rolle CHECK (
        benutzerrolle IN (
            N'Standardbenutzer',
            N'Bibliothekar',
            N'Entwickler'
        )
    ),

    CONSTRAINT FK_Benutzer_Adresse
        FOREIGN KEY (wohnadresse_id)
        REFERENCES Adresse(adresse_id)
);

-- INSERT DUMMY-DATEN

USE [BuchtauschDB];
GO

INSERT INTO Benutzer
    (vorname, nachname, email, telefon, benutzerrolle, wohnadresse_id)
VALUES
    (N'Anna',    N'Weber',      N'anna.weber@example.de',    N'0151 10000001', N'Standardbenutzer', 1),
    (N'Lukas',   N'Schneider',  N'lukas.schneider@example.de', N'0151 10000002', N'Standardbenutzer', 2),
    (N'Maria',   N'Fischer',    N'maria.fischer@example.de', NULL,              N'Standardbenutzer', 3),
    (N'Jonas',   N'Becker',     N'jonas.becker@example.de',  N'0151 10000004', N'Standardbenutzer', 4),
    (N'Sophie',  N'Wagner',     N'sophie.wagner@example.de', N'0151 10000005', N'Standardbenutzer', 5),
    (N'David',   N'Hoffmann',   N'david.hoffmann@example.de', NULL,              N'Standardbenutzer', 6),
    (N'Laura',   N'Koch',       N'laura.koch@example.de',    N'0151 10000007', N'Standardbenutzer', 7),
    (N'Felix',   N'Richter',    N'felix.richter@example.de', N'0151 10000008', N'Standardbenutzer', 8),
    (N'Julia',   N'Neumann',    N'julia.neumann@example.de', NULL,              N'Bibliothekar',     1),
    (N'Tobias',  N'Krüger',     N'tobias.krueger@example.de', N'0151 10000010', N'Entwickler',       2);

-- =========================================================
-- ENTITÄT: BUCH
-- =========================================================

USE [BuchtauschDB];
GO

-- CREATE TABLE
CREATE TABLE Buch (
    buch_id INT IDENTITY(1,1) NOT NULL,
    titel NVARCHAR(255) NOT NULL,
    erscheinungsjahr SMALLINT NOT NULL,
    sprache NVARCHAR(50) NOT NULL,
    isbn VARCHAR(13) NULL,
    verlag_id INT NOT NULL,
    genre_id INT NOT NULL,

    CONSTRAINT PK_Buch PRIMARY KEY (buch_id),

    CONSTRAINT CK_Buch_Erscheinungsjahr CHECK (
        erscheinungsjahr BETWEEN 1450 AND 2100
    ),

    CONSTRAINT CK_Buch_ISBN_Format CHECK (
        isbn IS NULL
        OR (
            LEN(isbn) = 13
            AND isbn NOT LIKE '%[^0-9]%'
        )
        OR (
            LEN(isbn) = 10
            AND LEFT(isbn, 9) NOT LIKE '%[^0-9]%'
            AND RIGHT(isbn, 1) LIKE '[0-9X]'
        )
    ),

    CONSTRAINT FK_Buch_Verlag
        FOREIGN KEY (verlag_id)
        REFERENCES Verlag(verlag_id),

    CONSTRAINT FK_Buch_Genre
        FOREIGN KEY (genre_id)
        REFERENCES Genre(genre_id)
);

-- UNIQUE INDEX FÜR ISBN

USE [BuchtauschDB];
GO

CREATE UNIQUE INDEX UX_Buch_ISBN
ON Buch (isbn)
WHERE isbn IS NOT NULL;

-- INSERT DUMMY-DATEN

USE [BuchtauschDB];
GO

INSERT INTO Buch
    (titel, erscheinungsjahr, sprache, isbn, verlag_id, genre_id)
VALUES
    -- ISBN-10 mit X als letzter Stelle
    (N'Die Verwandlung',
     1915, N'Deutsch', '316148410X', 9, 1),

    -- ISBN-10 mit numerischer letzter Stelle
    (N'Siddhartha',
     1922, N'Deutsch', '0140449132', 1, 1),

    -- ISBN-13
    (N'1984',
     1949, N'Deutsch', '9780000000019', 3, 5),

    (N'Harry Potter und der Stein der Weisen',
     1997, N'Deutsch', '9780000000026', 10, 4),

    (N'Der Herr der Ringe',
     1954, N'Deutsch', '9780000000033', 8, 4),

    (N'Es',
     1986, N'Deutsch', '9780000000040', 10, 3),

    (N'Mord im Orientexpress',
     1934, N'Deutsch', '9780000000057', 6, 2),

    (N'Der Name der Rose',
     1980, N'Deutsch', '9780000000064', 5, 8),

    -- Keine ISBN vorhanden
    (N'Eine kurze Geschichte der Menschheit',
     2011, N'Deutsch', NULL, 4, 7),

    (N'Tintenherz',
     2003, N'Deutsch', NULL, 2, 9);

-- =========================================================
-- ENTITÄT: BUCH_AUTOR
-- =========================================================

USE [BuchtauschDB];
GO

-- CREATE TABLE
CREATE TABLE Buch_Autor (
    buch_id INT NOT NULL,
    autor_id INT NOT NULL,

    CONSTRAINT PK_Buch_Autor
        PRIMARY KEY (buch_id, autor_id),

    CONSTRAINT FK_Buch_Autor_Buch
        FOREIGN KEY (buch_id)
        REFERENCES Buch(buch_id),

    CONSTRAINT FK_Buch_Autor_Autor
        FOREIGN KEY (autor_id)
        REFERENCES Autor(autor_id)
);

-- INSERT DUMMY-DATEN

USE [BuchtauschDB];
GO

INSERT INTO Buch_Autor (buch_id, autor_id)
VALUES
    (1, 1),   
    (2, 2),   
    (3, 3),   
    (4, 4),   
    (5, 5),   
    (6, 6),   
    (7, 7),   
    (8, 8),   
    (9, 9),   
    (10, 10); 

-- =========================================================
-- ENTITÄT: BUCHANGEBOT
-- =========================================================

USE [BuchtauschDB];
GO

-- CREATE TABLE
CREATE TABLE Buchangebot (
    buchangebot_id INT IDENTITY(1,1) NOT NULL,
    max_ausleihdauer SMALLINT NOT NULL,
    versand_moeglich BIT NOT NULL,
    angebotsstatus NVARCHAR(20) NOT NULL,
    benutzer_id INT NOT NULL,
    buch_id INT NOT NULL,
    zustand_id INT NOT NULL,
    abholadresse_id INT NOT NULL,

    CONSTRAINT PK_Buchangebot PRIMARY KEY (buchangebot_id),

    CONSTRAINT CK_Buchangebot_Ausleihdauer CHECK (
        max_ausleihdauer > 0
    ),

    CONSTRAINT CK_Buchangebot_Status CHECK (
        angebotsstatus IN (
            N'aktiv',
            N'pausiert'
        )
    ),

    CONSTRAINT FK_Buchangebot_Benutzer
        FOREIGN KEY (benutzer_id)
        REFERENCES Benutzer(benutzer_id),

    CONSTRAINT FK_Buchangebot_Buch
        FOREIGN KEY (buch_id)
        REFERENCES Buch(buch_id),

    CONSTRAINT FK_Buchangebot_Zustand
        FOREIGN KEY (zustand_id)
        REFERENCES Zustand(zustand_id),

    CONSTRAINT FK_Buchangebot_Adresse
        FOREIGN KEY (abholadresse_id)
        REFERENCES Adresse(adresse_id)
);

-- INSERT DUMMY-DATEN

USE [BuchtauschDB];
GO

INSERT INTO Buchangebot
    (max_ausleihdauer, versand_moeglich, angebotsstatus,
     benutzer_id, buch_id, zustand_id, abholadresse_id)
VALUES
    (14, 1, N'aktiv',    1,  1, 2, 1),
    (21, 0, N'aktiv',    2,  2, 3, 2),
    (14, 1, N'aktiv',    3,  3, 1, 3),
    (30, 1, N'pausiert', 4,  4, 2, 4),
    (7,  0, N'aktiv',    5,  5, 4, 5),
    (14, 1, N'aktiv',    6,  6, 3, 6),
    (21, 0, N'pausiert', 7,  7, 5, 7),
    (30, 1, N'aktiv',    8,  8, 2, 8),
    (14, 1, N'aktiv',    1,  9, 3, 3),
    (21, 0, N'aktiv',    2,  1, 4, 4);

-- =========================================================
-- ENTITÄT: ZEITSLOT
-- =========================================================

USE [BuchtauschDB];
GO

-- CREATE TABLE
CREATE TABLE Zeitslot (
    zeitslot_id INT IDENTITY(1,1) NOT NULL,
    datum DATE NOT NULL,
    startzeit TIME(0) NOT NULL,
    endzeit TIME(0) NOT NULL,
    buchangebot_id INT NOT NULL,

    CONSTRAINT PK_Zeitslot PRIMARY KEY (zeitslot_id),

    CONSTRAINT CK_Zeitslot_Zeitfenster CHECK (
        startzeit < endzeit
    ),

    CONSTRAINT UQ_Zeitslot
        UNIQUE (buchangebot_id, datum, startzeit, endzeit),

    CONSTRAINT FK_Zeitslot_Buchangebot
        FOREIGN KEY (buchangebot_id)
        REFERENCES Buchangebot(buchangebot_id)
);

-- TRIGGER GEGEN ÜBERLAPPENDE ZEITSLOTS

USE [BuchtauschDB];
GO

CREATE TRIGGER TR_Zeitslot_Ueberschneidung
ON Zeitslot
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Prüft, ob sich ein neu eingefügter oder geänderter
    -- Zeitslot mit einem bereits vorhandenen Zeitslot überschneidet.
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Zeitslot z
            ON i.buchangebot_id = z.buchangebot_id
            AND i.datum = z.datum
            AND i.zeitslot_id <> z.zeitslot_id
            AND i.startzeit < z.endzeit
            AND i.endzeit > z.startzeit
    )
    BEGIN
        THROW 50001,
              'Der Zeitslot überschneidet sich mit einem bestehenden Zeitslot.',
              1;
    END
END;
GO

-- INSERT DUMMY-DATEN

USE [BuchtauschDB];
GO

INSERT INTO Zeitslot
    (datum, startzeit, endzeit, buchangebot_id)
VALUES
    -- Direkt aufeinanderfolgende, aber nicht überlappende Zeitslots
    ('2026-10-27', '17:00', '18:00', 1),
    ('2026-10-27', '18:00', '19:00', 1),
    ('2026-10-28', '18:00', '19:00', 3),
    ('2026-10-28', '19:00', '20:00', 3),

    -- Weitere gültige Zeitslots für aktive Buchangebote
    ('2026-10-28', '17:00', '18:00', 2),
    ('2026-10-29', '16:00', '17:00', 5),
    ('2026-10-29', '18:00', '19:00', 6),
    ('2026-10-30', '17:30', '18:30', 8),
    ('2026-10-30', '18:00', '19:00', 9),
    ('2026-10-31', '10:00', '11:00', 10);

-- =========================================================
-- ENTITÄT: AUSLEIHE
-- =========================================================

USE [BuchtauschDB];
GO

-- CREATE TABLE
CREATE TABLE Ausleihe (
    ausleihe_id INT IDENTITY(1,1) NOT NULL,
    ausleihdatum DATE NOT NULL,
    rueckgabe_soll DATE NOT NULL,
    rueckgabe_ist DATE NULL,
    ausleihstatus NVARCHAR(20) NOT NULL,
    uebergabeart NVARCHAR(20) NOT NULL,
    benutzer_id INT NOT NULL,
    buchangebot_id INT NOT NULL,
    zeitslot_id INT NULL,

    CONSTRAINT PK_Ausleihe PRIMARY KEY (ausleihe_id),

    CONSTRAINT CK_Ausleihe_Datum CHECK (
        rueckgabe_soll >= ausleihdatum
        AND (
            rueckgabe_ist IS NULL
            OR rueckgabe_ist >= ausleihdatum
        )
    ),

    CONSTRAINT CK_Ausleihe_Status CHECK (
        ausleihstatus IN (
            N'aktiv',
            N'abgeschlossen',
            N'storniert'
        )
    ),

    CONSTRAINT CK_Ausleihe_Uebergabeart CHECK (
        uebergabeart IN (
            N'Abholung',
            N'Versand'
        )
    ),

    CONSTRAINT CK_Ausleihe_Uebergabe_Zeitslot CHECK (
        (uebergabeart = N'Abholung' AND zeitslot_id IS NOT NULL)
        OR
        (uebergabeart = N'Versand' AND zeitslot_id IS NULL)
    ),

    CONSTRAINT FK_Ausleihe_Benutzer
        FOREIGN KEY (benutzer_id)
        REFERENCES Benutzer(benutzer_id),

    CONSTRAINT FK_Ausleihe_Buchangebot
        FOREIGN KEY (buchangebot_id)
        REFERENCES Buchangebot(buchangebot_id),

    CONSTRAINT FK_Ausleihe_Zeitslot
        FOREIGN KEY (zeitslot_id)
        REFERENCES Zeitslot(zeitslot_id)
);

-- UNIQUE INDEX FÜR AKTIVE AUSLEIHEN

USE [BuchtauschDB];
GO

CREATE UNIQUE INDEX UX_Ausleihe_Aktives_Buchangebot
ON Ausleihe (buchangebot_id)
WHERE ausleihstatus = N'aktiv';

-- UNIQUE INDEX FÜR AUSGEWÄHLTE ZEITSLOTS

USE [BuchtauschDB];
GO

CREATE UNIQUE INDEX UX_Ausleihe_Zeitslot
ON Ausleihe (zeitslot_id)
WHERE zeitslot_id IS NOT NULL;

-- TRIGGER ZUR VALIDIERUNG VON AUSLEIHEN

USE [BuchtauschDB];
GO

CREATE TRIGGER TR_Ausleihe_Validierung
ON Ausleihe
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Maximale Ausleihdauer des Buchangebots darf nicht überschritten werden.
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Buchangebot ba
            ON i.buchangebot_id = ba.buchangebot_id
        WHERE DATEDIFF(DAY, i.ausleihdatum, i.rueckgabe_soll)
              > ba.max_ausleihdauer
    )
    BEGIN
        THROW 50002,
              'Die maximale Ausleihdauer des Buchangebots wird überschritten.',
              1;
    END;

    -- Der ausgewählte Zeitslot muss zum gleichen Buchangebot gehören.
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Zeitslot z
            ON i.zeitslot_id = z.zeitslot_id
        WHERE i.zeitslot_id IS NOT NULL
          AND i.buchangebot_id <> z.buchangebot_id
    )
    BEGIN
        THROW 50003,
              'Der ausgewählte Zeitslot gehört nicht zum gewählten Buchangebot.',
              1;
    END;

    -- Versand ist nur erlaubt, wenn das Buchangebot Versand unterstützt.
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Buchangebot ba
            ON i.buchangebot_id = ba.buchangebot_id
        WHERE i.uebergabeart = N'Versand'
          AND ba.versand_moeglich = 0
    )
    BEGIN
        THROW 50004,
              'Für dieses Buchangebot ist kein Versand möglich.',
              1;
    END;

    -- Eine aktive Ausleihe darf nur für ein aktives Buchangebot erstellt werden.
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Buchangebot ba
            ON i.buchangebot_id = ba.buchangebot_id
        WHERE i.ausleihstatus = N'aktiv'
          AND ba.angebotsstatus <> N'aktiv'
    )
    BEGIN
        THROW 50005,
              'Ein pausiertes Buchangebot kann nicht aktiv ausgeliehen werden.',
              1;
    END;
END;
GO

-- INSERT DUMMY-DATEN

USE [BuchtauschDB];
GO

INSERT INTO Ausleihe
    (ausleihdatum, rueckgabe_soll, rueckgabe_ist, ausleihstatus,
     uebergabeart, benutzer_id, buchangebot_id, zeitslot_id)
VALUES
    -- Aktive Ausleihen mit Abholung und ausgewähltem Zeitslot
    ('2026-10-27', '2026-11-10', NULL, N'aktiv',
     N'Abholung', 2, 1, 1),

    ('2026-10-28', '2026-11-11', NULL, N'aktiv',
     N'Abholung', 3, 2, 5),

    ('2026-10-28', '2026-11-11', NULL, N'aktiv',
     N'Abholung', 4, 3, 3),

    ('2026-10-29', '2026-11-05', NULL, N'aktiv',
     N'Abholung', 6, 5, 6),

    ('2026-10-29', '2026-11-12', NULL, N'aktiv',
     N'Abholung', 7, 6, 7),

    ('2026-10-31', '2026-11-14', NULL, N'aktiv',
     N'Abholung', 3, 10, 10),

    -- Aktive Ausleihe mit Versand und daher ohne Zeitslot
    ('2026-10-26', '2026-11-09', NULL, N'aktiv',
     N'Versand', 10, 9, NULL),

    -- Historische Ausleihe mit verspäteter Rückgabe
    ('2026-09-01', '2026-09-15', '2026-09-18', N'abgeschlossen',
     N'Versand', 5, 1, NULL),

    -- Historische Ausleihe eines inzwischen pausierten Buchangebots
    ('2026-08-01', '2026-08-20', '2026-08-18', N'abgeschlossen',
     N'Versand', 7, 4, NULL),

    -- Stornierte Ausleihe ohne tatsächliche Rückgabe
    ('2026-09-20', '2026-10-04', NULL, N'storniert',
     N'Versand', 8, 3, NULL);


-- PHASE 3 – UMSETZUNG DES FEEDBACKS AUS PHASE 2
-- Für die zehnte Buchbewertung wird eine zusätzliche gültige
-- und abgeschlossene Ausleihe angelegt.
-- Buchangebot 3 ist aktiv, erlaubt Versand und besitzt eine
-- maximale Ausleihdauer von 14 Tagen.

INSERT INTO Ausleihe
(
    ausleihdatum,
    rueckgabe_soll,
    rueckgabe_ist,
    ausleihstatus,
    uebergabeart,
    benutzer_id,
    buchangebot_id,
    zeitslot_id
)
VALUES
(
    '2026-09-01',
    '2026-09-08',
    '2026-09-08',
    N'abgeschlossen',
    N'Versand',
    1,
    3,
    NULL
);



-- =========================================================
-- ENTITÄT: BUCHBEWERTUNG
-- =========================================================

USE [BuchtauschDB];
GO

-- CREATE TABLE
CREATE TABLE Buchbewertung (
    bewertung_id INT IDENTITY(1,1) NOT NULL,
    sterne TINYINT NOT NULL,
    kommentar NVARCHAR(500) NULL,
    bewertungsdatum DATE NOT NULL,
    ausleihe_id INT NOT NULL,

    CONSTRAINT PK_Buchbewertung PRIMARY KEY (bewertung_id),

    CONSTRAINT UQ_Buchbewertung_Ausleihe UNIQUE (ausleihe_id),

    CONSTRAINT CK_Buchbewertung_Sterne CHECK (
        sterne BETWEEN 1 AND 5
    ),

    CONSTRAINT FK_Buchbewertung_Ausleihe
        FOREIGN KEY (ausleihe_id)
        REFERENCES Ausleihe(ausleihe_id)
);

-- TRIGGER ZUR VALIDIERUNG VON BUCHBEWERTUNGEN

USE [BuchtauschDB];
GO

CREATE TRIGGER TR_Buchbewertung_Validierung
ON Buchbewertung
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Für stornierte Ausleihen darf keine Buchbewertung erstellt werden.
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Ausleihe a
            ON i.ausleihe_id = a.ausleihe_id
        WHERE a.ausleihstatus = N'storniert'
    )
    BEGIN
        THROW 50006,
              'Für eine stornierte Ausleihe kann keine Buchbewertung erstellt werden.',
              1;
    END;
END;
GO

-- INSERT DUMMY-DATEN

USE [BuchtauschDB];
GO

INSERT INTO Buchbewertung
    (sterne, kommentar, bewertungsdatum, ausleihe_id)
VALUES
    -- Bewertungen zu aktiven Ausleihen
    (5, N'Sehr guter Zustand und spannende Lektüre.', 
     '2026-11-01', 1),

    (4, N'Das Buch gefällt mir bisher sehr gut.', 
     '2026-11-02', 2),

    (5, NULL, 
     '2026-11-03', 3),

    (3, N'Interessant, aber nicht ganz mein Geschmack.', 
     '2026-11-01', 4),

    (4, N'Gut geschrieben und angenehm zu lesen.', 
     '2026-11-03', 5),

    (5, N'Bisher eines meiner Lieblingsbücher.', 
     '2026-11-04', 6),

    (2, NULL, 
     '2026-11-02', 7),

    -- Bewertungen zu abgeschlossenen Ausleihen
    (4, N'Regt zum Nachdenken an.', 
     '2026-09-19', 8),

    (5, N'Klare Empfehlung.', 
     '2026-08-19', 9);

-- PHASE 3 – UMSETZUNG DES FEEDBACKS AUS PHASE 2
-- Für die zusätzlich angelegte gültige Ausleihe mit ausleihe_id = 11 wird nun
-- die zehnte Buchbewertung ergänzt.
-- Damit wird die formale Vorgabe von mindestens zehn
-- Datensätzen in der Tabelle Buchbewertung erfüllt.

INSERT INTO Buchbewertung
(
    sterne,
    kommentar,
    bewertungsdatum,
    ausleihe_id
)
VALUES
(
    5,
    N'Unkomplizierte Ausleihe und guter Zustand.',
    '2026-09-09',
    11
);
