-- Exerc�cios foram realizados sobre o banco de dados Contoso da Microsoft.

/*1. Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela DimProductSubcategory para a tabela DimProduct. */
SELECT
	dp.ProductKey,
	dp.ProductName,
	dp.ClassName,
	dps.ProductSubcategoryName
FROM DimProduct dp
INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey;


/* 2. Identifique uma coluna em comum entre as tabelas DimProductSubcategory e
DimProductCategory. Utilize essa coluna para complementar informa��es na tabela
DimProductSubcategory a partir da DimProductCategory. Utilize o LEFT JOIN. */
SELECT
	*
FROM DimProductSubcategory dps
LEFT JOIN DimProductCategory dpg ON dps.ProductCategoryKey = dpg.ProductCategoryKey;


/* 3. Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do Pa�s associados
(de acordo com DimGeography). Seu SELECT final deve conter apenas as seguintes colunas:
StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName. Utilize o LEFT JOIN neste exerc�cio. */
SELECT
	ds.StoreKey,
	ds.StoreName,
	ds.EmployeeCount,
	dg.ContinentName,
	dg.RegionCountryName
FROM DimStore ds
LEFT JOIN DimGeography dg ON ds.GeographyKey = dg.GeographyKey
ORDER BY ds.StoreKey;


/* 4. Complementa a tabela DimProduct com a informa��o de ProductCategoryDescription. Utilize
o LEFT JOIN e retorne em seu SELECT apenas as 5 colunas que considerar mais relevantes. */
SELECT
	dp.ProductKey,
	dp.ProductName,
	dp.BrandName,
	dp.ClassName,
	dp.UnitPrice,
	dpc.ProductCategoryDescription
FROM DimProduct dp
LEFT JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
LEFT JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey;


/* 5. A tabela FactStrategyPlan resume o planejamento estrat�gico da empresa. Cada linha
representa um montante destinado a uma determinada AccountKey.
a) Fa�a um SELECT das 100 primeiras linhas de FactStrategyPlan para reconhecer a tabela.
b) Fa�a um INNER JOIN para criar uma tabela contendo o AccountName para cada
AccountKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas:
� StrategyPlanKey
� DateKey
� AccountName
� Amount */
SELECT TOP(100)
	*
FROM FactStrategyPlan;

SELECT 
	fsp.StrategyPlanKey,
	fsp.Datekey,
	da.AccountName,
	fsp.Amount
FROM FactStrategyPlan fsp
INNER JOIN DimAccount da ON fsp.AccountKey = da.AccountKey;


/* 6. Vamos continuar analisando a tabela FactStrategyPlan. Al�m da coluna AccountKey que
identifica o tipo de conta, h� tamb�m uma outra coluna chamada ScenarioKey. Essa coluna
possui a numera��o que identifica o tipo de cen�rio: Real, Or�ado e Previs�o.
Fa�a um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey
da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas:
� StrategyPlanKey
� DateKey
� ScenarioName
� Amount  */
SELECT 
	fsp.StrategyPlanKey,
	fsp.Datekey,
	ds.ScenarioName,
	fsp.Amount
FROM FactStrategyPlan fsp
INNER JOIN DimScenario ds ON fsp.ScenarioKey = ds.ScenarioKey;


/*  7. Algumas subcategorias n�o possuem nenhum exemplar de produto. Identifique que
subcategorias s�o essas.  */
SELECT
	*
FROM DimProductSubcategory dps
LEFT JOIN DimProduct dp ON dps.ProductSubcategoryKey = dp.ProductSubcategoryKey
WHERE dp.ProductKey IS NULL


/* 8. A tabela abaixo mostra a combina��o entre Marca e Canal de Venda, para as marcas Contoso,
Fabrikam e Litware. Crie um c�digo SQL para chegar no mesmo resultado. */
SELECT DISTINCT
	BrandName,
	ChannelName
FROM DimProduct
CROSS JOIN DimChannel
WHERE BrandName IN ('Contoso','Fabrikam','Litware')


/* 9. Neste exerc�cio, voc� dever� relacionar as tabelas FactOnlineSales com DimPromotion.
Identifique a coluna que as duas tabelas t�m em comum e utilize-a para criar esse
relacionamento.
Retorne uma tabela contendo as seguintes colunas:
� OnlineSalesKey
� DateKey
� PromotionName
� SalesAmount
A sua consulta deve considerar apenas as linhas de vendas referentes a produtos com
desconto (PromotionName <> �No Discount�). Al�m disso, voc� dever� ordenar essa tabela de
acordo com a coluna DateKey, em ordem crescente. */
SELECT
	OnlineSalesKey,
	DateKey,
	PromotionName,
	SalesAmount
FROM FactOnlineSales fos
INNER JOIN DimPromotion dp ON fos.PromotionKey = dp.PromotionKey
WHERE dp.PromotionName <> 'No Discount'
ORDER BY fos.DateKey;


/* 10. A tabela abaixo � resultado de um Join entre a tabela FactSales e as tabelas: DimChannel,
DimStore e DimProduct.
Recrie esta consulta e classifique em ordem crescente de acordo com SalesAmount. */
SELECT
	fs.SalesKey,
	dc.ChannelName,
	ds.StoreName,
	dp.ProductName,
	fs.SalesAmount
FROM FactSales fs
INNER JOIN DimChannel dc ON	fs.channelKey = dc.ChannelKey
INNER JOIN DimStore ds ON fs.StoreKey = ds.StoreKey
INNER JOIN DimProduct dp ON fs.ProductKey = dp.ProductKey
ORDER BY fs.SalesAmount