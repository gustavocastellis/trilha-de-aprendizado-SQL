--1. a) A partir da tabela DimProduct, crie uma View contendo as informa��es de
--ProductName, ColorName, UnitPrice e UnitCost, da tabela DimProduct. Chame essa View
--de vwProdutos.
GO
CREATE VIEW vwProdutos AS 
SELECT
	ProductName AS 'Nome do Produto',
	ColorName AS 'Cor',
	UnitPrice AS 'Pre�o',
	UnitCost AS 'Custo'
FROM DimProduct
GO
SELECT * FROM vwProdutos
--b) A partir da tabela DimEmployee, crie uma View mostrando FirstName, BirthDate,
--DepartmentName. Chame essa View de vwFuncionarios.
CREATE VIEW vwFuncionarios AS
SELECT
	FirstName AS 'Nome',
	BirthDate AS 'Data de Nascimento',
	DepartmentName AS 'Departamento'
FROM DimEmployee
SELECT * FROM vwFuncionarios
GO
--c) A partir da tabela DimStore, crie uma View mostrando StoreKey, StoreName e
--OpenDate. Chame essa View de vwLojas.
CREATE VIEW vwLojas AS 
SELECT
	StoreKey AS 'Id da Loja',
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de Abertura'
FROM DimStore
SELECT * FROM vwLojas


--2. Crie uma View contendo as informa��es de Nome Completo (FirstName +
--LastName), G�nero (por extenso), E-mail e Renda Anual (formatada com R$).
--Utilize a tabela DimCustomer. Chame essa View de vwClientes.
CREATE VIEW vwClientes AS 
SELECT
	CONCAT(FirstName, ' ', LastName) as 'Nome Completo',
	REPLACE(REPLACE(Gender,'M','Masculino'), 'F', 'Feminino') AS 'G�nero',
	EmailAddress AS 'Email',
	FORMAT(YearlyIncome, 'C') AS 'Renda Anual'
FROM DimCustomer

SELECT * FROM vwClientes


--3. a) A partir da tabela DimStore, crie uma View que considera apenas as lojas ativas. Fa�a
--um SELECT de todas as colunas. Chame essa View de vwLojasAtivas.
CREATE VIEW vwLojasAtivas AS
SELECT * FROM DimStore
WHERE Status = 'On'

SELECT * FROM vwLojasAtivas

--b) A partir da tabela DimEmployee, crie uma View de uma tabela que considera apenas os
--funcion�rios da �rea de Marketing. Fa�a um SELECT das colunas: FirstName, EmailAddress
--e DepartmentName. Chame essa de vwFuncionariosMkt.
CREATE VIEW vwFuncionariosMkt AS
SELECT
	FirstName,
	EmailAddress,
	DepartmentName
FROM DimEmployee
WHERE DepartmentName = 'Marketing'

SELECT * FROM vwFuncionariosMkt

--c) Crie uma View de uma tabela que considera apenas os produtos das marcas Contoso e
--Litware. Al�m disso, a sua View deve considerar apenas os produtos de cor Silver. Fa�a
--um SELECT de todas as colunas da tabela DimProduct. Chame essa View de
--vwContosoLitwareSilver.
CREATE VIEW vwContosoLitwareSilver AS
SELECT
	*
FROM DimProduct
WHERE BrandName IN ('Contoso', 'Litware') AND ColorName = 'Silver'

SELECT * FROM vwContosoLitwareSilver

--4. Crie uma View que seja o resultado de um agrupamento da tabela FactSales. Este
--agrupamento deve considerar o SalesQuantity (Quantidade Total Vendida) por Nome do
--Produto. Chame esta View de vwTotalVendidoProdutos.
--OBS: Para isso, voc� ter� que utilizar um JOIN para relacionar as tabelas FactSales e
--DimProduct.
CREATE VIEW vwTotalVendidoProdutos AS
SELECT
	ProductName AS 'Nome do Produto',
	SUM(SalesQuantity) AS 'Qtd. Vendida'
FROM FactSales fs
INNER JOIN DimProduct ds ON fs.ProductKey = ds.ProductKey
GROUP BY ProductName

SELECT * FROM vwTotalVendidoProdutos

--5. Fa�a as seguintes altera��es nas tabelas da quest�o 1.
--a. Na View criada na letra a da quest�o 1, adicione a coluna de BrandName.
ALTER VIEW vwProdutos AS
SELECT
	ProductName AS 'Nome do Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	UnitPrice AS 'Pre�o Unit�rio',
	UnitCost AS 'Custo Unit�rio'
FROM DimProduct

SELECT * FROM vwProdutos
--b. Na View criada na letra b da quest�o 1, fa�a um filtro e considere apenas os
--funcion�rios do sexo feminino.
ALTER VIEW vwFuncionarios AS 
SELECT
	FirstName AS 'Nome',
	BirthDate AS 'Data de Nascimento',
	DepartmentName AS 'Departamento'
FROM DimEmployee
WHERE Gender = 'F'

SELECT * FROM vwFuncionarios

--c. Na View criada na letra c da quest�o 1, fa�a uma altera��o e filtre apenas as lojas
--ativas.
ALTER VIEW vwLojas AS 
SELECT
	StoreKey AS 'Id da Loja',
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de Abertura'
FROM DimStore
WHERE Status = 'On'

SELECT * FROM vwLojas


--6. a) Crie uma View que seja o resultado de um agrupamento da tabela DimProduct. O
--resultado esperado da consulta dever� ser o total de produtos por marca. Chame essa
--View de vw_6a.
CREATE VIEW vw_6a AS 
SELECT
	BrandName AS 'Marca',
	COUNT(*) AS 'Qtd. Produtos'
FROM DimProduct
GROUP BY BrandName

SELECT * FROM vw_6a

--b) Altere a View criada no exerc�cio anterior, adicionando o peso total por marca. Aten��o:
--sua View final dever� ter ent�o 3 colunas: Nome da Marca, Total de Produtos e Peso Total.
ALTER VIEW vw_6a AS
SELECT
	BrandName AS 'Marca',
	COUNT(*) AS 'Qtd. Produtos',
	SUM(Weight) AS 'Peso Total'
FROM DimProduct
GROUP BY BrandName

SELECT * FROM vw_6a

--c) Exclua a View vw_6a.
DROP VIEW vw_6a