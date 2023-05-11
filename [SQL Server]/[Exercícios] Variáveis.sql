-- 1. Declare 4 vari�veis inteiras. Atribua os seguintes valores a elas:
--valor1 = 10
--valor2 = 5
--valor3 = 34
--valor4 = 7
DECLARE
	@valor1 FLOAT = 10,
	@valor2 FLOAT = 5,
	@valor3 FLOAT = 34,
	@valor4 FLOAT = 7
-- a) Crie uma nova vari�vel para armazenar o resultado da soma entre valor1 e valor2. Chame essa vari�vel de soma.
DECLARE
	@soma FLOAT = @valor1 + @valor2
-- b) Crie uma nova vari�vel para armazenar o resultado da subtra��o entre valor3 e valor 4. Chame essa vari�vel de subtracao.
DECLARE
	@subtracao FLOAT = @valor3 - @valor4
-- c) Crie uma nova vari�vel para armazenar o resultado da multiplica��o entre o valor 1 e o valor4. Chame essa vari�vel de multiplicacao.
DECLARE
	@multiplicacao FLOAT = @valor1 * @valor4
-- d) Crie uma nova vari�vel para armazenar o resultado da divis�o do valor3 pelo valor4. Chame essa vari�vel de divisao. Obs: O resultado dever� estar em decimal, e n�o em inteiro.
DECLARE
	@divisao FLOAT = @valor3 / @valor4
-- e) Arredonde o resultado da letra d) para 2 casas decimais.
SELECT ROUND(@divisao,2,1)

--2. Para cada declara��o das vari�veis abaixo, aten��o em rela��o ao tipo de dado que dever� ser especificado.
--a) Declare uma vari�vel chamada �produto� e atribua o valor de �Celular�.
DECLARE
	@produto VARCHAR(50) = 'Celular'

--b) Declare uma vari�vel chamada �quantidade� e atribua o valor de 12.
DECLARE
	@quantidade FLOAT = 12

--c) Declare uma vari�vel chamada �preco� e atribua o valor 9.99.
DECLARE
	@preco FLOAT = 9.99

--d) Declare uma vari�vel chamada �faturamento� e atribua o resultado da multiplica��o entre �quantidade� e �preco�.
DECLARE
	@faturamento FLOAT = @quantidade * @preco

--e) Visualize o resultado dessas 4 vari�veis em uma �nica consulta, por meio do SELECT.
SELECT
	@produto as 'Produto',
	@quantidade as 'Quantidade',
	@preco as 'Pre�o',
	@faturamento as 'Faturamento'


--3. Voc� � respons�vel por gerenciar um banco de dados onde s�o recebidos dados externos de
--usu�rios. Em resumo, esses dados s�o:
--- Nome do usu�rio
--- Data de nascimento
--- Quantidade de pets que aquele usu�rio possui
--Voc� precisar� criar um c�digo em SQL capaz de juntar as informa��es fornecidas por este
--usu�rio. Para simular estes dados, crie 3 vari�veis, chamadas: nome, data_nascimento e
--num_pets. Voc� dever� armazenar os valores �Andr�, �10/02/1998� e 2, respectivamente.
--Dica: voc� precisar� utilizar as fun��es CAST e FORMAT para chegar no resultado.

DECLARE
	@nome VARCHAR(50) = 'Andr�',
	@data_nascimento DATETIME = '10/02/1998',
	@num_pets INT = 2
PRINT 'Meu nome � ' + @nome + ', nasci em ' + FORMAT(@data_nascimento, 'dd/MM/yyyy') + ' e tenho ' + CAST(@num_pets as VARCHAR) + ' pets'

--4. Voc� acabou de ser promovido e o seu papel ser� realizar um controle de qualidade sobre as
--lojas da empresa.
--A primeira informa��o que � passada a voc� � que o ano de 2008 foi bem complicado para a
--empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio � descobrir
--o nome dessas lojas que fecharam no ano de 2008, para que voc� possa entender o motivo e
--mapear planos de a��o para evitar que outras lojas importantes tomem o mesmo caminho.
--O seu resultado dever� estar estruturado em uma frase, com a seguinte estrutura:
--�As lojas fechadas no ano de 2008 foram: � + nome_das_lojas
--Obs: utilize o comando PRINT (e n�o o SELECT!) para mostrar o resultado.

DECLARE
	@listaLoja VARCHAR(100) = ''
SELECT 
	@listaLoja = @listaLoja + StoreName + ', '
FROM DimStore
WHERE CloseDate BETWEEN '20080101' and '20081231'   -- solu��o proposta pelo professor utilizar FORMAT(CloseDate, 'yyyy') = 2008
PRINT 'As lojas fechadas no ano de 2008 foram: ' + @listaLoja


--5. Voc� precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para
--uma subcategoria espec�fica: �Lamps�.
--Utilize o conceito de vari�veis para chegar neste resultado.

DECLARE 
	@listaProdutos VARCHAR(max) = ''
SELECT
	@listaProdutos = @listaProdutos + ProductName + CHAR(10)
FROM DimProduct dp
INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
WHERE ProductSubcategoryName = 'Lamps'
PRINT 'A lista de produtos da categoria Lamps �: ' + @listaProdutos

-- utilizando as variaveis para consulta direta
DECLARE
	@nomeProduto VARCHAR(100),
	@idSubCategory INT
SET @nomeProduto = 'Lamps'
SET @idSubCategory = (SELECT ProductSubcategoryKey FROM DimProductSubcategory WHERE ProductSubcategoryName = @nomeProduto)
SELECT 
	ProductName
FROM DimProduct
WHERE ProductSubcategoryKey = @idSubCategory
