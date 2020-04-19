create table Ksiazki
(
IdKsiazki int IDENTITY(1,1) primary key,
Tytul varchar(8000) not null,
Autor varchar(8000),
Wydawnictwo varchar(8000),
DataWydania date,
LiczbaWypozyczen int default 0,
LiczbaWypozyczonych int default 0,
LiczbaDostepnych int not null
)

create table Pracownicy
(
IdPracownika int IDENTITY(1,1) primary key,
Imie varchar(8000) not null,
Nazwisko varchar(8000) not null,
DataUrodzenia date check (datediff(year, DataUrodzenia, getdate()) > 18),
EMail varchar(8000) not null,
NumerTelefonu varchar(8000) not null,
DataZatrudnienia date default getdate(),
Miasto varchar(8000),
KodPocztowy int,
Ulica varchar(8000)
)

create table Czytelnicy
(
IdCzytelnika int IDENTITY(1,1) primary key,
Imie varchar(8000) not null,
Nazwisko varchar(8000) not null,
DataUrodzenia date check (datediff(year, DataUrodzenia, getdate()) > 18),
EMail varchar(8000) not null,
NumerTelefonu varchar(8000) not null,
Miasto varchar(8000),
)

create table Wypozyczenia
(
IdWypozyczenia int PRIMARY KEY,
IdCzytelnika int FOREIGN KEY REFERENCES Czytelnicy(IdCzytelnika),
IdPracownikaWydajacego int FOREIGN KEY REFERENCES Pracownicy(IdPracownika),
DataWydania date default getdate(),
IdPracownikaOdbierajacego int FOREIGN KEY REFERENCES Pracownicy(IdPracownika),
DataZwrotu date
)

create table WypozyczoneKsiazki
(
IdWypozyczenia int FOREIGN KEY REFERENCES Wypozyczenia(IdWypozyczenia),
IdKsiazki int FOREIGN KEY REFERENCES Ksiazki(IdKsiazki)
)

