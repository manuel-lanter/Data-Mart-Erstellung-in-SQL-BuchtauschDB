# BuchtauschDB

Die **BuchtauschDB** ist eine relationale Datenbank für eine lokale Buchtausch-App. Sie wurde im Rahmen des IU-Kurses **DLBDSPBDM01_D** mit Microsoft SQL Server 2022 Express umgesetzt.

Die Datenbank bildet den Prozess vom Einstellen eines Buches über das Buchangebot und die Ausleihe bis zur Rückgabe und Bewertung ab. Zusätzlich werden unter anderem Benutzende, Adressen, Autoren, Verlage, Genres, Zustände und Zeitslots verwaltet. Zentrale Geschäftsregeln werden mithilfe von Constraints, Indizes und Triggern direkt auf Datenbankebene abgesichert.

Dieses Repository enthält die Ergebnisse der Konzeptions-, Erarbeitungs-/Reflexions- und Finalisierungsphase sowie die zugehörigen SQL-Dateien zur Erstellung und Überprüfung der Datenbank.

---

## Projektinformationen

- **Projekt:** BuchtauschDB
- **Kurs:** DLBDSPBDM01_D
- **DBMS:** Microsoft SQL Server 2022 Express
- **Entwicklungsumgebung:** Windows 11 / SQL Server Management Studio 22
- **Verfasser:** Manuel Lanter
- **Stand:** 15. November 2026
- **Version:** 1.0

---

## Repository-Struktur

```text
BuchtauschDB/
│
├── 01_Konzeptionsphase/
│   └── Lanter-Manuel_14078949_DLBDSPBDM01_D_Konzeptionsphase_AB.pdf
│
├── 02_Erarbeitungs-Reflexionsphase/
│   ├── Lanter-Manuel_14078949_DLBDSPBDM01_D_Erarbeitungs-Reflexionsphase_PRKZ.pdf
│   ├── Lanter-Manuel_14078949_DLBDSPBDM01_D_Erarbeitungs-Reflexionsphase_SQL_Setup.sql
│   └── Lanter-Manuel_14078949_DLBDSPBDM01_D_Erarbeitungs-Reflexionsphase_SQL_Testfälle.sql
│
├── 03_Finalisierungsphase/
│   ├── Lanter-Manuel_14078949_DLBDSPBDM01_D_Finalisierungsphase_AB.pdf
│   ├── Lanter-Manuel_14078949_DLBDSPBDM01_D_Finalisierungsphase_BE.pdf
│   ├── Lanter-Manuel_14078949_DLBDSPBDM01_D_Finalisierungsphase_GH.pdf
│   └── Lanter-Manuel_14078949_DLBDSPBDM01_D_Finalisierungsphase_Installation_SQL.pdf
│
├── 04_SQL-Dateien/
│   ├── Lanter-Manuel_14078949_DLBDSPBDM01_D_Erarbeitungs-Reflexionsphase_SQL_Setup.sql
│   └── Lanter-Manuel_14078949_DLBDSPBDM01_D_Erarbeitungs-Reflexionsphase_SQL_Testfälle.sql
│
└── README.md
```

Die ausführbaren SQL-Dateien befinden sich zusätzlich gesammelt im Verzeichnis **`04_SQL-Dateien`**.

---

# Installationsanleitung für die Buchtausch-Datenbank mit Windows 11

**Verfasser:** Manuel Lanter  
**Datum:** 15. November 2026  
**Version:** 1.0

> Eine ausführliche Version dieser Installationsanleitung mit Screenshots befindet sich im Ordner `03_Finalisierungsphase` in der Datei `Lanter-Manuel_14078949_DLBDSPBDM01_D_Finalisierungsphase_Installation_SQL.pdf`.

## Voraussetzungen

Die Datenbank BuchtauschDB wurde für Microsoft SQL Server 2022 Express entwickelt und getestet. Bei der Verwendung eines anderen Datenbankmanagementsystems kann eine fehlerfreie Ausführung des SQL-Codes nicht gewährleistet werden, da sich Syntax, Datentypen und datenbankspezifische Funktionen unterscheiden können.

Für die nachfolgende Installation wird vorausgesetzt, dass Microsoft SQL Server 2022 Express bereits installiert ist. Die Software kann über die offizielle Microsoft-Webseite heruntergeladen werden:  
https://www.microsoft.com/de-de/download/details.aspx?id=108838

## Installationsschritte

### 1. SQL Server Management Studio 22 ausführen

### 2. Neues Abfragefenster öffnen

### 3. SQL-Code im Abfragefenster einfügen

Den gesamten Code aus der Datei mit Endung „SQL_Setup.sql“, siehe GitHub Repository, kopieren und einfügen. Untenstehender Screenshot ist nicht abschließend und zeigt exemplarisch den obersten Teil des SQL-Codes.

### 4. Button „Ausführen“ anklicken

Die Datenbank, die Tabellen sowie deren Attribute und Beziehungen werden angelegt. Jede Tabelle wird mit mindestens zehn KI-generierten Datensätzen befüllt.

### 5. Statusmeldung „Die Abfrage wurde erfolgreich ausgeführt“

### 6. Überprüfung der gesamten Datenbank im Objekt-Explorer

In der linken Leiste, dem sogenannten Objekt-Explorer, kann die angelegte Datenbank überprüft werden.

### 7. Überprüfung der Datensätze

Für die Überprüfung und Ansicht der Datensätze kann das SQL-Statement

```sql
SELECT * FROM Adresse;
```

verwendet werden. Hierbei ist darauf zu achten, dass oben links die BuchtauschDB ausgewählt ist und dass das Statement über ein neues (leeres) Abfragefenster ausgeführt wird. Die Ergebnisse werden anschließend in der Ergebniskonsole angezeigt. Dieser Vorgang kann für jede Tabelle wiederholt werden, um zu überprüfen, ob die Tabellen vollständig und korrekt mit den vorgesehenen Datensätzen befüllt wurden.

---

## Testfälle

Zur Überprüfung der implementierten Funktionen und Geschäftsregeln steht im Ordner `04_SQL-Dateien` zusätzlich die Datei

`Lanter-Manuel_14078949_DLBDSPBDM01_D_Erarbeitungs-Reflexionsphase_SQL_Testfälle.sql`

zur Verfügung.

Die Testfälle können nach erfolgreicher Erstellung der `BuchtauschDB` ausgeführt und dienen der Überprüfung ausgewählter Constraints, Indizes, Trigger und Abfragen.

---

## Weiterführende Dokumentation

Die Dokumentation der einzelnen Projektphasen befindet sich in den entsprechenden Verzeichnissen:

- **`01_Konzeptionsphase`** – Anforderungsspezifikation, Konzeption und Datenmodell
- **`02_Erarbeitungs-Reflexionsphase`** – Umsetzung, SQL-Dokumentation und Testfälle
- **`03_Finalisierungsphase`** – Abstract, Funktionsbeschreibung und Metadaten, GitHub-Verweis sowie ausführliche Installationsanleitung

Die finale Funktionsbeschreibung und die Metadaten der Datenbank befinden sich in:

`03_Finalisierungsphase/Lanter-Manuel_14078949_DLBDSPBDM01_D_Finalisierungsphase_BE.pdf`

Der Abstract zur inhaltlichen, konzeptionellen und technischen Umsetzung befindet sich in:

`03_Finalisierungsphase/Lanter-Manuel_14078949_DLBDSPBDM01_D_Finalisierungsphase_AB.pdf`
