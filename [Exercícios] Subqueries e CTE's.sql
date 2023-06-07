--EXERCÍCIOS SUBQUERIES

--1. Para fins fiscais, a contabilidade da empresa precisa de uma tabela contendo todas as vendas
--referentes à loja ‘Contoso Orlando Store’. Isso porque essa loja encontra-se em uma região onde
--a tributação foi modificada recente.
--Portanto, crie uma consulta ao Banco de Dados para obter uma tabela FactSales contendo todas
--as vendas desta loja.
SELECT * FROM FactSales 
WHERE StoreKey = (SELECT "StoreKey" FROM DimStore WHERE StoreName = 'Contoso Orlando Store')

--2. O setor de controle de produtos quer fazer uma análise para descobrir quais são os produtos
--que possuem um UnitPrice maior que o UnitPrice do produto de ID igual a 1893.
--a) A sua consulta resultante deve conter as colunas ProductKey, ProductName e UnitPrice
--da tabela DimProduct.
--b) Nessa query você também deve retornar uma coluna extra, que informe o UnitPrice do
--produto 1893.
SELECT ProductKey,
	   ProductName,
	   UnitPrice,
	   (SELECT UnitPrice FROM DimProduct WHERE ProductKey = 1893)
FROM DimProduct
WHERE UnitPrice > (SELECT UnitPrice FROM DimProduct WHERE ProductKey = 1893)

--3. A empresa Contoso criou um programa de bonificação chamado “Todos por 1”. Este
--programa consistia no seguinte: 1 funcionário seria escolhido ao final do ano como o funcionário
--destaque, só que a bonificação seria recebida por todos da área daquele funcionário em
--particular. O objetivo desse programa seria o de incentivar a colaboração coletiva entre os
--funcionários de uma mesma área. Desta forma, o funcionário destaque beneficiaria não só a si,
--mas também a todos os colegas de sua área.
--Ao final do ano, o funcionário escolhido como destaque foi o Miguel Severino. Isso significa que
--todos os funcionários da área do Miguel seriam beneficiados com o programa.
--O seu objetivo é realizar uma consulta à tabela DimEmployee e retornar todos os funcionários
--da área “vencedora” para que o setor Financeiro possa realizar os pagamentos das bonificações.
SELECT 
	FirstName,
	LastName,
	EmailAddress,
	Phone
FROM DimEmployee
WHERE DepartmentName = (SELECT DepartmentName FROM DimEmployee WHERE FirstName = 'Miguel' and LastName = 'Severino')

--4. Faça uma query que retorne os clientes que recebem um salário anual acima da média. A sua
--query deve retornar as colunas CustomerKey, FirstName, LastName, EmailAddress e
--YearlyIncome.
--Obs: considere apenas os clientes que são 'Pessoas Físicas'.
SELECT CustomerKey,
	FirstName,
	LastName,
	EmailAddress,
	YearlyIncome
FROM DimCustomer
WHERE YearlyIncome > (SELECT AVG(YearlyIncome) FROM DimCustomer WHERE CustomerType = 'Person')

--5. A ação de desconto da Asian Holiday Promotion foi uma das mais bem sucedidas da empresa.
--Agora, a Contoso quer entender um pouco melhor sobre o perfil dos clientes que compraram
--produtos com essa promoção.
--Seu trabalho é criar uma query que retorne a lista de clientes que compraram nessa promoção.
SELECT TOP(100)* FROM FactSales;
SELECT TOP(100)* FROM FactOnlineSales;
SELECT PromotionKey FROM DimPromotion WHERE PromotionName = 'Asian Holiday Promotion';
SELECT DISTINCT CustomerKey FROM FactOnlineSales WHERE PromotionKey in (SELECT PromotionKey FROM DimPromotion WHERE PromotionName = 'Asian Holiday Promotion')

SELECT * FROM DimCustomer 
WHERE CustomerKey in 
					(SELECT DISTINCT CustomerKey FROM FactOnlineSales WHERE PromotionKey in (SELECT PromotionKey FROM DimPromotion WHERE PromotionName = 'Asian Holiday Promotion'))
ORDER BY CustomerKey



