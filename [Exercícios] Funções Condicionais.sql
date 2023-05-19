-- [SQL Server] Fun��es Condicionais
-- Aula 2 de 18: CASE WHEN... ELSE (Explica��o)

-- Introdu��o: A fun��o CASE permite tratar condi��es no SQL

/*
CASE
	WHEN teste_logico THEN 'resultado1'
	ELSE 'resultado2'
END
*/

-- Exemplo 1: Determine a situa��o do aluno. Se a M�dia for >= 6, ent�o est� aprovado. Caso contr�rio, reprovado.

DECLARE @varNota FLOAT = 5
SELECT
	CASE
		WHEN @varNota >= 6 THEN 'Aprovado'
		ELSE 'Reprovado'
	END AS 'Situa��o'


-- Exemplo 2: A data de vencimento de um produto � no dia 10/03/2022. Fa�a um teste l�gico para verificar se um produto passou da validade ou n�o.

DECLARE @varDataVencimento DATETIME, @varDataAtual DATETIME
SET @varDataVencimento = '10/03/2025'
SET @varDataAtual = '30/04/2022'

SELECT
	CASE
		WHEN @varDataAtual > @varDataVencimento 
		THEN 'Produto Vencido'
		ELSE 'Na validade'
	END AS 'Verifica��o'

-- [SQL Server] Fun��es Condicionais
-- Aula 3 de 18: CASE WHEN... ELSE (Exemplo)

-- Exemplo: Fa�a um SELECT das colunas CustomerKey, FirstName e Gender na tabela DimCustomer e utilize o CASE para criar uma 4� coluna com a informa��o de 'Masculino' ou 'Feminino'.
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

	-- [SQL Server] Fun��es Condicionais
-- Aula 4 de 18: CASE WHEN WHEN... ELSE (Explica��o)

/*
CASE
	WHEN teste_logico1 THEN 'resultado1'
	WHEN teste_logico2 THEN 'resultado2'
	ELSE 'resultado3'
END

Exemplo 1:

Crie um c�digo para verificar a nota do aluno e determinar a situa��o:
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

-- Exemplo 2: Classifique o produto de acordo com o seu pre�o:
-- Pre�o >= 40000: Luxo
-- Pre�o >= 10000 e Pre�o < 40000: Econ�mico
-- Pre�o < 10000: B�sico

DECLARE @preco FLOAT = 1000
SELECT
	CASE
		WHEN @preco >= 40000 THEN '� um produto de Luxo'
		WHEN @preco >= 10000 THEN '� um produto Econ�mico'
		ELSE '� um produto B�sico'
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

-- [SQL Server] Fun��es Condicionais
-- Aula 6 de 18: CASE com os operadores l�gicos AND e OR

-- Fa�a uma consulta � tabela DimProduct e retorne as colunas ProductName, BrandName, ColorName, UnitPrice e uma coluna de pre�o com desconto.

-- a) Caso o produto seja da marca Contoso E da cor Red, o desconto do produto ser� de 10%. Caso contr�rio, n�o ter� nenhum desconto.


SELECT
	ProductName,
	BrandName,
	ColorName,
	UnitPrice,
	CASE
		WHEN BrandName = 'Contoso' AND ColorName = 'Red' THEN UnitPrice * 0.9
		ELSE 0
	END AS 'Pre�o com desconto'
FROM
	DimProduct


-- b) Caso o produto seja da marca Litware OU Fabrikam, ele receber� um desconto de 5%. Caso contr�rio, n�o ter� nenhum desconto.

SELECT
	ProductName,
	BrandName,
	ColorName,
	UnitPrice,
	CASE
		WHEN BrandName = 'Contoso' OR BrandName = 'Fabrikam' THEN CAST((UnitPrice * 0.95) AS decimal(10,2))
		ELSE 0
	END AS 'Pre�o com desconto'
FROM
	DimProduct


-- [SQL Server] Fun��es Condicionais
-- Aula 7 de 18: CASE Aninhado


-- DimEmployee
SELECT * FROM DimEmployee

-- 4 Cargos (Title):
-- Sales Group Manager
-- Sales Region Manager
-- Sales State Manager
-- Sales Store Manager

-- Assalariado (SalariedFlag)?
-- SalariedFlag = 0: n�o � assalariado
-- SalariedFlag = 1: � assalariado

-- Situa��o: C�lculo do b�nus
-- Sales Group Manager: Se for assalariado, 20%; Se n�o, 15%.
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
	END AS 'B�nus'
FROM
	DimEmployee
	where Title = 'Sales Group Manager'

-- [SQL Server] Fun��es Condicionais
-- Aula 8 de 18: CASE Aditivo

-- Os produtos da categoria 'TV and Video' ter�o um desconto de 10%
-- Se al�m de ser da categoria 'TV and Video', o produto for da subcategoria 'Televisions', receber� mais 5%. Total, 15%

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