use ta24abank;

create table kuupaevad (
    id bigint unsigned primary key auto_increment,
    bdate date not null,
    bh enum ('B', 'H') not null
);

DELIMITER //

CREATE PROCEDURE FillYearDatesExtended(IN target_year INT)
BEGIN
    -- Define the start and end of the year
    SET @start_date = STR_TO_DATE(CONCAT(target_year, '-01-01'), '%Y-%m-%d');
    SET @end_date = STR_TO_DATE(CONCAT(target_year, '-12-31'), '%Y-%m-%d');

    INSERT INTO kuupaevad (bdate, bh)
    WITH RECURSIVE dates AS (
        SELECT @start_date AS dt
        UNION ALL
        SELECT dt + INTERVAL 1 DAY
        FROM dates
        WHERE dt < @end_date
    )
    SELECT 
        dt, 
        CASE 
            -- 1. Weekends (Sunday=1, Saturday=7)
            WHEN DAYOFWEEK(dt) IN (1, 7) THEN 'H'
            
            -- 2. Fixed Estonian Public Holidays
            WHEN DATE_FORMAT(dt, '%m-%d') IN (
                '01-01', -- Uus aasta
                '02-24', -- Eesti sünnipäev
                '05-01', -- May Day
                '12-24', -- Christmas Eve
                '12-25', -- Christmas Day
                '12-31'  -- Vana aasta õhtu
            ) THEN 'H'
            
            -- Default to Business Day
            ELSE 'B'
        END
    FROM dates;
END //

call `FillYearDatesExtended`(2026);


-- Loome seadistuste tabeli
CREATE TABLE config (
    cfg_key VARCHAR(50) PRIMARY KEY,
    datevalue DATE,
    datenum INT,
    datechar VARCHAR(255)
);

-- Sisestame algandmed
INSERT INTO config (cfg_key, datevalue) VALUES ('KP', '2026-02-23');
INSERT INTO config (cfg_key, datechar) VALUES ('Name', 'Antsu Pank');
INSERT INTO config (cfg_key, datenum) VALUES ('Pangakood', 69);

DELIMITER //

CREATE PROCEDURE MoveToNextBusinessDay()
BEGIN
    DECLARE current_kp DATE;
    DECLARE next_kp DATE;

    -- 1. Leiame praeguse panga kuupäeva
    SELECT datevalue INTO current_kp 
    FROM config 
    WHERE cfg_key = 'KP';

    -- 2. Leiame tabelist kuupaevad järgmise päeva, mis on Business Day ('B')
    SELECT MIN(bdate) INTO next_kp 
    FROM kuupaevad 
    WHERE bdate > current_kp AND bh = 'B';

    -- 3. Kui leidsime uue päeva, siis uuendame konfigu
    IF next_kp IS NOT NULL THEN
        UPDATE config 
        SET datevalue = next_kp 
        WHERE cfg_key = 'KP';
        
        SELECT CONCAT('Pangapäev nihutatud: ', next_kp) AS Tulemus;
    ELSE
        SELECT 'Viga: Järgmist tööpäeva ei leitud (tabel kuupaevad on tühi või aegunud)!' AS Tulemus;
    END IF;
END //