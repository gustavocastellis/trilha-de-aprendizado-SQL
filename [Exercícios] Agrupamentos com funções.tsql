/* 1. a) Faça um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas
(channelkey).
b) Faça um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade
total devolvida (Return Quantity) de acordo com o ID das lojas (StoreKey).
c) Faça um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas
para o ano de 2007. */
--A
SELECT
	channelKey,
	SUM(SalesQuantity) AS 'Quantidade de Vendas'
FROM FactSales
GROUP BY channelKey
--B
SELECT
	StoreKey AS 'Chave da Loja',
	SUM(SalesQuantity) AS 'Quantidade de Vendas',
	SUM(ReturnQuantity) AS 'Quantidade de Retornos'
FROM FactSales
GROUP BY StoreKey
ORDER BY StoreKey
--C
SELECT
	channelKey,
	SUM(SalesAmount) AS 'Quantidade de Vendas'
FROM FactSales
WHERE DateKey BETWEEN '20070101' and '20071231'
GROUP BY channelKey

--------------------------------------------------------------------------------------------------------------------------------
/*  2. Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor
total vendido (SalesAmount) por produto (ProductKey).
a) A tabela final deverá estar ordenada de acordo com a quantidade vendida e, além disso,
mostrar apenas os produtos que tiveram um resultado final de vendas maior do que
$5.000.000.
b) Faça uma adaptação no exercício anterior e mostre os Top 10 produtos com mais vendas.
Desconsidere o filtro de $5.000.000 aplicado.*/
--A
SELECT
	ProductKey AS 'Chave do Produto',
	SUM(SalesAmount) AS 'Quantidade de Vendas'
FROM FactSales
GROUP BY ProductKey
HAVING SUM(SalesAmount) >= 5000000
ORDER BY [Quantidade de Vendas] DESC
--B
SELECT TOP(10)
	ProductKey AS 'Chave do Produto',
	SUM(SalesAmount) AS 'Quantidade de Vendas'
FROM FactSales
GROUP BY ProductKey
ORDER BY [Quantidade de Vendas] DESC
--------------------------------------------------------------------------------------------------------------------------------
/*  3. a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o ID
(CustomerKey) do cliente que mais realizou compras online (de acordo com a coluna
SalesQuantity).
b) Feito isso, faça um agrupamento de total vendido (SalesQuantity) por ID do produto
e descubra quais foram os top 3 produtos mais comprados pelo cliente da letra a). */
--A
SELECT TOP(1)
	CustomerKey,
	SUM(SalesQuantity) AS 'Vendas'
FROM FactOnlineSales
GROUP BY CustomerKey
ORDER BY Vendas DESC
--B
SELECT TOP(3)
	ProductKey AS 'ID do Produto',
	SUM(SalesQuantity) AS 'Vendas'
FROM FactOnlineSales
WHERE CustomerKey = 19037	
GROUP BY ProductKey
ORDER BY Vendas DESC
--------------------------------------------------------------------------------------------------------------------------------
/* 4. a) Faça um agrupamento e descubra a quantidade total de produtos por marca.
b) Determine a média do preço unitário (UnitPrice) para cada ClassName.
c) Faça um agrupamento de cores e descubra o peso total que cada cor de produto possui. */
--A
SELECT
	BrandName,
	COUNT(ProductKey) AS 'Número de Produtos'
FROM DimProduct
GROUP BY BrandName
--B
SELECT
	ClassName,
	AVG(UnitPrice)
FROM DimProduct
GROUP BY ClassName
--C
SELECT
	ColorName,
	SUM(Weight) AS 'Soma do Peso'
FROM DimProduct
GROUP BY ColorName
--------------------------------------------------------------------------------------------------------------------------------
/* 5. Você deverá descobrir o peso total para cada tipo de produto (StockTypeName).
A tabela final deve considerar apenas a marca ‘Contoso’ e ter os seus valores classificados em
ordem decrescente.*/
SELECT
	StockTypeName,
	SUM(Weight) AS 'Soma dos Pesos'
FROM DimProduct
WHERE BrandName = 'Contoso'
GROUP BY StockTypeName
ORDER BY [Soma dos Pesos] DESC
--------------------------------------------------------------------------------------------------------------------------------
/* 6. Você seria capaz de confirmar se todas as marcas dos produtos possuem à disposição todas as
16 opções de cores? */
SELECT 
	BrandName,
	COUNT(DISTINCT ColorName)
FROM DimProduct
GROUP BY BrandName
--------------------------------------------------------------------------------------------------------------------------------
/*7. Faça um agrupamento para saber o total de clientes de acordo com o Sexo e também a média
salarial de acordo com o Sexo. Corrija qualquer resultado “inesperado” com os seus
conhecimentos em SQL.*/
SELECT
	Gender,
	AVG(YearlyIncome) AS 'Média de Renda Anual',
	COUNT(Gender) AS 'Quantidade de Clientes'
FROM DimCustomer
WHERE Gender IS NOT NULL
GROUP BY Gender
--------------------------------------------------------------------------------------------------------------------------------
/*8. Faça um agrupamento para descobrir a quantidade total de clientes e a média salarial de
acordo com o seu nível escolar. Utilize a coluna Education da tabela DimCustomer para fazer
esse agrupamento.*/
SELECT
	Education,
	AVG(YearlyIncome) AS 'Média de Renda Anual',
	COUNT(Education) AS 'Quantidade de Clientes'
FROM DimCustomer
WHERE Education IS NOT NULL
GROUP BY Education
--------------------------------------------------------------------------------------------------------------------------------
/* 9. Faça uma tabela resumo mostrando a quantidade total de funcionários de acordo com o
Departamento (DepartmentName). Importante: Você deverá considerar apenas os
funcionários ativos.*/
SELECT
	DepartmentName,
	COUNT(DepartmentName) AS 'Quantidade de Funcionários'
FROM DimEmployee
WHERE Status != 'NULL'
GROUP BY DepartmentName
--------------------------------------------------------------------------------------------------------------------------------
/* 10. Faça uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Você
deve considerar apenas as mulheres, dos departamentos de Production, Marketing,
Engineering e Finance, para os funcionários contratados entre os anos de 1999 e 2000. */
SELECT
	Title,
	SUM(VacationHours) 
FROM DimEmployee
WHERE Gender = 'F' AND DepartmentName IN ('Production','Marketing','Engineering','Finance') AND StartDate BETWEEN '19990101' and '20001231'
GROUP BY Title