--6. A empresa implementou um programa de fidelização de clientes empresariais. Todos aqueles
--que comprarem mais de 3000 unidades de um mesmo produto receberá descontos em outras
--compras.
--Você deverá descobrir as informações de CustomerKey e CompanyName destes clientes.
SELECT CustomerKey,
	CompanyName 
FROM DimCustomer WHERE CustomerKey in(
SELECT CustomerKey
	FROM FactOnlineSales
GROUP BY CustomerKey
HAVING COUNT(*) > 3000)

--7. Você deverá criar uma consulta para o setor de vendas que mostre as seguintes colunas da
--tabela DimProduct:

--ProductKey,
--ProductName,
--BrandName,
--UnitPrice
--Média de UnitPrice.
SELECT ProductKey,
	ProductName,
	BrandName,
	UnitPrice,
	(SELECT AVG(UnitPrice) FROM DimProduct) as 'Medía UnitPrice'
	
FROM DimProduct

--8. Faça uma consulta para descobrir os seguintes indicadores dos seus produtos:
--Maior quantidade de produtos por marca
--Menor quantidade de produtos por marca
--Média de produtos por marca
SELECT
	MAX(Quantidade) AS 'Máximo',
	MIN(Quantidade) AS 'Mínimo',
	AVG(Quantidade) AS 'Média'
FROM (SELECT BrandName, COUNT(*) AS 'Quantidade' FROM DimProduct GROUP BY BrandName) AS T

--9. Crie uma CTE que seja o agrupamento da tabela DimProduct, armazenando o total de
--produtos por marca. Em seguida, faça um SELECT nesta CTE, descobrindo qual é a quantidade
--máxima de produtos para uma marca. Chame esta CTE de CTE_QtdProdutosPorMarca.
WITH CTE_QtdProdutosPorMarca AS (
SELECT
	BrandName,
	COUNT(*) as 'Quantidade'
FROM DimProduct
GROUP BY BrandName)

SELECT MAX(Quantidade) FROM CTE_QtdProdutosPorMarca

--10. Crie duas CTEs:
--(i) a primeira deve conter as colunas ProductKey, ProductName, ProductSubcategoryKey,
--BrandName e UnitPrice, da tabela DimProduct, mas apenas os produtos da marca Adventure
--Works. Chame essa CTE de CTE_ProdutosAdventureWorks.
--(ii) a segunda deve conter as colunas ProductSubcategoryKey, ProductSubcategoryName, da
--tabela DimProductSubcategory mas apenas para as subcategorias ‘Televisions’ e ‘Monitors’.
--Chame essa CTE de CTE_CategoriaTelevisionsERadio.
--Faça um Join entre essas duas CTEs, e o resultado deve ser uma query contendo todas as colunas
--das duas tabelas. Observe nesse exemplo a diferença entre o LEFT JOIN e o INNER JOIN.

WITH CTE_ProdutosAdventureWorks AS (
SELECT ProductKey,
	ProductName,
	ProductSubcategoryKey,
	BrandName,
	UnitPrice
FROM DimProduct
WHERE BrandName = 'Adventure Works'
),
CTE_CategoriaTelevisionsERadio AS (
SELECT ProductSubcategoryKey,
	ProductSubcategoryName	
FROM DimProductSubcategory
WHERE ProductSubcategoryName IN ('Televisions','Monitors'))
SELECT * FROM CTE_ProdutosAdventureWorks
LEFT JOIN CTE_CategoriaTelevisionsERadio ON CTE_ProdutosAdventureWorks.ProductSubcategoryKey = CTE_CategoriaTelevisionsERadio.ProductSubcategoryKey

