--Es1
/*Elencare, per ogni città, la nazione in cui si trova. Il risultato deve contenere la città e il nome della
nazione e essere ordinato lessicograficamente per città*/
 
/*
Dopo aver guardato lo schema relazionale, abbiamo potuto constatare che le informazioni necessarie da prendere per questa query 
sono nella tabella city, e sono gli attributi name (nome della città) e country (codice del paese dove si trova). Name è chiave 
primaria, mentre country chiave esterna, entrambe non accettano valori nulli.
*/

select city.name, city.country
from city
order by name


--Es 2
--Elencare le città attraversate da un fiume (il risultato deve contenere soltanto la città)

/*
Dopo aver guardato lo schema relazionale, abbiamo potuto constatare che le informazioni necessarie da prendere per questa query 
sono nella tabella located, dove dobbiamo prendere l'attributo city, che è chiave esterna verso la tabella city con l'attributo
name. il risultato non mostra le città che hanno valore NULL nei fiumi, essendo la richiesta dell'esercizio, e non mostra i valori 
duplicati
*/
select distinct located.city
from located
where located.river is not NULL

--Es3
/*Elencare le città con un nome che comprende la lettera y in qualsiasi posizione (il risultato deve
contenere il nome della città e il nome del paese e essere ordinato per paese e città).
*/
/*
Dopo aver guardato lo schema relazione abbiamo potuto constatare che le informazioni necessarie per questa query si trovano 
nella tabella city, prendendo gli attributi name, che è chiave primaria, e country che è chiave esterna verso la tabella country
con l'attributo code. il risultato non mostra le città il cui nome nel database non è presente (avendo il valore null).
*/
select city.name, city.country
from city
where city.name LIKE '%y%'

--Es4
/*Elencare le città che si trovano nei circoli polari artico e antartico, cioè oltre 66 gradi di latitudine
nord e sud (il risultato deve contenere le città e la loro latitudine).
*/

/*
Dopo aver guardato lo schema relazione abbiamo potuto constatare che le informazioni necessarie per questa query si trovano 
nella tabella città, prendendo gli attributi name che è chiave primaria, e latitude, che fa parte dell'attributo composto coordinates
presente in city nello schema relazione. il risultato non mostra i valori NULL.
*/

select city.name, city.latitude
from city
where city.latitude >=66 or city.latitude<=-66

--Es5
/*
Elencare le nazioni che confinano con l'Italia (il risultato deve comprendere soltanto il nome delle
nazioni).
*/

/*
Dopo aver guardato lo schema relazione abbiamo potuto constatare che le informazioni necessarie per questa query si trovano 
nella tabella country, unita con un join alla tabella borders. mostriamo soltanto l'attributo name di country. Il risultato mostra 
i paesi confinanti con l'italia, e non mostra eventuali valori nulli.
*/

select country.name
from country join borders b on b.country2=country.code or b.country1=country.code
where (b.country1='I' or b.country2='I') and NOT (country.name='Italy')

--Es6
/*
Trovare la capitale con più abitanti tra tutte le capitali (il risultato deve contenere il nome della
capitale e la sua popolazione) (scrivere due versioni della query con e senza operatore aggregato
MAX).
*/
/*
Dopo aver guardato lo schema relazione abbiamo potuto constatare che le informazioni necessarie per questa query si trovano 
nella tabella country. gli attributi mostrati sono name e population. il risultato non mostra valori nulli o duplicati. nella prima 
versione abbiamo creato una sottoquery che restituiva il massimo della popolazione della tabella utilizzando l'operatore aggregato max, di cui poi usavamo il 
valore per mostrare il paese. nella seconda versione invece usiamo un left join con country stessa, in cui mettiamo a null il valori della popolazione
della città più grande, di cui prendiamo il nome.
*/
select country.name, country.population		
from country
where country.population=
(select max(c.population)
from country c)
group by country.name, country.population

select c1.name, c1.population
from country c1
left join country c2
on c2.population > c1.population
where c2.population is NULL

--Es7
/*
Per ogni città statunitense estrarre la sua popolazione e la superficie dei laghi su cui eventualmente
si affaccia (il risultato deve comprendere la città, la popolazione e l'area complessiva dei suoi laghi)
(scrivere due versioni della query).
*/

/*
Dopo aver guardato lo schema relazione abbiamo potuto constatare che le informazioni necessarie per questa query si trovano 
nelle tabelle city, located, lake. mostriamo gli attributi city.name,city.population, e la somma delle aeree dei laghi per ogni 
città. city.name è chiave primaria di city. il risultato non mostra i valori null, e valori duplicati.
*/
select city.name, city.population, sum(lake.area)
from city inner join located on city.name=located.city
inner join lake on lake.name=located.lake
where city.country='USA'
group by city.name,city.population


select city.name, city.population, sum(lake.area)
from located,lake,city
where city.country='USA' and located.city=city.name and located.lake=lake.name
group by city.name,city.population


/*
Es8
Ricavare la seconda isola per estensione nel mondo (il risultato deve comprendere il nome dell'isola
e la sua area) (scrivere due versioni della query).
*/

/*
Dopo aver guardato lo schema relazione abbiamo potuto constatare che le informazioni necessarie per questa query si trovano 
nella tabella island, e mostriamo gli attributi name che è la sua chiave primaria, e l'area. il risultato non mostra valori nulli o duplicati.
per risolvere la query abbiamo usato due sottoquery per ogni versione, quella più interna restituisce l'area massima, quella intermedia prende la seconda
area a livello di grandezza, basandosi sul risultato di quella precedente, e la query esterna prende l'isola. nella prima versione usiamo l'operatore '<' 
mentre nella seconda usiamo not in.
*/

select island.name,island.area
from island
where island.area=
(select max(island.area)
from island
where island.area < (
select max(island.area)
from island
)
)

select island.name,island.area
from island
where island.area=(
SELECT MAX(island.area) 
FROM island 
WHERE island.area NOT IN 
	(SELECT MAX(island.area) 
	 FROM island))
