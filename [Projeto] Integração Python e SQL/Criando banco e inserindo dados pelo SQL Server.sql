-- Projeto integração Python e SQL 
CREATE DATABASE PythonSQL
USE PythonSQL

CREATE TABLE Vendas(
	id INT IDENTITY(1,1) PRIMARY KEY,
	data_venda DATE,
	cliente VARCHAR(100),
	produto VARCHAR(100),
	preco DECIMAL(10,2),
	quantidade INT  )

INSERT INTO Vendas VALUES ('22/04/2022','Ana','Celular',1890,1)
INSERT INTO Vendas VALUES ('22/04/2022','Hiadyna','Celular',1000,1)
INSERT INTO Vendas VALUES ('22/04/2022','Maria','Celular',800,1)
INSERT INTO Vendas VALUES ('22/04/2022','Gustavo','Celular',5000,1)
INSERT INTO Vendas VALUES ('22/04/2022','João','Celular',3000,1)
INSERT INTO Vendas VALUES ('22/04/2022','Carlos','Celular',1500,1)

SELECT * FROM Vendas

select @@SERVERNAME