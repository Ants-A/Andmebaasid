start transaction;

update world.country set Headofstate = 'William-Aleksander' where Headofstate = 'Beatrix';

select name, HeadOfState from world.country where Headofstate in ('William-Aleksander', 'Beatrix');

rollback; #kui tahad tagasi
commit; #kui see sobib

select count(*) arv, Headofstate from world.country
group by Headofstate order by arv desc;