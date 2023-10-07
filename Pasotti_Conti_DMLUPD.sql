/*
REGISTRAZIONE NUOVO PAZIENTE
*/

INSERT INTO PAZIENTE VALUES('178','Falegname','Massimo','Troisi','Single');

/*
Visualizzare la cartella clinica di un paziente
esempio con paziente 123
*/

select paziente.id_paziente,professione,nome,cognome,stato_familiare,medico_int,medico_vis,medico_pt,problemi_respiratori,allergie,intolleranze
from Paziente join CartellaClinica on Paziente.id_Paziente=CartellaClinica.ID_Paziente
where paziente.id_paziente='123';