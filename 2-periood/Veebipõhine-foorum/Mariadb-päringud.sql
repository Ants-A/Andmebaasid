-- PÄRING 1: Leia kõik postitused, mis kuuluvad "games" kategooriasse
SELECT p.*
FROM posts p
JOIN subjects s ON p.subject_id = s.id
WHERE s.name = 'Games';

-- PÄRING 2: Leia postitused, millel on rohkem kui 50 häält (votes)
SELECT *
FROM posts
WHERE votes > 50;

-- PÄRING 3: Leia postitused, mis on moderaatori poolt märgitud ebasobivaks
SELECT *
FROM posts
WHERE visible = FALSE;

-- PÄRING 4: Sorteeri postitused uuemate põhiselt
SELECT *
FROM posts
ORDER BY create_date DESC;

-- PÄRING 5: Leia kasutaja, kelle kasutajanimi on "gamer_pro"
SELECT *
FROM users
WHERE username = 'gamer_pro';

-- PÄRING 6: Leia kõik moderaatori rolliga kasutajad
SELECT *
FROM users
WHERE admin = TRUE;