from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker
from sqlalchemy import Integer, String, Column, Date, DateTime, BigInteger
from datetime import date, datetime

Base = declarative_base()


class Mangijad(Base):
    __tablename__ = "mängijad"

    id = Column(Integer, primary_key=True, autoincrement=True)
    eesnimi = Column(String(50))
    perekonnanimi = Column(String(50))
    sünniaeg = Column(Date)
    riik = Column(String(50))
    klubi = Column(String(50))
    palk = Column(BigInteger)


class Klubid(Base):
    __tablename__ = "klubid"

    id = Column(Integer, primary_key=True, autoincrement=True)
    linn = Column(String(50))
    nimi = Column(String(50))
    staadion = Column(String(100))
    treener = Column(String(100))


class Treenerid(Base):
    __tablename__ = "treenerid"

    id = Column(Integer, primary_key=True, autoincrement=True)
    eesnimi = Column(String(50))
    perekonnanimi = Column(String(50))
    sünniaeg = Column(Date)


class Mangud(Base):
    __tablename__ = "mängud"

    id = Column(Integer, primary_key=True, autoincrement=True)
    koduklubi = Column(String(50))
    võõrklubi = Column(String(50))
    tulemus = Column(String(20))
    mängu_alguseaeg = Column(DateTime)
    publiku_arv = Column(Integer)


engine = create_engine("sqlite:///jalgpall.db", echo=True)

Base.metadata.create_all(engine)

Session = sessionmaker(bind=engine)
session = Session()


# --- INSERT PLAYERS ---
players = [
    Mangijad(eesnimi='Cristiano', perekonnanimi='Ronaldo', sünniaeg=date(1985,2,5), riik='Portugal', klubi='Manchester United', palk=50000000),
    Mangijad(eesnimi='Lionel', perekonnanimi='Messi', sünniaeg=date(1987,6,24), riik='Argentina', klubi='Paris Saint-Germain', palk=45000000),
    Mangijad(eesnimi='Neymar', perekonnanimi='da Silva Santos Júnior', sünniaeg=date(1992,2,5), riik='Brazil', klubi='Paris Saint-Germain', palk=35000000),
    Mangijad(eesnimi='Kylian', perekonnanimi='Mbappé', sünniaeg=date(1998,12,20), riik='France', klubi='Paris Saint-Germain', palk=30000000),
    Mangijad(eesnimi='Kevin', perekonnanimi='De Bruyne', sünniaeg=date(1991,6,28), riik='Belgium', klubi='Manchester City', palk=25000000),
    Mangijad(eesnimi='Virgil', perekonnanimi='van Dijk', sünniaeg=date(1991,7,8), riik='Netherlands', klubi='Liverpool', palk=20000000),
    Mangijad(eesnimi='Mohamed', perekonnanimi='Salah', sünniaeg=date(1992,6,15), riik='Egypt', klubi='Liverpool', palk=22000000),
    Mangijad(eesnimi='Sadio', perekonnanimi='Mané', sünniaeg=date(1992,4,10), riik='Senegal', klubi='Liverpool', palk=18000000),
    Mangijad(eesnimi='Robert', perekonnanimi='Lewandowski', sünniaeg=date(1988,8,21), riik='Poland', klubi='Bayern Munich', palk=27000000),
    Mangijad(eesnimi='Erling', perekonnanimi='Haaland', sünniaeg=date(2000,7,21), riik='Norway', klubi='Manchester City', palk=15000000)
]

session.add_all(players)


# --- INSERT CLUBS ---
clubs = [
    Klubid(linn='Manchester', nimi='Manchester United', staadion='Old Trafford', treener='Ole Gunnar Solskjær'),
    Klubid(linn='Paris', nimi='Paris Saint-Germain', staadion='Parc des Princes', treener='Mauricio Pochettino'),
    Klubid(linn='Munich', nimi='Bayern Munich', staadion='Allianz Arena', treener='Julian Nagelsmann')
]

session.add_all(clubs)


# --- INSERT COACHES ---
coaches = [
    Treenerid(eesnimi='Ole Gunnar', perekonnanimi='Solskjær', sünniaeg=date(1973,2,26)),
    Treenerid(eesnimi='Mauricio', perekonnanimi='Pochettino', sünniaeg=date(1972,3,2)),
    Treenerid(eesnimi='Julian', perekonnanimi='Nagelsmann', sünniaeg=date(1987,7,23))
]

session.add_all(coaches)


# --- INSERT MATCHES ---
matches = [
    Mangud(
        koduklubi='Manchester United',
        võõrklubi='Paris Saint-Germain',
        tulemus='2-1',
        mängu_alguseaeg=datetime(2024,8,15,20,0,0),
        publiku_arv=75000
    ),
    Mangud(
        koduklubi='Manchester City',
        võõrklubi='Bayern Munich',
        tulemus='3-2',
        mängu_alguseaeg=datetime(2024,8,25,20,0,0),
        publiku_arv=80000
    )
]

session.add_all(matches)


session.commit()

print("Database filled successfully.")