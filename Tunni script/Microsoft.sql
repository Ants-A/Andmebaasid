create database ta24_microsoft;

use ta24_microsoft;

create schema yolo;

use schema dbo;

create table dbo.genres (
	genreid int identity(1,1) primary key,
	genrename nvarchar(100) not null unique
);

create table dbo.directors (
	directorid int identity(1,1) primary key,
	firstname nvarchar(100) not null,
	lastname nvarchar(100) not null,
	birthdate date null,
);

create table dbo.movies (
	movieid int identity(1,1) primary key,
	title nvarchar(200) not null,
	releaseyear int not null,
	genreid int not null,
	directorid int not null,
	durationminutes int null,
	constraint ck_movies_releaseyear check (releaseyear >= 1888),
	constraint ck_movies_duration check (durationminutes is null or durationminutes > 0),
	constraint fk_movies_genres foreign key (genreid)
		references dbo.genres (genreid),
	constraint fk_movies_directors foreign key (directorid)
		references dbo.directors (directorid)
);

create table dbo.actors (
	actorid int identity(1,1) primary key,
	firstname nvarchar(100) not null,
	lastname nvarchar(100) not null,
	birthdate date null
);

create table dbo.movieactors (
	movieid int not null,
	actorid int not null,
	charactername nvarchar(150) null,
	constraint pk_movieactors primary key (movieid, actorid),
	constraint fk_movieactors_movies foreign key (movieid)
		references dbo.movies (movieid)
		on delete cascade,
	constraint fk_movieactors_actors foreign key (actorid)
		references dbo.actors (actorid)
		on delete cascade
);

create table dbo.reviews (
	reviewid int identity(1,1) primary key,
	movieid int not null,
	reviewername nvarchar(120) not null,
	rating int not null,
	reviewtext nvarchar(1000) null,
	createdat datetime2 not null default sysdatetime(),
	constraint ck_reviews_rating check (rating between 1 and 10),
	constraint fk_reviews_movies foreign key (movieid)
		references dbo.movies (movieid)
		on delete cascade
);


-- data
insert into dbo.genres (genrename)
values (N'sci-fi'), (N'drama'), (N'action');

insert into dbo.directors (firstname, lastname, birthdate)
values
	(N'christopher', N'nolan', '1970-07-30'),
	(N'greta', N'gerwig', '1983-08-04');

insert into dbo.movies (title, releaseyear, genreid, directorid, durationminutes)
values
	(N'inception', 2010, 1, 1, 148),
	(N'little women', 2019, 2, 2, 135);

insert into dbo.actors (firstname, lastname, birthdate)
values
	(N'leonardo', N'dicaprio', '1974-11-11'),
	(N'timothee', N'chalamet', '1995-12-27');

insert into dbo.movieactors (movieid, actorid, charactername)
values
	(1, 1, N'cobb'),
	(2, 2, N'laurie');

insert into dbo.reviews (movieid, reviewername, rating, reviewtext)
values
	(1, N'alice', 9, N'great visuals and story.'),
	(2, N'bob', 8, N'excellent performances.');


select
	m.title,
	g.genrename,
	d.firstname + N' ' + d.lastname as director,
	a.firstname + N' ' + a.lastname as actor,
	ma.charactername
from dbo.movies as m
join dbo.genres as g on m.genreid = g.genreid
join dbo.directors as d on m.directorid = d.directorid
left join dbo.movieactors as ma on m.movieid = ma.movieid
left join dbo.actors as a on ma.actorid = a.actorid
order by m.movieid;

