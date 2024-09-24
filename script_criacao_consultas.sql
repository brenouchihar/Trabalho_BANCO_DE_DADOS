/* 01 selecionando idlivro, resumo onde ano seja maior ou igual a 2000*/
SELECT idlivro, resumo, EXTRACT(YEAR FROM data_lancamento) AS ano 
FROM livro
WHERE EXTRACT(YEAR FROM data_lancamento) >= 2000;

/*  02 selecionando resumo, numero_paginas, nome da categoria*/

SELECT l.resumo, l.numero_paginas, cat.nome AS categoria
FROM categoria cat
LEFT JOIN livro l ON cat.idcategoria = l.idcategoria
WHERE cat.nome IN ( 'Aventura','Drama','Filosofia');


/* 03 quantidade de cliente por sexo*/ 
SELECT sexo, count(*) as quantidade FROM cliente
GROUP BY sexo;

/* listas os 5 livros mais vendidos*/

SELECT 
    l.idlivro, 
    l.isbn, 
    l.resumo, 
    SUM(iv.quantidade) AS total_vendido
FROM livro l
JOIN item_venda iv ON l.idlivro = iv.idlivro
GROUP BY l.idlivro
ORDER BY total_vendido DESC
LIMIT 5;

/* clientes que gastaram mais em compras*/
SELECT c.idcliente, c.nome, c.email, 
    SUM(v.valor + v.frete) AS total_gasto
FROM cliente c
JOIN venda v ON c.idcliente = v.idcliente
GROUP BY c.idcliente
ORDER BY total_gasto DESC
LIMIT 10;

/* média de valor gasto por cliente, por estado*/
SELECT 
    est.nome AS estado, 
  CONCAT('R$ ', ROUND(AVG(v.valor + v.frete), 2)) AS media_valor_gasto
FROM 
    cliente c
JOIN cliente_end ce ON c.idcliente = ce.idcliente
JOIN endereco e ON ce.idendereco = e.idendereco
JOIN cidade cid ON e.idcidade = cid.idcidade
JOIN estado est ON cid.idestado = est.idestado
JOIN venda v ON c.idcliente = v.idcliente
GROUP BY est.nome
ORDER BY media_valor_gasto DESC;

/* livros lançados nos últimos 12 meses*/

SELECT 
    l.idlivro, 
    l.isbn, 
    l.resumo, 
    l.data_lancamento
FROM livro l
WHERE l.data_lancamento >= CURDATE() - INTERVAL 12 MONTH
ORDER BY l.data_lancamento DESC;

/* livros vendidos por categoria*/
SELECT 
    cat.nome AS categoria, 
    SUM(iv.quantidade) AS total_vendido
FROM livro l
JOIN item_venda iv ON l.idlivro = iv.idlivro
JOIN categoria cat ON l.idcategoria = cat.idcategoria
GROUP BY cat.nome
ORDER BY total_vendido DESC;

/*selecionando nome, data_nascimento, sexo e calculando a idade*/
SELECT 
    nome,
    data_nascimento,
    sexo,
    TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade
FROM 
    cliente;
    
    
/* total de cliente por estado */
SELECT 
    es.nome AS estado, 
    COUNT(DISTINCT c.idcliente) AS total_clientes
FROM cliente c
JOIN cliente_end ce ON c.idcliente = ce.idcliente
JOIN endereco e ON ce.idendereco = e.idendereco
JOIN cidade ci ON e.idcidade = ci.idcidade
JOIN estado es ON ci.idestado = es.idestado
GROUP BY es.nome
ORDER BY total_clientes DESC;

/* total de venda por cliente**/

SELECT c.nome,
    CONCAT('R$', ROUND(SUM(iv.quantidade * v.valor) + SUM(v.frete),2)) AS total_por_cliente
FROM venda v
JOIN item_venda iv ON v.idvenda = iv.idvenda
JOIN cliente c ON v.idcliente = c.idcliente
GROUP BY  c.nome
ORDER BY total_por_cliente DESC;

/* detalhe do cliente que comrpou mais livros*/
SELECT 
    c.idcliente, 
    c.nome, 
    c.email, 
    SUM(iv.quantidade) AS total_livros_comprados
FROM cliente c
JOIN venda v ON c.idcliente = v.idcliente
JOIN item_venda iv ON v.idvenda = iv.idvenda
GROUP BY c.idcliente
ORDER BY total_livros_comprados DESC
LIMIT 1;

/* consulta com detalhes de estado e  cidade*/
SELECT 
    c.idcliente, 
    c.nome, 
    c.email, 
    SUM(iv.quantidade) AS total_livros_comprados,
    cid.nome AS cidade,
    est.nome AS estado
FROM cliente c
JOIN venda v ON c.idcliente = v.idcliente
JOIN item_venda iv ON v.idvenda = iv.idvenda
JOIN cliente_end ce ON c.idcliente = ce.idcliente
JOIN endereco e ON ce.idendereco = e.idendereco
JOIN cidade cid ON e.idcidade = cid.idcidade
JOIN estado est ON cid.idestado = est.idestado
GROUP BY c.idcliente, cid.nome, est.nome
ORDER BY total_livros_comprados DESC
LIMIT 1;







/* total de livros por categoria*/

SELECT c.nome AS categoria, COUNT(l.idlivro) AS total_livros
FROM categoria c
LEFT JOIN livro l ON c.idcategoria = l.idcategoria
GROUP BY c.nome;













