-- create databse db_editoraa

-- use db_editora
CREATE TABLE categoria (
    idcategoria INT PRIMARY KEY,
    nome VARCHAR(100) -- O nome deve ser uma string, não um inteiro
);

CREATE TABLE livro (
    idlivro INT PRIMARY KEY,
    data_lancamento DATE, -- Data deve ser do tipo DATE
    numero_paginas INT,
    resumo TEXT, -- Resumo pode ser um texto longo
    isbn VARCHAR(20), -- ISBN é uma string
    idcategoria INT,
    FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria)
);

CREATE TABLE autor (
    idautor INT PRIMARY KEY,
    nome VARCHAR(100) -- Nome do autor como string
);


CREATE TABLE cliente (
    idcliente INT PRIMARY KEY,
    nome VARCHAR(100), -- Nome do cliente como string
    email VARCHAR(100), -- Email como string
    sexo CHAR(2),
    data_nascimento DATE NOT NULL-- Data de nascimento deve ser do tipo DATE 
);

CREATE TABLE venda (
    idvenda INT PRIMARY KEY,
    frete DECIMAL(10, 2), -- Valor do frete pode ter casas decimais
    valor DECIMAL(10, 2), -- Valor da venda pode ter casas decimais
    idcliente INT,
    FOREIGN KEY (idcliente) REFERENCES cliente(idcliente)
);

CREATE TABLE endereco (
    idendereco INT PRIMARY KEY,
    logradouro VARCHAR(255), -- Logradouro como string
    numero VARCHAR(10), -- Número pode ser uma string (incluindo letras)
    cep VARCHAR(10), -- CEP como string
    idcidade INT,
    FOREIGN KEY (idcidade) REFERENCES cidade(idcidade)
);
