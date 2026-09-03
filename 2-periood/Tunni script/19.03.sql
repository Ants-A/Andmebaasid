create database etlta24a;
use etlta24a;

select * from etlta24a.ourcustomers;

delete from etlta24a.ourcustomers where is_married is null or is_married = '';

alter table ta24abank.customer add phone varchar(64);
alter table ta24abank.customer add address2 varchar(64);
alter table ta24abank.customer add address3 varchar(64);
select distinct gender from etlta24a.ourcustomers;
alter table ta24abank.customer add gender enum('M', 'F', 'O');

start transaction;

insert into ta24abank.customer (idcode, firstname, lastname, email, customertype, phone, address2, address3, gender) 
select idkood, first_name, last_name, email,
case when type = 'TAVA' then 'BASIC'
     when type = 'KULD' then 'GOLD'
     when type = 'HÕBE' then 'SILVER'
     else 'OURS' end,
phone, address2, address3,
case when gender = 'male' then 'M'
     when gender = 'female' then 'F'
     else 'O' end
from etlta24a.ourcustomers;

commit;

delimiter //

create procedure open_current_account ()
begin
    declare id_code bigint;
    declare ac_count integer;
    declare new_account_number bigint;
    declare done boolean default false;
    declare customer_cursor cursor for select idcode from customer;
    declare continue handler for not found set done = true;

    open customer_cursor;
        read_loop: LOOP
            fetch customer_cursor into id_code;

            if done THEN
                LEAVE read_loop;
            end if;
            select count(*) into ac_count from account where customerid = id_code and accounttype = 'CURR';
            if ac_count = 0 then
            select max(accountnumber) + 1 from account into new_account_number;
                insert into account (accountnumber, customerid, accounttype) 
                values (new_account_number, id_code, 'CURR');
            end if;
        end loop;
    close customer_cursor;
end //