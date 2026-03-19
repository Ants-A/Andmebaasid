delimiter \\

create Trigger after_customer_insert
after INSERT
on customer
for each row
Begin
    insert into audit (tablename, tableid, operation, user) values
    ('Customer', new.idcode, 'INS', user()); 
End\\

delimiter;