--1. a) Faça um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal
--de vendas (ChannelName). Você deve ordenar a tabela final de acordo com SalesQuantity,
--em ordem decrescente.
--b) Faça um agrupamento mostrando a quantidade total vendida (Sales Quantity) e
--quantidade total devolvida (Return Quantity) de acordo com o nome das lojas
--(StoreName).
--c) Faça um resumo do valor total vendido (Sales Amount) para cada mês
--(CalendarMonthLabel) e ano (CalendarYear).
--A
SELECT
	ChannelName as 'Canal de Vendas',
	SUM(SalesQuantity) as 'Quantidade de Vendas'
FROM FactSales fs
INNER JOIN DimChannel dc ON fs.channelKey = dc.ChannelKey
GROUP BY ChannelName
ORDER BY [Quantidade de Vendas] DESC

--B
SELECT
	StoreName as 'Nome da Loja',
	SUM(SalesQuantity) as 'Quantidade de Vendas',
	SUM(ReturnQuantity) as 'Quantidade Devolvida'
FROM FactSales fs
INNER JOIN DimStore ds ON fs.StoreKey = ds.StoreKey
GROUP BY StoreName
ORDER BY StoreName

--C
SELECT
	CalendarYear,
	CalendarMonthLabel,
	SUM(SalesAmount) 'Total Vendido'
FROM FactSales fs
INNER JOIN DimDate dt ON fs.DateKey = dt.Datekey
GROUP BY CalendarMonthLabel, CalendarYear, CalendarMonth
ORDER BY CalendarYear, CalendarMonth

--2. Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor
--total vendido (SalesAmount) por produto.
--a) Descubra qual é a cor de produto que mais é vendida (de acordo com SalesQuantity).
--b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000.
--A
SELECT TOP(1)
	ColorName,
	SUM(SalesQuantity) 'Total de Vendas'
FROM FactSales fs
INNER JOIN DimProduct dp ON fs.ProductKey = dp.ProductKey
GROUP BY ColorName
ORDER BY [Total de Vendas] DESC

--B
SELECT
	ColorName,
	SUM(SalesQuantity) 'Total de Vendas'
FROM FactSales fs
INNER JOIN DimProduct dp ON fs.ProductKey = dp.ProductKey
GROUP BY ColorName
HAVING SUM(SalesQuantity) >= '3000000'
ORDER BY [Total de Vendas] DESC

--3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto
--(ProductCategoryName). Obs: Você precisará fazer mais de 1 INNER JOIN, dado que a relação
--entre FactSales e DimProductCategory não é direta.
SELECT
	ProductCategoryName,
	SUM(SalesQuantity) 'Quantidade Vendida'
FROM FactSales fs
INNER JOIN DimProduct dp ON fs.ProductKey = dp.ProductKey
INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
INNER JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
GROUP BY ProductCategoryName
ORDER BY [Quantidade Vendida] DESC

--4. a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o nome completo
--do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).
--b) Feito isso, faça um agrupamento de produtos e descubra quais foram os top 10 produtos mais
--comprados pelo cliente da letra a, considerando o nome do produto.
--A
SELECT
	fos.CustomerKey,
	COUNT(fos.CustomerKey) as 'Quantidade de Vendas'
FROM FactOnlineSales fos
INNER JOIN DimCustomer dc on fos.CustomerKey = dc.CustomerKey
WHERE dc.FirstName IS NOT NULL
GROUP BY fos.CustomerKey
ORDER BY [Quantidade de Vendas] DESC

--B
SELECT TOP(10)
	dp.ProductName,
	COUNT(fos.ProductKey) AS 'Quantidade de Vendas'	
FROM FactOnlineSales fos
INNER JOIN DimCustomer dc ON fos.CustomerKey = dc.CustomerKey
INNER JOIN DimProduct dp ON fos.ProductKey = dp.ProductKey
WHERE dc.CustomerKey = '7665'
GROUP BY ProductName
ORDER BY [Quantidade de Vendas] DESC


--5. Faça um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o
--sexo dos clientes.SELECT	Gender as 'Sexo',	SUM(SalesQuantity) as 'Quantidade de Vendas'FROM FactOnlineSales fosINNER JOIN DimCustomer dc ON fos.CustomerKey = dc.CustomerKeyWHERE Gender is not nullGROUP BY dc.Gender--FACTEXCHANGERATE
--6. Faça uma tabela resumo mostrando a taxa de câmbio média de acordo com cada
--CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100.SELECT DISTINCT	CurrencyDescription,	AVG(AverageRate) 'Média de Taxa'FROM FactExchangeRate ferINNER JOIN DimCurrency dc ON fer.CurrencyKey = dc.CurrencyKeyWHERE AverageRate BETWEEN 10 and 100GROUP BY CurrencyDescription--FACTSTRATEGYPLAN
--7. Calcule a SOMA TOTAL de AMOUNT referente à tabela FactStrategyPlan destinado aos
--cenários: Actual e Budget.
--Dica: A tabela DimScenario será importante para esse exercício.SELECT 	ScenarioName,	SUM(Amount)FROM FactStrategyPlan fspINNER JOIN DimScenario ds ON fsp.ScenarioKey = ds.ScenarioKeyWHERE ScenarioName IN ('Actual','Budget')GROUP BY ScenarioName--8. Faça uma tabela resumo mostrando o resultado do planejamento estratégico por anoSELECT	CalendarYear,	SUM(Amount)FROM FactStrategyPlan fspINNER JOIN DimDate dt on fsp.Datekey = dt.DatekeyGROUP BY CalendarYear--DIMPRODUCT/DIMPRODUCTSUBCATEGORY
--9. Faça um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em
--consideração em sua análise apenas a marca Contoso e a cor Silver.
SELECT
	ProductSubcategoryName,
	COUNT(ProductKey) 'Quantidade de Produtos'
FROM DimProduct dp
INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
WHERE BrandName = 'Contoso' and ColorName = 'Silver'
GROUP BY ProductSubcategoryName


--10. Faça um agrupamento duplo de quantidade de produtos por BrandName e
--ProductSubcategoryName. A tabela final deverá ser ordenada de acordo com a coluna
--BrandName.
SELECT * FROM DimProduct;
SELECT * FROM DimProductSubcategory

SELECT
	BrandName,
	ProductSubcategoryName,
	COUNT(ProductKey) 'Quantidade de Produtos'
FROM DimProduct dp
INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
GROUP BY BrandName, ProductSubcategoryName
ORDER BY BrandName