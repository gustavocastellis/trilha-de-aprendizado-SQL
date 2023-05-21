/* COLLATION

O que é?
O COLLATION nos permite configurar se teremos diferenciação entre maiúsculas e minúsculas, ou entre palavras acentuadas.

O COLLATION pode ser definido em níveis diferentes no SQL Server. Abaixo estão os três níveis:
1. A nível SQL Server
2. A nível de Bancos de Dados
3. A nível de tabelas/colunas

1. A nível SQL Server
O COLLATION a princípio é definido durante a instalação do programa.
Por padrão, o COLLATION padrão é o seguinte:
Latin1_General_CI_AS
Onde CI significa Case Insensitive (não diferencia maiúsculas de minúsculas) e AS significa Accent Sensitive (sensível ao sotaque).
Para descobrir o COLLATION configurado, podemos utilizar o comando abaixo:*/

SELECT SERVERPROPERTY('collation')


/*2. A nível de Banco de Dados
Por padrão, todos os bancos de dados vão herdar a configuração do COLLATION do SQL Server feito durante a instalação.
Em Propriedades, conseguimos visualizar o COLLATION configurado.

Nós podemos também especificar o COLLATION do Banco de Dados no momento da sua criação.*/

CREATE DATABASE BD_Collation
COLLATE Latin1_General_CS_AS

/*Podemos também alterar o COLLATE após criar um banco de dados. Neste caso, usamos o comando abaixo:*/

ALTER DATABASE BD_Collation COLLATE Latin1_General_CI_AS

/*Para saber o COLLATION de um Banco de Dados específico, podemos usar o comando abaixo:*/

SELECT DATABASEPROPERTYEX('BD_Collation','collation')

/*3. A nível de Coluna/Tabela
Por padrão, uma nova coluna de tipo VARCHAR herda o COLLATION do banco de dados, a menos que você especifique o COLLATION explicitamente ao criar a tabela.
Para criar uma coluna com um COLLATION diferente, você pode especificar o agrupamento usando o comando Collate SQL.*/

CREATE TABLE Nomes(
ID INT,
Nome1 VARCHAR(100),
Nome2 VARCHAR(100) COLLATE Latin1_General_CS_AS)



/*Podemos ver o COLLATION de cada coluna da tabela usando o comando abaixo:*/

sp_help Nomes

-- COLLATE: Exemplo

CREATE DATABASE BD_Collation
COLLATE SQL_Latin1_General_CP1_CI_AS


CREATE TABLE Tabela(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)



INSERT INTO Tabela(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

SELECT * FROM Tabela
WHERE Nome = 'Marcela'



-- LIKE: Case sensitive

CREATE TABLE Nomes(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Nomes(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

-- Case Sensitive (diferenciando maiúsculas de minúsculas
-- LIKE padrão como aprendemos até agora:
SELECT *
FROM Nomes
WHERE Nome LIKE 'mar%'

-- Retorna as linhas onde a primeira letra seja 'm', a segunda seja 'a' e a terceira seja 'r'
SELECT *
FROM Nomes
WHERE Nome LIKE '[m][a][r]%'

-- Retorna as linhas onde a primeira letra seja [M], a segunda seja 'a' e a terceira seja 'r'
SELECT *
FROM Nomes
WHERE Nome LIKE '[M][a][r]%'

-- Retorna as linhas onde a primeira letra seja 'M' ou 'm', e a segunda seja 'A' ou 'a'
SELECT *
FROM Nomes
WHERE Nome LIKE '[M-m][A-a]%'



-- LIKE: Filtrando os primeiros caracteres + Case sensitive
USE BD_Collation
CREATE TABLE Textos(
ID INT,
Texto VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Textos(ID, Texto)
VALUES
	(1, 'Marcos'), (2, 'Excel'), (3, 'leandro'), (4, 'K'), (5, 'X7'), (6, 'l9'), (7, '#M'), (8, '@9'), (9, 'M'), (10, 'RT')

-- Retornando nomes que começam com a letra 'M', 'E' ou 'K'
SELECT *
FROM Textos
WHERE Texto LIKE '[MEK]%'

-- Retornando nomes que possuem apenas 1 caracteres
SELECT *
FROM Textos
WHERE Texto LIKE '[A-z]'

-- Retornando nomes que possuem apenas 2 caracteres
SELECT *
FROM Textos
WHERE Texto LIKE '[A-z][A-z]'

-- Retornando nomes que possuem apenas 2 caracteres: o primeiro uma letra, o segundo um número
SELECT *
FROM Textos
WHERE Texto LIKE '[A-z][0-9]'




-- LIKE: Aplicando um filtro ainda mais personalizado
CREATE TABLE Nomes(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Nomes(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

-- Retorna os nomes que:
-- 1. Começam com a letra 'M' ou 'm'
-- 2. O segundo caractere pode ser qualquer coisa ('_' é um curinga)
-- 3. O terceiro caractere pode ser a letra 'R' ou a letra 'r'
-- 4. Possui uma quantidade qualquer de caracteres depois do terceiro (por conta do '%')

SELECT *
FROM Nomes
WHERE Nome LIKE '[Mm]_[Rr]%'


-- LIKE: Utilizando o operador de negação
CREATE TABLE Nomes(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Nomes(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

-- Retorna nomes que não começa com as letras 'L' ou 'l'
SELECT *
FROM Nomes
WHERE Nome LIKE '[^Ll]%'

-- Retorna nomes que não começa com as letras 'L' ou 'l'
SELECT *
FROM Nomes
WHERE Nome LIKE '_[^Ee]%'



-- LIKE: Identificando caracteres especiais

USE BD_Collation
CREATE TABLE Textos(
ID INT,
Texto VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Textos(ID, Texto)
VALUES
	(1, 'Marcos'), (2, 'Excel'), (3, 'leandro'), (4, 'K'), (5, 'X7'), (6, 'l9'), (7, '#M'), (8, '@9'), (9, 'M'), (10, 'RT')

-- Identificando caracteres especiais
SELECT *
FROM Textos
WHERE Texto LIKE '%[^A-z0-9]%'



-- LIKE: Aplicações com números
USE BD_Collation
CREATE TABLE Numeros(
Numero DECIMAL(20, 2))

INSERT INTO Numeros(Numero)
VALUES
	(50), (30.23), (9), (100.54), (15.9), (6.5), (10), (501.76), (1000.56), (31)


-- Retornando os números que possuem 2 dígitos na parte inteira
SELECT *
FROM Numeros
WHERE Numero LIKE '[0-9][0-9].[0][0]'

-- Retornando linhas que:
-- 1. Possuem 3 dígitos na parte inteira, sendo o primeiro dígito igual a 5
-- 2. O primeiro número da parte decimal seja 7.
-- 3. O segundo número da parte decimal seja um número entre 0 e 9.

SELECT *
FROM Numeros
WHERE Numero LIKE '[5]__.[7][0-9]'