-- [SQL Server] [Subqueries e CTE's] Aula 3 de 28: Subquery na prática - Aplicação com o Where (Exemplo 1)

-- Para entender a ideia por trás das subqueries, vamos começar fazendo 3 exemplos com a aplicação WHERE.

-- Exemplo 1: Quais produtos da tabela DimProduct possuem custos acima da média?

SELECT AVG(UnitCost) FROM DimProduct     -- 147.6555

SELECT
	*
FROM
	DimProduct
WHERE UnitCost >= (SELECT AVG(UnitCost) FROM DimProduct)


-- [SQL Server] [Subqueries e CTE's] Aula 4 de 28: Subquery na prática - Aplicação com o Where (Exemplo 2)

-- Para entender a ideia por trás das subqueries, vamos começar fazendo 3 exemplos com a aplicação WHERE.

-- Exemplo 2: Faça uma consulta para retornar os produtos da categoria 'Televisions'. Tome cuidado pois não temos a informação de Nome da Subcategoria na tabela DimProduct. Dessa forma, precisaremos criar um SELECT que descubra o ID da categoria 'Televisions' e passar esse resultado como o valor que queremos filtrar dentro do WHERE.


SELECT * FROM DimProduct
WHERE ProductSubcategoryKey = 
	(SELECT ProductSubcategoryKey FROM DimProductSubcategory
		WHERE ProductSubcategoryName = 'Televisions')

-- [SQL Server] [Subqueries e CTE's] Aula 5 de 28: Subquery na prática - Aplicação com o Where (Exemplo 3)

-- Para entender a ideia por trás das subqueries, vamos começar fazendo 3 exemplos com a aplicação WHERE.

-- Exemplo 3: Filtre a tabela FactSales e mostre apenas as vendas referentes às lojas com 100 ou mais funcionários

SELECT * FROM FactSales
WHERE StoreKey IN (
	SELECT	StoreKey
	FROM DimStore
	WHERE EmployeeCount >= 100
)



-- [SQL Server] [Subqueries e CTE's] Aula 6 de 28: ANY, SOME e ALL

CREATE TABLE funcionarios(
id_funcionario INT,
nome VARCHAR(50),
idade INT,
sexo VARCHAR(50))

INSERT INTO funcionarios(id_funcionario, nome, idade, sexo)
VALUES	
	(1, 'Julia', 20, 'F'),
	(2, 'Daniel', 21, 'M'),
	(3, 'Amanda', 22, 'F'),
	(4, 'Pedro', 23, 'M'),
	(5, 'André', 24, 'M'),
	(6, 'Luisa', 25, 'F')

SELECT * FROM funcionarios

-- Selecione os funcionários do sexo masculino (MAS, utilizando a coluna de IDADE para isso)

SELECT * FROM funcionarios
WHERE idade IN (21, 23, 24)

SELECT * FROM funcionarios
WHERE idade IN (SELECT idade FROM funcionarios WHERE sexo = 'M')

/*
= ANY(valor1, valor2, valor3) :
Equivalente ao IN, retorna as lunhas da tabela que sejam iguais ao valor1, OU valor2, OU valor3
*/

SELECT * FROM funcionarios
WHERE idade = ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/*
> ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o mínimo dos valores
*/

SELECT * FROM funcionarios
WHERE idade > ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/*
< ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o máximo dos valores
*/

SELECT * FROM funcionarios
WHERE idade < ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')


/*
> ALL(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, E valor2, E valor3. Ou seja, maior que o máximo dos valores
*/

SELECT * FROM funcionarios
WHERE idade > ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')

/*
< ALL(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores menores que o valor1, E valor2, E valor3. Ou seja, menor que o mínimo dos valores
*/

SELECT * FROM funcionarios
WHERE idade < ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')


-- [SQL Server] [Subqueries e CTE's] Aulas 7 e 8 de 28: EXISTS

-- Exemplo: Retornar uma tabela com todos os produtos (ID Produto e Nome Produto) que possuem alguma venda no dia 01/01/2007

-- 2517 - 1724 = 793

-- Conta a quantidade de Produtos
SELECT COUNT(*) FROM DimProduct

-- Retorna uma tabela com todos os produtos que possuem alguma venda

SELECT
	ProductKey,
	ProductName
FROM	
	DimProduct
WHERE EXISTS(
	SELECT
		ProductKey
	FROM
		factSales
	WHERE
		DateKey = '01/01/2007'
		AND factSales.ProductKey = DimProduct.ProductKey
)


-- Solução alternativa com o ANY

SELECT
	ProductKey,
	ProductName
FROM	
	DimProduct
WHERE ProductKey = ANY(
	SELECT
		ProductKey
	FROM
		factSales
	WHERE
		DateKey = '01/01/2007'
		-- AND factSales.ProductKey = DimProduct.ProductKey
)


-- [SQL Server] [Subqueries e CTE's] Aula 9 de 28: Subquery na prática - Aplicação com o SELECT

-- Exemplo: Retornar uma tabela com todos os produtos (ID Produto e Nome Produto) e também o total de vendas para cada produto

SELECT
	ProductKey,
	ProductName,
	(SELECT COUNT(ProductKey) FROM FactSales WHERE DimProduct.ProductKey = FactSales.ProductKey)
FROM
	DimProduct


	-- [SQL Server] [Subqueries e CTE's] Aula 10 de 28: Subquery na prática - Aplicação com o FROM

-- Exemplo: Retornar a quantidade total de produtos da marca Contoso.

SELECT 
	COUNT(*) 
FROM DimProduct
WHERE BrandName = 'Contoso'

SELECT
	COUNT(*)
FROM (SELECT * FROM DimProduct WHERE BrandName = 'Contoso') AS T



-- [SQL Server] [Subqueries e CTE's] Aula 12 e 13 de 28: Subquery aninhada

-- Exemplo: Descubra os nomes dos clientes que ganham o segundo maior salário.

SELECT * FROM DimCustomer
WHERE CustomerType = 'Person'
ORDER BY YearlyIncome DESC

SELECT DISTINCT TOP(2) YearlyIncome FROM DimCustomer
WHERE CustomerType = 'Person'
ORDER BY YearlyIncome DESC

SELECT
	CustomerKey,
	FirstName,
	LastName,
	YearlyIncome
FROM DimCustomer
WHERE YearlyIncome = 160000


--1. Descobrir o maior salário
--2. Descobrir o segundo maior salário
--3. Descobrir os nomes dos clientes que ganham o segundo maior salário



SELECT
	CustomerKey,
	FirstName,
	LastName,
	YearlyIncome
FROM DimCustomer
WHERE YearlyIncome = (
	SELECT
		MAX(YearlyIncome)
	FROM DimCustomer
	WHERE
		YearlyIncome < (
			SELECT 
				MAX(YearlyIncome) 
			FROM DimCustomer	
			WHERE CustomerType = 'Person'
	)
)



-- [SQL Server] [Subqueries e CTE's] Aula 14 de 28: CTE - O que é e como criar

-- Exemplo: Crie uma CTE para armazenar o resultado de uma consulta que contenha: ProductKey, ProductName, BrandName, ColorName e UnitPrice, apenas para a marca Contoso.

WITH cte AS (
SELECT 
	ProductKey,
	ProductName,
	BrandName,
	ColorName
	UnitPrice
FROM DimProduct 
WHERE BrandName = 'Contoso'
)

SELECT
	COUNT(*)
FROM cte



-- [SQL Server] [Subqueries e CTE's] Aula 16 de 28: Nomeando colunas de uma CTE

-- Exemplo: Crie uma CTE que seja o resultado do agrupamento de total de produtos por marca. Faça uma média de produtos por marca.

WITH cte(Marca, Total) AS (
	SELECT
		BrandName,
		COUNT(*)
	FROM
		DimProduct
	GROUP BY
		BrandName
)


SELECT
	Marca,
	Total
FROM
	cte


-- [SQL Server] [Subqueries e CTE's] Aula 17 de 28: Criando múltiplas CTE's

-- Exemplo: Crie 2 CTE's:
-- 1. A primeira, cjamada produtos_contoso, deve conter as seguintes colunas (DimProduct): ProductKey, ProductName, BrandName
-- 2. A segunda, chamada vendas_top100, deve ser um top 100 vendas mais recentes, considerando as seguintes colunas da tabela FactSales: SalesKey, ProductKey, DateKey, SalesQuantity

-- Por fim, faça um INNER JOIN dessas tabelas

WITH produtos_contoso AS (
	SELECT
		ProductKey,
		ProductName,
		BrandName
	FROM
		DimProduct
	WHERE
		BrandName = 'Contoso'
),
vendas_top100 AS (
	SELECT TOP(100)
		SalesKey,
		ProductKey,
		DateKey,
		SalesQuantity
	FROM
		FactSales
	ORDER BY
		DateKey DESC
)

SELECT * FROM vendas_top100
INNER JOIN produtos_contoso
	ON vendas_top100.ProductKey = produtos_contoso.ProductKey
