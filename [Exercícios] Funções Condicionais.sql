-- [SQL Server] Funções Condicionais
-- Aula 2 de 18: CASE WHEN... ELSE (Explicação)

-- Introdução: A função CASE permite tratar condições no SQL

/*
CASE
	WHEN teste_logico THEN 'resultado1'
	ELSE 'resultado2'
END
*/

-- Exemplo 1: Determine a situação do aluno. Se a Média for >= 6, então está aprovado. Caso contrário, reprovado.

DECLARE @varNota FLOAT = 5
SELECT
	CASE
		WHEN @varNota >= 6 THEN 'Aprovado'
		ELSE 'Reprovado'
	END AS 'Situação'


-- Exemplo 2: A data de vencimento de um produto é no dia 10/03/2022. Faça um teste lógico para verificar se um produto passou da validade ou não.

DECLARE @varDataVencimento DATETIME, @varDataAtual DATETIME
SET @varDataVencimento = '10/03/2025'
SET @varDataAtual = '30/04/2022'

SELECT
	CASE
		WHEN @varDataAtual > @varDataVencimento 
		THEN 'Produto Vencido'
		ELSE 'Na validade'
	END AS 'Verificação'

-- [SQL Server] Funções Condicionais
-- Aula 3 de 18: CASE WHEN... ELSE (Exemplo)

-- Exemplo: Faça um SELECT das colunas CustomerKey, FirstName e Gender na tabela DimCustomer e utilize o CASE para criar uma 4ª coluna com a informação de 'Masculino' ou 'Feminino'.
SELECT
	CustomerKey AS 'ID Cliente',
	FirstName AS 'Nome',
	Gender AS 'Sexo',
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		ELSE 'Feminino'
	END AS 'Sexo (CASE)'
FROM
	DimCustomer

	-- [SQL Server] Funções Condicionais
-- Aula 4 de 18: CASE WHEN WHEN... ELSE (Explicação)

/*
CASE
	WHEN teste_logico1 THEN 'resultado1'
	WHEN teste_logico2 THEN 'resultado2'
	ELSE 'resultado3'
END

Exemplo 1:

Crie um código para verificar a nota do aluno e determinar a situação:
- Aprovado: nota maior ou igual a 6
- Prova final: noa entre 4 e 6
- Reprovado: nota abaixo de 4

DECLARE @varNota FLOAT
SET @varNota = 1

SELECT
CASE
	WHEN @varNota >= 6 THEN 'Aprovado'
	WHEN @varNota >= 4 THEN 'Prova final'
	ELSE 'Reprovado'
END

*/

-- Exemplo 2: Classifique o produto de acordo com o seu preço:
-- Preço >= 40000: Luxo
-- Preço >= 10000 e Preço < 40000: Econômico
-- Preço < 10000: Básico

DECLARE @preco FLOAT = 1000
SELECT
	CASE
		WHEN @preco >= 40000 THEN 'É um produto de Luxo'
		WHEN @preco >= 10000 THEN 'É um produto Econômico'
		ELSE 'É um produto Básico'
	END

SELECT
	CustomerKey AS 'ID Cliente',
	FirstName AS 'Nome',
	Gender AS 'Sexo',
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		WHEN Gender = 'F' THEN 'Feminino'
		ELSE NULL
	END AS 'Sexo (CASE)'
FROM
	DimCustomer

-- [SQL Server] Funções Condicionais
-- Aula 6 de 18: CASE com os operadores lógicos AND e OR

-- Faça uma consulta à tabela DimProduct e retorne as colunas ProductName, BrandName, ColorName, UnitPrice e uma coluna de preço com desconto.

-- a) Caso o produto seja da marca Contoso E da cor Red, o desconto do produto será de 10%. Caso contrário, não terá nenhum desconto.


SELECT
	ProductName,
	BrandName,
	ColorName,
	UnitPrice,
	CASE
		WHEN BrandName = 'Contoso' AND ColorName = 'Red' THEN UnitPrice * 0.9
		ELSE 0
	END AS 'Preço com desconto'
FROM
	DimProduct


-- b) Caso o produto seja da marca Litware OU Fabrikam, ele receberá um desconto de 5%. Caso contrário, não terá nenhum desconto.

SELECT
	ProductName,
	BrandName,
	ColorName,
	UnitPrice,
	CASE
		WHEN BrandName = 'Contoso' OR BrandName = 'Fabrikam' THEN CAST((UnitPrice * 0.95) AS decimal(10,2))
		ELSE 0
	END AS 'Preço com desconto'
FROM
	DimProduct


-- [SQL Server] Funções Condicionais
-- Aula 7 de 18: CASE Aninhado


-- DimEmployee
SELECT * FROM DimEmployee

-- 4 Cargos (Title):
-- Sales Group Manager
-- Sales Region Manager
-- Sales State Manager
-- Sales Store Manager

-- Assalariado (SalariedFlag)?
-- SalariedFlag = 0: não é assalariado
-- SalariedFlag = 1: é assalariado

-- Situação: Cálculo do bônus
-- Sales Group Manager: Se for assalariado, 20%; Se não, 15%.
-- Sales Region Manager: 15%
-- Sales State Manager: 7%
-- Sales Store Manager: 2%

SELECT
	FirstName,
	Title,
	SalariedFlag,
	CASE
		WHEN Title = 'Sales Group Manager' AND SalariedFlag = 1 THEN 0.3
		WHEN Title = 'Sales Group Manager' AND SalariedFlag != 1 THEN 0.2
		WHEN Title = 'Sales Region Manager' THEN 0.15
		WHEN Title = 'Sales State Manager' THEN 0.07
		ELSE 0.02
	END AS 'Bônus'
FROM
	DimEmployee
	where Title = 'Sales Group Manager'

-- [SQL Server] Funções Condicionais
-- Aula 8 de 18: CASE Aditivo

-- Os produtos da categoria 'TV and Video' terão um desconto de 10%
-- Se além de ser da categoria 'TV and Video', o produto for da subcategoria 'Televisions', receberá mais 5%. Total, 15%

SELECT
	ProductKey,
	ProductName,
	ProductCategoryName,
	ProductSubcategoryName,	
	UnitPrice,
	CASE WHEN ProductCategoryName = 'TV and Video' 
		THEN 0.10 ELSE 0.00 END
	+ CASE WHEN ProductSubCategoryName = 'Televisions' 
		THEN 0.05 ELSE 0.00 END
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey