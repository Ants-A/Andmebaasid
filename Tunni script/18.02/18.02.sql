DROP DATABASE IF EXISTS ta24abank;
CREATE DATABASE ta24abank;
USE ta24abank;

CREATE TABLE customertype(
    type CHAR(6) PRIMARY KEY,
    description VARCHAR(64) NOT NULL
);

CREATE TABLE customer (
    idcode BIGINT UNSIGNED PRIMARY KEY,
    firstname VARCHAR(64) NOT NULL,
    lastname VARCHAR(64) NOT NULL,
    address VARCHAR(255),
    email VARCHAR(64) UNIQUE NOT NULL,
    customertype CHAR(6),
    FOREIGN KEY (customertype) REFERENCES customertype(type)
);

CREATE TABLE audit (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tablename VARCHAR(32),
    tableid VARCHAR(32),
    operation CHAR(3),
    user VARCHAR(64),
    audittime DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE accounttype (
    type CHAR(6) PRIMARY KEY,
    description VARCHAR(64) NOT NULL
);

CREATE TABLE account (
    accountnumber BIGINT UNSIGNED PRIMARY KEY,
    customerid BIGINT UNSIGNED NOT NULL,
    accounttype CHAR(6) NOT NULL,
    currency CHAR(3) DEFAULT 'EUR' NOT NULL,
    balance DECIMAL(12,2) DEFAULT 0 NOT NULL,
    interestrate DECIMAL(5,5) DEFAULT 0 NOT NULL,
    FOREIGN KEY (accounttype) REFERENCES accounttype(type),
    FOREIGN KEY (customerid) REFERENCES customer(idcode)
);

INSERT INTO customertype VALUES
('BASIC', 'Tavaklient'),
('GOLD', 'Kuldklient'),
('SILVER', 'Hõbeklient'),
('OURS', 'Sisemine konto');

INSERT INTO accounttype VALUES
('CURR', 'Arveldusarve'),
('EQUITY', 'Omakapital'),
('CASH', 'Sularaha'),
('HLOAN', 'Kodulaen');

DELIMITER //

CREATE TRIGGER after_customer_insert
AFTER INSERT ON customer
FOR EACH ROW
BEGIN
    INSERT INTO audit(tablename, tableid, operation, user)
    VALUES('CUSTOMER', NEW.idcode, 'INS', USER());
END//

CREATE TRIGGER after_customer_update
AFTER UPDATE ON customer
FOR EACH ROW
BEGIN
    INSERT INTO audit(tablename, tableid, operation, user)
    VALUES('CUSTOMER', NEW.idcode, 'UPD', USER());
END//

CREATE TRIGGER after_customer_delete
AFTER DELETE ON customer
FOR EACH ROW
BEGIN
    INSERT INTO audit(tablename, tableid, operation, user)
    VALUES('CUSTOMER', OLD.idcode, 'DEL', USER());
END//

CREATE TRIGGER after_account_insert
AFTER INSERT ON account
FOR EACH ROW
BEGIN
    INSERT INTO audit(tablename, tableid, operation, user)
    VALUES('ACCOUNT', NEW.accountnumber, 'INS', USER());
END//

CREATE TRIGGER after_account_update
AFTER UPDATE ON account
FOR EACH ROW
BEGIN
    INSERT INTO audit(tablename, tableid, operation, user)
    VALUES('ACCOUNT', NEW.accountnumber, 'UPD', USER());
END//

CREATE TRIGGER after_account_delete
AFTER DELETE ON account
FOR EACH ROW
BEGIN
    INSERT INTO audit(tablename, tableid, operation, user)
    VALUES('ACCOUNT', OLD.accountnumber, 'DEL', USER());
END//

DELIMITER ;

INSERT INTO customer VALUES
(1000, 'Meie', 'Pank', 'Pärnu mnt', 'meie@pank.ee', 'OURS'),
(2000, 'Kaspar', 'Tahker', 'Tallinn', 'kaspar@eesti.ee', 'BASIC'),
(3000, 'Ants', 'Jaanus', 'Tartu', 'ants@eesti.ee', 'SILVER'),
(4000, 'Jan', 'Pärli', 'Pärnu', 'jan@eesti.ee', 'GOLD'),
(5000, 'Rainer', 'Erlenhein', 'Narva', 'rainer@eesti.ee', 'BASIC');

UPDATE customer
SET address = 'Tartu mnt 69'
WHERE idcode = 2000;

DELETE FROM customer
WHERE idcode = 5000;

INSERT INTO account VALUES
(100000, 1000, 'EQUITY', 'EUR', 10000000, 0),
(100001, 1000, 'CASH', 'EUR', -10000000, 0);

DELIMITER //

CREATE PROCEDURE open_current_account()
BEGIN
    DECLARE id_code BIGINT UNSIGNED;
    DECLARE newaccountnumber BIGINT UNSIGNED;
    DECLARE counted INT;
    DECLARE done BOOLEAN DEFAULT FALSE;

    DECLARE cur CURSOR FOR SELECT idcode FROM customer;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO id_code;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT COUNT(*) INTO counted
        FROM account
        WHERE customerid = id_code
        AND accounttype = 'CURR';

        IF counted = 0 THEN
            SELECT IFNULL(MAX(accountnumber), 100000) + 1
            INTO newaccountnumber
            FROM account;

            INSERT INTO account(accountnumber, customerid, accounttype, balance)
            VALUES(newaccountnumber, id_code, 'CURR', 0.00);
        END IF;

    END LOOP;

    CLOSE cur;
END//

DELIMITER ;

CALL open_current_account();

SELECT * FROM customer;
SELECT * FROM account;
SELECT * FROM audit;
SELECT SUM(balance) FROM account;