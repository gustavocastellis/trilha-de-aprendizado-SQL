-- 1. Declare 4 variáveis inteiras. Atribua os seguintes valores a elas:
--valor1 = 10
--valor2 = 5
--valor3 = 34
--valor4 = 7
DECLARE
	@valor1 FLOAT = 10,
	@valor2 FLOAT = 5,
	@valor3 FLOAT = 34,
	@valor4 FLOAT = 7
-- a) Crie uma nova variável para armazenar o resultado da soma entre valor1 e valor2. Chame essa variável de soma.
DECLARE
	@soma FLOAT = @valor1 + @valor2
-- b) Crie uma nova variável para armazenar o resultado da subtração entre valor3 e valor 4. Chame essa variável de subtracao.
DECLARE
	@subtracao FLOAT = @valor3 - @valor4
-- c) Crie uma nova variável para armazenar o resultado da multiplicação entre o valor 1 e o valor4. Chame essa variável de multiplicacao.
DECLARE
	@multiplicacao FLOAT = @valor1 * @valor4
-- d) Crie uma nova variável para armazenar o resultado da divisão do valor3 pelo valor4. Chame essa variável de divisao. Obs: O resultado deverá estar em decimal, e não em inteiro.
DECLARE
	@divisao FLOAT = @valor3 / @valor4
-- e) Arredonde o resultado da letra d) para 2 casas decimais.
SELECT ROUND(@divisao,2,1)

--2. Para cada declaração das variáveis abaixo, atenção em relação ao tipo de dado que deverá ser especificado.
--a) Declare uma variável chamada ‘produto’ e atribua o valor de ‘Celular’.
DECLARE
	@produto VARCHAR(50) = 'Celular'

--b) Declare uma variável chamada ‘quantidade’ e atribua o valor de 12.
DECLARE
	@quantidade FLOAT = 12

--c) Declare uma variável chamada ‘preco’ e atribua o valor 9.99.
DECLARE
	@preco FLOAT = 9.99

--d) Declare uma variável chamada ‘faturamento’ e atribua o resultado da multiplicação entre ‘quantidade’ e ‘preco’.
DECLARE
	@faturamento FLOAT = @quantidade * @preco

--e) Visualize o resultado dessas 4 variáveis em uma única consulta, por meio do SELECT.
SELECT
	@produto as 'Produto',
	@quantidade as 'Quantidade',
	@preco as 'Preço',
	@faturamento as 'Faturamento'


--3. Você é responsável por gerenciar um banco de dados onde são recebidos dados externos de
--usuários. Em resumo, esses dados são:
--- Nome do usuário
--- Data de nascimento
--- Quantidade de pets que aquele usuário possui
--Você precisará criar um código em SQL capaz de juntar as informações fornecidas por este
--usuário. Para simular estes dados, crie 3 variáveis, chamadas: nome, data_nascimento e
--num_pets. Você deverá armazenar os valores ‘André’, ‘10/02/1998’ e 2, respectivamente.
--Dica: você precisará utilizar as funções CAST e FORMAT para chegar no resultado.

DECLARE
	@nome VARCHAR(50) = 'André',
	@data_nascimento DATETIME = '10/02/1998',
	@num_pets INT = 2
PRINT 'Meu nome é ' + @nome + ', nasci em ' + FORMAT(@data_nascimento, 'dd/MM/yyyy') + ' e tenho ' + CAST(@num_pets as VARCHAR) + ' pets'

--4. Você acabou de ser promovido e o seu papel será realizar um controle de qualidade sobre as
--lojas da empresa.
--A primeira informação que é passada a você é que o ano de 2008 foi bem complicado para a
--empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio é descobrir
--o nome dessas lojas que fecharam no ano de 2008, para que você possa entender o motivo e
--mapear planos de ação para evitar que outras lojas importantes tomem o mesmo caminho.
--O seu resultado deverá estar estruturado em uma frase, com a seguinte estrutura:
--‘As lojas fechadas no ano de 2008 foram: ’ + nome_das_lojas
--Obs: utilize o comando PRINT (e não o SELECT!) para mostrar o resultado.

DECLARE
	@listaLoja VARCHAR(100) = ''
SELECT 
	@listaLoja = @listaLoja + StoreName + ', '
FROM DimStore
WHERE CloseDate BETWEEN '20080101' and '20081231'   -- solução proposta pelo professor utilizar FORMAT(CloseDate, 'yyyy') = 2008
PRINT 'As lojas fechadas no ano de 2008 foram: ' + @listaLoja


--5. Você precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para
--uma subcategoria específica: ‘Lamps’.
--Utilize o conceito de variáveis para chegar neste resultado.

DECLARE 
	@listaProdutos VARCHAR(max) = ''
SELECT
	@listaProdutos = @listaProdutos + ProductName + CHAR(10)
FROM DimProduct dp
INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
WHERE ProductSubcategoryName = 'Lamps'
PRINT 'A lista de produtos da categoria Lamps é: ' + @listaProdutos

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
