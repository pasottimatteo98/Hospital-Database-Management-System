create table Medici(
Id_medico varchar(3) primary key
);

create table Chirurghi(
Id_medico varchar(3),
CF varchar(17) primary key,
Nome varchar(20) not null,
Cognome varchar(20) not null,
mail varchar(20) ,
Specializzazione varchar(20),
DataNascita date,
foreign key(Id_medico) references Medici(Id_medico) on update cascade
);

create table Specializzandi(
ID_Medico char(3),
Abilitazione integer,
Rianimatori char(1),
Anestesisti char(1),
foreign key (Id_medico) references Medici(Id_medico) on update cascade
);

create table Patologie(
Data_Iniz_Val date,
Data_Fine_Val date , 
Nome varchar(20) not null unique,
Stato varchar(10),
primary key(Data_Iniz_Val,stato)
);

create table Paziente(
id_Paziente varchar(3) primary key,
Professione varchar(20) not null,
Nome varchar(20) not null,
Cognome varchar(20) not null,
Stato_familiare varchar(20) not null
);

create table ricovero(
Data_Inizio date, 
Data_Fine date,
Id_Paziente varchar(3), 
Medico varchar(3),
primary key(Data_Inizio, Data_Fine),
foreign key (Id_Paziente) references Paziente(id_paziente)on update cascade,
foreign key (Medico) references Medici(Id_medico) on update cascade
);

create table Intervento(
Tipo varchar(12), 
Data_Inizio date,
Data_Fine date,
ID_Paziente varchar(3),
Decesso varchar(2) ,
Complicazioni varchar(20),
Medico varchar(3) NOT NULL,
primary key(Tipo,Data_Inizio,Data_Fine),
foreign key (Medico) references Medici(Id_medico) on update cascade ,
foreign key (Data_Inizio,Data_fine) references ricovero(Data_Inizio,Data_Fine) on update cascade ,
foreign key (ID_Paziente) references Paziente(id_Paziente) on update cascade 
);

create table visita(
ID_Medico varchar(3),
ID_Paziente varchar(3),
Dolori_Add varchar(3),
Pressione_Sist integer not null,
Peso integer not null, 
Pressione_Diast integer not null,
primary key(ID_Medico,ID_Paziente),
foreign key (ID_Medico) references Medici(ID_medico)  on update cascade ,
foreign key (ID_Paziente) references Paziente(id_Paziente)  on update cascade 
);


create table CartellaClinica(
ID_Paziente varchar(3),
Medico_Int varchar(3),
Medico_Vis varchar(3),
Medico_Pt varchar(3),
Problemi_Respiratori varchar(2),
Allergie char(1),
Intolleranze varchar(1),
primary key (ID_Paziente),
foreign key (Medico_Int) references Medici(ID_Medico)  on update cascade ,
foreign key (Medico_Vis) references Medici(ID_Medico)  on update cascade ,
foreign key (Medico_Pt) references Medici (ID_Medico)  on update cascade ,
foreign key (ID_Paziente) references paziente (id_Paziente) 
);


create table contiene(
Cartella_Clinica varchar(3),
Patologie varchar(20),
foreign key (Cartella_Clinica) references CartellaClinica(ID_Paziente)  on update cascade ,
foreign key (Patologie) references Patologie(Nome)  on update cascade 
);

create table DRG(
Data_Inizio date,
Data_Fine date,
primary key(Data_Inizio,Data_Fine),
foreign key (Data_Inizio,Data_Fine) references Ricovero(Data_Inizio,Data_Fine)  on update cascade 
);

create table Ecografia(
ID_Medico varchar(3),
ID_Paziente varchar(3),
ID_ECO varchar(5) primary key,
Stato_Paz varchar(30),
N_Calcoli integer ,
Dimensione varchar(10),
Forma varchar(10),
Posizione varchar(15),
foreign key(ID_Medico) references Medici(ID_Medico)  on update cascade ,
foreign key(ID_Paziente) references Paziente(ID_Paziente)  on update cascade 
);

create table Farmaci(
Data_Prescr date,
ID_Farmaco varchar(5),
Nome varchar(20),
ID_Medico varchar(3),
ID_Paziente varchar(3),
primary key(Data_Prescr,ID_Farmaco),
foreign key(ID_Medico) references Medici(ID_Medico)  on update cascade ,
foreign key(ID_Paziente) references Paziente(ID_Paziente)  on update cascade 
);

create table PrendonoParte(
ID_Medico varchar(3),
Tipo varchar(12),
Data_Inizio date,
Data_Fine date,
foreign key (ID_Medico) references Medici(ID_Medico) on update cascade ,
foreign key (Tipo,Data_Inizio,Data_Fine) references Intervento(Tipo,Data_Inizio,Data_Fine) on update cascade 
);

