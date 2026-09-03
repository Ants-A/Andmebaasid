CREATE DATABASE forum_db;
USE forum_db;


CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    admin BOOLEAN DEFAULT FALSE
);


CREATE TABLE subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT NOT NULL,
    user_id INT NOT NULL,

    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,

    votes INT DEFAULT 0,

    create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    visible BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (subject_id) REFERENCES subjects(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


-- Replies are just comments with a parent_comment_id
CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,

    post_id INT NOT NULL,
    user_id INT NOT NULL,

    parent_comment_id INT NULL,

    content TEXT NOT NULL,

    votes INT DEFAULT 0,

    create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    mod_post BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id),

    FOREIGN KEY (parent_comment_id)
        REFERENCES comments(id)
        ON DELETE CASCADE
);


INSERT INTO users (id, username, admin) VALUES
    (1, 'mari', TRUE),
    (2, 'tarmo', FALSE),
    (3, 'kristjan', FALSE),
    (4, 'liis', FALSE),
    (5, 'andre', FALSE),
    (6, 'helena', FALSE);


INSERT INTO subjects (id, name) VALUES
    (1, 'General'),
    (2, 'Programming'),
    (3, 'Databases'),
    (4, 'School'),
    (5, 'Games'),
    (6, 'Off topic');


INSERT INTO posts (id, subject_id, user_id, title, content, votes, create_date, visible) VALUES
    (1, 2, 1, 'Best practices for SQL joins', 'What are the most important rules for writing clear and efficient SQL joins?', 8, '2026-05-20 10:15:00', TRUE),
    (2, 3, 2, 'Normalizing forum data', 'Should this forum keep posts and comments in separate tables or combine them?', 5, '2026-05-20 12:30:00', TRUE),
    (3, 4, 3, 'Study group for database course', 'Looking for classmates who want to review joins, indexes, and keys together.', 3, '2026-05-21 09:00:00', TRUE),
    (4, 5, 4, 'Favorite multiplayer games', 'Share the games you keep coming back to with friends.', 12, '2026-05-21 18:45:00', TRUE),
    (5, 1, 5, 'Forum rules suggestion', 'A short pinned post about respectful discussion would help new users.', 4, '2026-05-22 08:20:00', TRUE),
    (6, 6, 6, 'Weekend plans', 'No technical topic here, just a place to test the general discussion board.', 1, '2026-05-22 20:10:00', TRUE);


INSERT INTO comments (id, post_id, user_id, parent_comment_id, content, votes, create_date, mod_post) VALUES
    (1, 1, 2, NULL, 'Start with the smallest tables and add indexes only where the query plan needs them.', 2, '2026-05-20 11:00:00', FALSE),
    (2, 1, 3, 1, 'That is a good rule. It also helps to alias every table consistently.', 1, '2026-05-20 11:15:00', FALSE),
    (3, 2, 4, NULL, 'Separate tables make moderation and querying much easier in this case.', 4, '2026-05-20 13:00:00', FALSE),
    (4, 3, 5, NULL, 'I can join the study group. Monday afternoon works for me.', 3, '2026-05-21 10:10:00', FALSE),
    (5, 4, 6, NULL, 'I keep returning to co-op games because they are easy to play in short sessions.', 5, '2026-05-21 19:10:00', FALSE),
    (6, 5, 1, NULL, 'Pinned rules are useful as long as they stay short and readable.', 2, '2026-05-22 09:00:00', TRUE);



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

