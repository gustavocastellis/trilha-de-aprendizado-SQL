-- EXERCÍCIOS UTILIZANDO REALIZANDO A BASE DE DADOS CONTOSO DA MICROSOFT

--1. O gerente comercial pediu a você uma análise da Quantidade Vendida e Quantidade
--Devolvida para o canal de venda mais importante da empresa: Store.
--Utilize uma função SQL para fazer essas consultas no seu banco de dados. Obs: Faça essa
--análise considerando a tabela FactSales.

SELECT
	SUM(SalesQuantity) as 'Quantidade de Vendas',
	SUM(ReturnQuantity) as 'Quantidade de Devoluções'
FROM FactSales
WHERE channelKey = 1

--2. Uma nova ação no setor de Marketing precisará avaliar a média salarial de todos os clientes
--da empresa, mas apenas de ocupação Professional. Utilize um comando SQL para atingir esse
--resultado.
SELECT 
	AVG(YearlyIncome) 'Média de renda anual dos clientes' 
FROM DimCustomer
WHERE Occupation = 'Professional';


--3. Você precisará fazer uma análise da quantidade de funcionários das lojas registradas na
--empresa. O seu gerente te pediu os seguintes números e informações:

--a) Quantos funcionários tem a loja com mais funcionários?
--b) Qual é o nome dessa loja?
--c) Quantos funcionários tem a loja com menos funcionários?
--d) Qual é o nome dessa loja?
--a
SELECT
	MAX(EmployeeCount) 'Quantidade de Funcionários'
FROM DimStore
--b
SELECT
	StoreName
FROM DimStore
WHERE EmployeeCount = '325'

SELECT TOP(1)
	StoreName AS 'Nome da Loja', 
	EmployeeCount as 'Qtd. Funcionários' 
FROM DimStore
ORDER BY EmployeeCount DESC

--c
SELECT
	MIN(EmployeeCount)
FROM DimStore

--d
SELECT TOP(1) 
	StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd. Funcionários'
FROM DimStore
WHERE EmployeeCount IS NOT NULL
ORDER BY EmployeeCount

--4. A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade
--total de funcionários do sexo Masculino e do sexo Feminino.
--a) Descubra essas duas informações utilizando o SQL.
--b) O funcionário e a funcionária mais antigos receberão uma homenagem. Descubra as
--seguintes informações de cada um deles: Nome, E-mail, Data de Contratação.

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

--5. Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes
--informações:
--a) Quantidade distinta de cores de produtos.
--b) Quantidade distinta de marcas
--c) Quantidade distinta de classes de produto
--Para simplificar, você pode fazer isso em uma mesma consulta.
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
