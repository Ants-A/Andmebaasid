CREATE DATABASE forum_db;
USE forum_db;


CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE
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

    create_date DATETIME NOT NULL,

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

    create_date DATETIME NOT NULL,

    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id),

    FOREIGN KEY (parent_comment_id)
        REFERENCES comments(id)
        ON DELETE CASCADE
);