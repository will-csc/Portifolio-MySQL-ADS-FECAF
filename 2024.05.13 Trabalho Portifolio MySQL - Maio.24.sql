-- CRIAÇÃO BANCO DE DADOS
DROP DATABASE IF EXISTS show_artistas;
CREATE DATABASE IF NOT EXISTS show_artistas;
USE show_artistas;

/*---------- CRIAÇÃO TABLEA INGRESSOS E INSERÇÃO DE DADOS -------------------*/
CREATE TABLE IF NOT EXISTS tbl_ingressos( /*Tabela de ingressos */
	id_ingresso INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    local_ingresso VARCHAR(100) NOT NULL,
    setor_ingresso VARCHAR(100) NOT NULL,
    preco_ingresso INT NOT NULL
);
INSERT INTO tbl_ingressos(local_ingresso,setor_ingresso,preco_ingresso) VALUES
("Morumbis","Arquibancada",390),
("Marcanã","Pista",650),
("Morumbis","Pista Premium",1500),
("Allianz Parque","Arquibancada",450),
("Allianz Parque","Pista",890),
("Allianz Parque","Pista Premium",1800);

/*---------- CRIAÇÃO TABELA ARTISTAS E INSERÇÃO DE DADOS -------------------*/
CREATE TABLE IF NOT EXISTS tbl_artistas( /*Tabela de artistas */
	id_artista INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_artista VARCHAR(100) NOT NULL,
    cpf_artista VARCHAR(11) NOT NULL UNIQUE,
    banda_artista BOOLEAN DEFAULT FALSE    
);
INSERT INTO tbl_artistas(nome_artista,cpf_artista,banda_artista) VALUES
("Bruno Mars",55084943836,FALSE),
("Belo",36592452011,FALSE),
("Luisa Sonsa",35588852011,FALSE),
("Radiohead",96588852881,TRUE),
("Chitãozinho e Chororo",96587456881,TRUE);

/*---------- CRIAÇÃO TABELA SHOWS E INSERÇÃO DE DADOS -------------------*/
CREATE TABLE IF NOT EXISTS tbl_shows_artistas( /*Tabela de shows */
	id_show INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    data_show DATE NOT NULL,
    artista_id_fk INT NOT NULL, -- FK
    ingresso_id_fk INT NOT NULL, -- FK
    CONSTRAINT fk_nome_artista FOREIGN KEY (artista_id_fk) REFERENCES tbl_artistas(id_artista),
    CONSTRAINT fk_ingresso_id FOREIGN KEY (ingresso_id_fk) REFERENCES tbl_ingressos(id_ingresso)
);
INSERT INTO tbl_shows_artistas 
(data_show,artista_id_fk/*fk*/,ingresso_id_fk/*fk*/) VALUES
("2024-01-10",2,4),
("2026-04-15",5,3),
("2030-12-19",1,3),
("2025-10-29",4,2),
("2037-05-01",1,1);

/*--------------- SELECIONA TODOS OS LOCAIS E SETORES COM SHOWS --------------*/
SELECT shows.data_show,
		ingressos.local_ingresso,
		ingressos.setor_ingresso
FROM tbl_shows_artistas AS shows
INNER JOIN tbl_ingressos AS ingressos
ON shows.ingresso_id_fk = ingressos.id_ingresso;

/*------------- SELECIONA TODOS OS SHOWS E PREÇOS --------------*/
SELECT  artistas.nome_artista,
		shows.data_show,
        ingressos.local_ingresso,
        ingressos.preco_ingresso,
        ingressos.setor_ingresso
FROM tbl_shows_artistas AS shows 
INNER JOIN tbl_artistas AS artistas
INNER JOIN tbl_ingressos AS ingressos
ON shows.artista_id_fk = artistas.id_artista 
AND ingressos.id_ingresso = shows.ingresso_id_fk

