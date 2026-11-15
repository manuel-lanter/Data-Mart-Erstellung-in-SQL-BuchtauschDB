-- =========================================================
-- ENTITÄT: ADRESSE
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: VERFÜGBARE BUCHANGEBOTE IM UMKREIS
-- Sucht aktive und aktuell nicht ausgeliehene Buchangebote,
-- deren Abholadresse maximal 10 km vom definierten Standort entfernt liegt.

SELECT ba.buchangebot_id, b.titel, a.strasse, a.ort
FROM Buchangebot ba
INNER JOIN Buch b
    ON ba.buch_id = b.buch_id
INNER JOIN Adresse a
    ON ba.abholadresse_id = a.adresse_id
WHERE ba.angebotsstatus = N'aktiv'
  AND a.standort.STDistance(
      geography::Point(52.5145, 13.3895, 4326)
  ) <= 10000
  AND NOT EXISTS (
      SELECT 1
      FROM Ausleihe au
      WHERE au.buchangebot_id = ba.buchangebot_id
        AND au.ausleihstatus = N'aktiv'
  );

-- =========================================================
-- ENTITÄT: ZUSTAND
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: ZUSTANDSWERTE ANZEIGEN
-- Prüft, ob die definierten Zustandswerte korrekt
-- in der Lookup-Tabelle gespeichert wurden.

SELECT zustand_id, bezeichnung
FROM Zustand
ORDER BY zustand_id asc;

-- =========================================================
-- ENTITÄT: VERLAG
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: ANZAHL VERLAGE IN MÜNCHEN
-- Zählt, wie viele gespeicherte Verlage den Verlagsort München haben.

SELECT COUNT(*) AS anzahl_verlage_muenchen
FROM Verlag
WHERE verlagsort = N'München';

-- =========================================================
-- ENTITÄT: GENRE
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: GENRES MIT "ROMAN" SUCHEN
-- Zeigt alle gespeicherten Genres, deren Bezeichnung
-- den Begriff "Roman" enthält.

SELECT genre_id, bezeichnung FROM Genre
WHERE bezeichnung LIKE N'%Roman%'
ORDER BY genre_id;

-- =========================================================
-- ENTITÄT: AUTOR
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: AUTOREN NACH HERKUNFTSLAND ZÄHLEN
-- Zeigt, wie viele gespeicherte Autoren aus den jeweiligen Ländern stammen.

SELECT herkunftsland, COUNT(*) AS anzahl_autoren
FROM Autor
GROUP BY herkunftsland
ORDER BY anzahl_autoren DESC;

-- =========================================================
-- ENTITÄT: BENUTZER
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: EINDEUTIGE E-MAIL-ADRESSE
-- Versucht, Benutzer mit ID 2 eine bereits verwendete
-- E-Mail-Adresse zuzuweisen. Die UNIQUE-Constraint muss dies verhindern.

UPDATE Benutzer
SET email = N'anna.weber@example.de'
WHERE benutzer_id = 2;

-- =========================================================
-- ENTITÄT: BUCH
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: UNGÜLTIGE ISBN VERHINDERN
-- Simuliert eine fehlerhafte Eingabe bzw. Änderung eines bestehenden Datensatzes, 
-- bei der versehentlich eine Ziffer zu viel eingegeben wurde. Eine 11-stellige ISBN
-- ist nicht zulässig und muss durch die CHECK-Constraint abgelehnt werden.

UPDATE Buch
SET isbn = '12345678901'
WHERE buch_id = 9;

-- =========================================================
-- ENTITÄT: BUCH_AUTOR
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: DOPPELTE BUCH-AUTOR-ZUORDNUNG VERHINDERN
-- Versucht, eine bereits vorhandene Zuordnung erneut einzufügen.
-- Der zusammengesetzte Primärschlüssel muss dies verhindern.

INSERT INTO Buch_Autor (buch_id, autor_id)
VALUES (1, 1);

-- =========================================================
-- ENTITÄT: BUCHANGEBOT
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: AKTIVE BUCHANGEBOTE MIT BUCHTITEL ANZEIGEN
-- Zeigt alle aktiven Buchangebote und ergänzt über die Buch-ID
-- den zugehörigen Titel aus der Entität Buch.

SELECT
    ba.buchangebot_id,
    b.titel,
    ba.angebotsstatus
FROM Buchangebot ba
INNER JOIN Buch b
    ON ba.buch_id = b.buch_id
WHERE ba.angebotsstatus = N'aktiv';

-- =========================================================
-- ENTITÄT: ZEITSLOT
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: ÜBERLAPPENDE ZEITSLOTS VERHINDERN
-- Versucht, für Buchangebot 1 einen neuen Zeitslot einzufügen,
-- der sich mit bereits bestehenden Zeitslots überschneidet.
-- Der Trigger "TR_Zeitslot_Ueberschneidung" lehnt das Insert-Statement ab.

INSERT INTO Zeitslot
    (datum, startzeit, endzeit, buchangebot_id)
VALUES
    ('2026-10-27', '17:30', '18:30', 1);

-- =========================================================
-- ENTITÄT: AUSLEIHE
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: MAXIMALE AUSLEIHDAUER EINHALTEN
-- Versucht, die Soll-Rückgabe einer Ausleihe über die
-- maximale Ausleihdauer des zugehörigen Buchangebots hinaus zu verlängern.
-- Trigger "TR_Ausleihe_Validierung" lehnt ab.

UPDATE Ausleihe
SET rueckgabe_soll = '2026-11-20'
WHERE ausleihe_id = 1;

-- =========================================================
-- ENTITÄT: BUCHBEWERTUNG
-- =========================================================

USE [BuchtauschDB];
GO

-- TESTFALL: BUCHBEWERTUNGEN MIT BUCHTITEL ANZEIGEN
-- Zeigt, welchem tatsächlich ausgeliehenen Buch
-- eine gespeicherte Bewertung zugeordnet ist.

SELECT
    bb.bewertung_id,
    b.titel,
    bb.sterne
FROM Buchbewertung bb
INNER JOIN Ausleihe a
    ON bb.ausleihe_id = a.ausleihe_id
INNER JOIN Buchangebot ba
    ON a.buchangebot_id = ba.buchangebot_id
INNER JOIN Buch b
    ON ba.buch_id = b.buch_id;

