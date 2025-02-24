# Hospital Database Management System

This repository contains the SQL schema and queries for a comprehensive hospital database management system, focused on tracking patients, medical staff, interventions, and clinical records.

## Overview

The database system manages various aspects of a hospital's operations, including:
- Patient information and medical records
- Medical staff (doctors, surgeons, residents)
- Surgical interventions and hospitalizations
- Diagnostic tests and examinations
- Pathologies and treatments

## Repository Structure

- `Pasotti_Conti_DDL.sql`: Database definition language script that creates the tables and relationships
- `Pasotti_Conti_DMLPOP.sql`: Data manipulation language script that populates the tables with sample data
- `Pasotti_Conti_DMLUPD.sql`: Examples of data manipulation operations like registering new patients and retrieving clinical records
- `Pasotti_Conti_SQL.sql`: Collection of sample queries demonstrating various SQL operations and analyses

## Database Schema

The database consists of the following main tables:

### Medical Staff
- `Medici`: Base table for all medical staff
- `Chirurghi`: Surgeons with their specializations
- `Specializzandi`: Residents with their qualifications

### Patients and Medical Records
- `Paziente`: Patient personal information
- `Ricovero`: Hospitalization records
- `CartellaClinica`: Patient clinical records
- `Intervento`: Surgical interventions
- `Patologie`: Pathologies and their status
- `Contiene`: Links pathologies to clinical records

### Examinations and Medications
- `Visita`: Patient examination data
- `Ecografia`: Ultrasound examination results
- `Farmaci`: Prescribed medications

### Other Reference Tables
- `DRG`: Diagnosis-related group classifications
- `PrendonoParte`: Tracks medical staff participation in interventions

## Usage Examples

### Adding a New Patient
```sql
INSERT INTO PAZIENTE VALUES('178','Falegname','Massimo','Troisi','Single');
```

### Viewing a Patient's Clinical Record
```sql
SELECT paziente.id_paziente, professione, nome, cognome, stato_familiare, 
       medico_int, medico_vis, medico_pt, problemi_respiratori, allergie, intolleranze
FROM Paziente JOIN CartellaClinica ON Paziente.id_Paziente = CartellaClinica.ID_Paziente
WHERE paziente.id_paziente = '123';
```

## Implementation Notes

- The database uses cascading updates for referential integrity
- Comprehensive foreign key relationships ensure data consistency
- Character varying types allow for flexible text storage
- Date fields track temporal aspects of patient care and interventions

## Requirements

- SQL-compatible database management system
- Sufficient privileges to create tables and manipulate data

## Contributors

- Matteo Pasotti
- Simone Conti
