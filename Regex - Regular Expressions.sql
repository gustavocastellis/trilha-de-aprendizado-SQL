/* COLLATION

O que �?
O COLLATION nos permite configurar se teremos diferencia��o entre mai�sculas e min�sculas, ou entre palavras acentuadas.

O COLLATION pode ser definido em n�veis diferentes no SQL Server. Abaixo est�o os tr�s n�veis:
1. A n�vel SQL Server
2. A n�vel de Bancos de Dados
3. A n�vel de tabelas/colunas

1. A n�vel SQL Server
O COLLATION a princ�pio � definido durante a instala��o do programa.
Por padr�o, o COLLATION padr�o � o seguinte:
Latin1_General_CI_AS
Onde CI significa Case Insensitive (n�o diferencia mai�sculas de min�sculas) e AS significa Accent Sensitive (sens�vel ao sotaque).
Para descobrir o COLLATION configurado, podemos utilizar o comando abaixo:*/

SELECT SERVERPROPERTY('collation')


/*2. A n�vel de Banco de Dados
Por padr�o, todos os bancos de dados v�o herdar a configura��o do COLLATION do SQL Server feito durante a instala��o.
Em Propriedades, conseguimos visualizar o COLLATION configurado.

N�s podemos tamb�m especificar o COLLATION do Banco de Dados no momento da sua cria��o.*/

CREATE DATABASE BD_Collation
COLLATE Latin1_General_CS_AS

/*Podemos tamb�m alterar o COLLATE ap�s criar um banco de dados. Neste caso, usamos o comando abaixo:*/

ALTER DATABASE BD_Collation COLLATE Latin1_General_CI_AS

/*Para saber o COLLATION de um Banco de Dados espec�fico, podemos usar o comando abaixo:*/

SELECT DATABASEPROPERTYEX('BD_Collation','collation')

/*3. A n�vel de Coluna/Tabela
Por padr�o, uma nova coluna de tipo VARCHAR herda o COLLATION do banco de dados, a menos que voc� especifique o COLLATION explicitamente ao criar a tabela.
Para criar uma coluna com um COLLATION diferente, voc� pode especificar o agrupamento usando o comando Collate SQL.*/

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

-- Case Sensitive (diferenciando mai�sculas de min�sculas
-- LIKE padr�o como aprendemos at� agora:
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

-- Retornando nomes que come�am com a letra 'M', 'E' ou 'K'
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

-- Retornando nomes que possuem apenas 2 caracteres: o primeiro uma letra, o segundo um n�mero
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
-- 1. Come�am com a letra 'M' ou 'm'
-- 2. O segundo caractere pode ser qualquer coisa ('_' � um curinga)
-- 3. O terceiro caractere pode ser a letra 'R' ou a letra 'r'
-- 4. Possui uma quantidade qualquer de caracteres depois do terceiro (por conta do '%')

SELECT *
FROM Nomes
WHERE Nome LIKE '[Mm]_[Rr]%'


-- LIKE: Utilizando o operador de nega��o
CREATE TABLE Nomes(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Nomes(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

-- Retorna nomes que n�o come�a com as letras 'L' ou 'l'
SELECT *
FROM Nomes
WHERE Nome LIKE '[^Ll]%'

-- Retorna nomes que n�o come�a com as letras 'L' ou 'l'
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



-- LIKE: Aplica��es com n�meros
USE BD_Collation
CREATE TABLE Numeros(
Numero DECIMAL(20, 2))

INSERT INTO Numeros(Numero)
VALUES
	(50), (30.23), (9), (100.54), (15.9), (6.5), (10), (501.76), (1000.56), (31)


-- Retornando os n�meros que possuem 2 d�gitos na parte inteira
SELECT *
FROM Numeros
WHERE Numero LIKE '[0-9][0-9].[0][0]'

-- Retornando linhas que:
-- 1. Possuem 3 d�gitos na parte inteira, sendo o primeiro d�gito igual a 5
-- 2. O primeiro n�mero da parte decimal seja 7.
-- 3. O segundo n�mero da parte decimal seja um n�mero entre 0 e 9.

SELECT *
FROM Numeros
WHERE Numero LIKE '[5]__.[7][0-9]'
