-- EXERC�CIOS UTILIZANDO REALIZANDO A BASE DE DADOS CONTOSO DA MICROSOFT

--1. O gerente comercial pediu a voc� uma an�lise da Quantidade Vendida e Quantidade
--Devolvida para o canal de venda mais importante da empresa: Store.
--Utilize uma fun��o SQL para fazer essas consultas no seu banco de dados. Obs: Fa�a essa
--an�lise considerando a tabela FactSales.

SELECT
	SUM(SalesQuantity) as 'Quantidade de Vendas',
	SUM(ReturnQuantity) as 'Quantidade de Devolu��es'
FROM FactSales
WHERE channelKey = 1

--2. Uma nova a��o no setor de Marketing precisar� avaliar a m�dia salarial de todos os clientes
--da empresa, mas apenas de ocupa��o Professional. Utilize um comando SQL para atingir esse
--resultado.
SELECT 
	AVG(YearlyIncome) 'M�dia de renda anual dos clientes' 
FROM DimCustomer
WHERE Occupation = 'Professional';


--3. Voc� precisar� fazer uma an�lise da quantidade de funcion�rios das lojas registradas na
--empresa. O seu gerente te pediu os seguintes n�meros e informa��es:

--a) Quantos funcion�rios tem a loja com mais funcion�rios?
--b) Qual � o nome dessa loja?
--c) Quantos funcion�rios tem a loja com menos funcion�rios?
--d) Qual � o nome dessa loja?
--a
SELECT
	MAX(EmployeeCount) 'Quantidade de Funcion�rios'
FROM DimStore
--b
SELECT
	StoreName
FROM DimStore
WHERE EmployeeCount = '325'

SELECT TOP(1)
	StoreName AS 'Nome da Loja', 
	EmployeeCount as 'Qtd. Funcion�rios' 
FROM DimStore
ORDER BY EmployeeCount DESC

--c
SELECT
	MIN(EmployeeCount)
FROM DimStore

--d
SELECT TOP(1) 
	StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd. Funcion�rios'
FROM DimStore
WHERE EmployeeCount IS NOT NULL
ORDER BY EmployeeCount

--4. A �rea de RH est� com uma nova a��o para a empresa, e para isso precisa saber a quantidade
--total de funcion�rios do sexo Masculino e do sexo Feminino.
--a) Descubra essas duas informa��es utilizando o SQL.
--b) O funcion�rio e a funcion�ria mais antigos receber�o uma homenagem. Descubra as
--seguintes informa��es de cada um deles: Nome, E-mail, Data de Contrata��o.

SELECT 
	COUNT(Gender) 
FROM DimEmployee
WHERE Gender = 'M'

SELECT 
	COUNT(Gender) 
FROM DimEmployee
WHERE Gender = 'F'

SELECT TOP(1) 
	FirstName,
	LastName,
	EmailAddress,
	HireDate
 FROM DimEmployee
 WHERE Gender = 'M'
 ORDER BY HireDate

SELECT TOP(1) 
	FirstName,
	LastName,
	EmailAddress,
	HireDate
 FROM DimEmployee
 WHERE Gender = 'F'
 ORDER BY HireDate

--5. Agora voc� precisa fazer uma an�lise dos produtos. Ser� necess�rio descobrir as seguintes
--informa��es:
--a) Quantidade distinta de cores de produtos.
--b) Quantidade distinta de marcas
--c) Quantidade distinta de classes de produto
--Para simplificar, voc� pode fazer isso em uma mesma consulta.
SELECT TOP(100) * FROM DimProduct

SELECT 
	COUNT(DISTINCT ColorName) AS 'Qtd. Cores'
FROM DimProduct

SELECT 
	COUNT(DISTINCT BrandName) AS 'Qtd. Marcas'
FROM DimProduct

SELECT 
	COUNT(DISTINCT ClassName) AS 'Qtd. de Classes'
FROM DimProduct

SELECT
	COUNT(DISTINCT ColorName) AS 'Qtd. Cores',
	COUNT(DISTINCT BrandName) AS 'Qtd. Marcas',
	COUNT(DISTINCT ClassName) AS 'Qtd. de Classes'
FROM
	DimProduct