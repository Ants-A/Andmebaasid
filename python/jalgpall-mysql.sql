mängijad (eesnimi, perekonnanimi, sünniaeg, riik, klubi, palk)
klubid (linn, nimi, staadion, treener)
treenerid (eesnimi, perekonnanimi, sünniaeg)
mängud (koduklubi, võõrklubi, tulemus, mängu alguseaeg, publiku arv)

create DATABASE jalgpall;
use jalgpall;

create table mängijad (
    id int auto_increment primary key,
    eesnimi varchar(50),
    perekonnanimi varchar(50),
    sünniaeg date,
    riik varchar(50),
    klubi varchar(50),
    palk bigint
);

create table klubid (
    id int auto_increment primary key,
    linn varchar(50),
    nimi varchar(50),
    staadion varchar(100),
    treener varchar(100)
);

create table treenerid (
    id int auto_increment primary key,
    eesnimi varchar(50),
    perekonnanimi varchar(50),
    sünniaeg date
);

create table mängud (
    id int auto_increment primary key,
    koduklubi varchar(50),
    võõrklubi varchar(50),
    tulemus varchar(20),
    mängu_alguseaeg datetime,
    publiku_arv int
);

insert into mängijad (eesnimi, perekonnanimi, sünniaeg, riik, klubi, palk) values
('Cristiano', 'Ronaldo', '1985-02-05', 'Portugal', 'Manchester United', 50000000),
('Lionel', 'Messi', '1987-06-24', 'Argentina', 'Paris Saint-Germain', 45000000),
('Neymar', 'da Silva Santos Júnior', '1992-02-05', 'Brazil', 'Paris Saint-Germain', 35000000),
('Kylian', 'Mbappé', '1998-12-20', 'France', 'Paris Saint-Germain', 30000000),
('Kevin', 'De Bruyne', '1991-06-28', 'Belgium', 'Manchester City', 25000000),
('Virgil', 'van Dijk', '1991-07-08', 'Netherlands', 'Liverpool', 20000000),
('Mohamed', 'Salah', '1992-06-15', 'Egypt', 'Liverpool', 22000000),
('Sadio', 'Mané', '1992-04-10', 'Senegal', 'Liverpool', 18000000),
('Robert', 'Lewandowski', '1988-08-21', 'Poland', 'Bayern Munich', 27000000),
('Erling', 'Haaland', '2000-07-21', 'Norway', 'Manchester City', 15000000);

insert into klubid (linn, nimi, staadion, treener) values
('Manchester', 'Manchester United', 'Old Trafford', 'Ole Gunnar Solskjær'),
('Paris', 'Paris Saint-Germain', 'Parc des Princes', 'Mauricio Pochettino'),
('Munich', 'Bayern Munich', 'Allianz Arena', 'Julian Nagelsmann');

insert into treenerid (eesnimi, perekonnanimi, sünniaeg) values
('Ole Gunnar', 'Solskjær', '1973-02-26'),
('Mauricio', 'Pochettino', '1972-03-02'),
('Julian', 'Nagelsmann', '1987-07-23');

insert into mängud (koduklubi, võõrklubi, tulemus, mängu_alguseaeg, publiku_arv) values
('Manchester United', 'Paris Saint-Germain', '2-1', '2024-08-15 20:00:00', 75000),
('Manchester City', 'Bayern Munich', '3-2', '2024-08-25 20:00:00', 80000);