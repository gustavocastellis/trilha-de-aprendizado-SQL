--MÓDULO 11: EXERCÍCIOS

--1. O setor de vendas decidiu aplicar um desconto aos produtos de acordo com a sua classe. O
--percentual aplicado deverá ser de:
--Economy -> 5%
--Regular -> 7%
--Deluxe -> 9%
--a) Faça uma consulta à tabela DimProduct que retorne as seguintes colunas: ProductKey,
--ProductName, e outras duas colunas que deverão retornar o % de Desconto e UnitPrice com
--desconto.
select * from DimProduct
SELECT
	ProductKey,
	ProductName,
	CASE 
		WHEN ClassName
FROM DimProduct
--b) Faça uma adaptação no código para que os % de desconto de 5%, 7% e 9% sejam facilmente
--modificados (dica: utilize variáveis).




--2. Você ficou responsável pelo controle de produtos da empresa e deverá fazer uma análise da
--quantidade de produtos por Marca.
--A divisão das marcas em categorias deverá ser a seguinte:
--CATEGORIA A: Mais de 500 produtos
--CATEGORIA B: Entre 100 e 500 produtos
--CATEGORIA C: Menos de 100 produtos
--Faça uma consulta à tabela DimProduct e retorne uma tabela com um agrupamento de Total de
--Produtos por Marca, além da coluna de Categoria, conforme a regra acima.

--3. Será necessário criar uma categorização de cada loja da empresa considerando a quantidade de
--funcionários de cada uma. A lógica a ser seguida será a lógica abaixo:

--EmployeeCount >= 50; 'Acima de 50 funcionários'
--EmployeeCount >= 40; 'Entre 40 e 50 funcionários'
--EmployeeCount >= 30; 'Entre 30 e 40 funcionários'
--EmployeeCount >= 20; 'Entre 20 e 30 funcionários'
--EmployeeCount >= 40; 'Entre 10 e 20 funcionários'
--Caso contrário: 'Abaixo de 10 funcionários'

--Faça uma consulta à tabela DimStore que retorne as seguintes informações: StoreName,
--EmployeeCount e a coluna de categoria, seguindo a regra acima.

--4. O setor de logística deverá realizar um transporte de carga dos produtos que estão no depósito
--de Seattle para o depósito de Sunnyside.
--Não se tem muitas informações sobre os produtos que estão no depósito, apenas se sabe que
--existem 100 exemplares de cada Subcategoria. Ou seja, 100 laptops, 100 câmeras digitais, 100
--ventiladores, e assim vai.
--O gerente de logística definiu que os produtos serão transportados por duas rotas distintas. Além
--disso, a divisão dos produtos em cada uma das rotas será feita de acordo com as subcategorias (ou
--seja, todos os produtos de uma mesma subcategoria serão transportados pela mesma rota):
--Rota 1: As subcategorias que tiverem uma soma total menor que 1000 kg deverão ser
--transportados pela Rota 1.
--Rota 2: As subcategorias que tiverem uma soma total maior ou igual a 1000 kg deverão ser
--transportados pela Rota 2.
--Você deverá realizar uma consulta à tabela DimProduct e fazer essa divisão das subcategorias por
--cada rota. Algumas dicas:
--- Dica 1: A sua consulta deverá ter um total de 3 colunas: Nome da Subcategoria, Peso Total e Rota.
--- Dica 2: Como não se sabe quais produtos existem no depósito, apenas que existem 100
--exemplares de cada subcategoria, você deverá descobrir o peso médio de cada subcategoria e
--multiplicar essa média por 100, de forma que você descubra aproximadamente qual é o peso total
--dos produtos por subcategoria.
--- Dica 3: Sua resposta final deverá ter um JOIN e um GROUP BY.

--5. O setor de marketing está com algumas ideias de ações para alavancar as vendas em 2021. Uma
--delas consiste em realizar sorteios entre os clientes da empresa.
--Este sorteio será dividido em categorias:
--‘Sorteio Mãe do Ano’: Nessa categoria vão participar todas as mulheres com filhos.
--‘Sorteio Pai do Ano’: Nessa categoria vão participar todos os pais com filhos.
--‘Caminhão de Prêmios’: Nessa categoria vão participar todas os demais clientes (homens e
--mulheres sem filhos).
--Seu papel será realizar uma consulta à tabela DimCustomer e retornar 3 colunas:
--- FirstName AS ‘Nome’
--- Gender AS ‘Sexo’
--- TotalChildren AS ‘Qtd. Filhos’
--- EmailAdress AS ‘E-mail’
--- Ação de Marketing: nessa coluna você deverá dividir os clientes de acordo com as categorias
--‘Sorteio Mãe do Ano’, ‘Sorteio Pai do Ano’ e ‘Caminhão de Prêmios’.

--6. Descubra qual é a loja que possui o maior tempo de atividade (em dias). Você deverá fazer essa
--consulta na tabela DimStore, e considerar a coluna OpenDate como referência para esse cálculo.
--Atenção: lembre-se que existem lojas que foram fechadas.

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


-- [SQL Server] Funções Condicionais
-- Aula 9 de 18: IIF (Alternativa ao CASE)

-- Exemplo 1: Qual é a categoria de risco do projeto abaixo, de acordo com a sua nota:
-- Risco Alto: Classicacao >= 5
-- Risco Baixo: Classificacao < 5
DECLARE @varClassificacao int = 9
SELECT
	IIF(
		@varClassificacao >= 5,
		'Risco Alto',
		'Risco Baixo'
		)

-- Exemplo 2: Crie uma coluna única de 'Cliente', contendo o nome do cliente, seja ele uma pessoa ou uma empresa. Traga também a coluna de CustomerKey e CustomerType.
SELECT
	CustomerKey,
	CustomerType,
	IIF(
		CustomerType = 'Person',
		FirstName,
		CompanyName) AS 'Cliente'
FROM
	DimCustomer


-- [SQL Server] Funções Condicionais
-- Exemplo: Existem 3 tipos de estoque: High, Mid e Low. Faça um SELECT contendo as colunas de ProductKey, ProductName, StockTypeName e Nome do responsável pelo produto, de acordo com o tipo de estoque. A regra deverá ser a seguinte:
-- João é responsável pelos produtos High
-- Maria é responsável pelos produtos Mid
-- Luis é responsável pelos produtos Low
SELECT
	ProductKey,
	ProductName,
	StockTypeName,
	IIF(StockTypeName = 'High', 'João',IIF(StockTypeName = 'Mid', 'Maria','Luis'))
FROM DimProduct

-- [SQL Server] Funções Condicionais
-- Aula 11 de 18: ISNULL - Tratando valores nulos
-- Exemplo: Faça uma consulta que substitua todos os valores nulos de CityName da tabela DimGeography pelo texto 'Local desconhecido'.
SELECT
ISNULL(CityName,'Local desconhecido')

FROM DimGeography
