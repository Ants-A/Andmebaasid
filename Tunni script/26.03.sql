create database ta24abank;
use ta24abank;

select sum(balance) from account;
select * from account;

start transaction;
update account set balance = balance - 5000 where accountnumber = 1000000001;
update account set balance = balance + 5000 where accountnumber = 1000000002;
commit;

create table accountbalance(
    id bigint unsigned primary key auto_increment,
    accountnumber bigint unsigned,
    balance decimal(12,2) not null,
    createdat datetime default current_timestamp not null,
    foreign key (accountnumber) references account(accountnumber)
);

create table transactions (
    id bigint unsigned primary key auto_increment,
    debitaccount bigint unsigned,
    creditaccount bigint unsigned,
    sum decimal(8,2) not null,
    description varchar(128) not null,
    referencenumber bigint unsigned not null,

    foreign key (debitaccount) references account(accountnumber),
    foreign key (creditaccount) references account(accountnumber)
);

create table log (
    id bigint unsigned primary key auto_increment,
    message varchar(512),
    createdat datetime default current_timestamp not null
);

drop trigger if exists after_account_update;

delimiter //

create trigger after_account_update
after update on account
for each row
begin
    if new.balance = old.balance then
        insert into audit (tablename, tableid, operation, user) 
        values ('Account', new.accountnumber, 'UPDATE', user());
    else 
        insert into accountbalance (accountnumber, balance) 
        values (old.accountnumber, old.balance);
    end if;
end //

drop procedure if exists transfer;

delimiter //

CREATE PROCEDURE transfer(in p_debaccount bigint, in p_creaccount bigint,
    in p_sum decimal(10,2), in p_refnumber bigint, in p_description varchar(256))
begin
    declare newbalance decimal(10,2);

    declare exit handler for sqlexception
    begin
      
      get diagnostics condition 1 @sqlstate = RETURNED_SQLSTATE,
      @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
      set @full_error = CONCAT("ERROR: ", @errno, " (", @sqlstate, ') ', @text);
      rollback;
      insert into log (message) values (@full_error);
    end;

  start transaction;
  select balance - p_sum into newbalance from account where accountnumber = p_debaccount;

  if newbalance < 0 then
	   insert into log (message) values (concat('Warning: Debit account ', p_debaccount, ' balance will be under 0: ', newbalance));
  end if; 
  
  update account set balance = balance - p_sum where accountnumber = p_debaccount;
  update account set balance = balance + p_sum where accountnumber = p_creaccount;
     
    insert into transactions (debitaccount, creditaccount, description, referencenumber, sum)
  values (p_debaccount, p_creaccount, p_description, p_refnumber, p_sum);
  
  commit;
   
end//

delimiter ;

insert into customer (idcode, firstname, lastname, email, customertype) values (12305873, 'Ants', 'Aas', 'ants.aas@techno.ee', 'Gold');
call open_current_account();
call transfer(1000000001, 12305873, 5000, 12345678901, "Transfer to Ants");
call transfer(12305873, 1000000001, 5000, 12345678920, "Return the transfer");
call transfer(1000000002, 12305873, 6000, 83929203422, "Transfer to Ants, again");


select * from accountbalance;
select * from audit;