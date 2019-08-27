create database if not exists java0826;

DROP TABLE IF EXISTS java0826.user;
CREATE TABLE java0826.user (
                        id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        username varchar(20) NOT NULL,
                        password varchar(20) DEFAULT NULL,
                        name varchar(20) DEFAULT NULL,
                        email varchar(20) DEFAULT NULL,
                        type int(11) DEFAULT NULL
);

INSERT INTO java0826.user VALUES ('1', 'admin', 'admin', 'admin', 'admin@iflytek.com', '0');
INSERT INTO java0826.user VALUES ('2', 'user1', 'user1', 'user1', 'user1@iflytek.com', '1');
INSERT INTO java0826.user VALUES ('3', 'user2', 'user2', 'user2', 'user2@iflytek.com', '1');

select * from java0826.user;