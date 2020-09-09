CREATE TABLE Endereço+Cliente/Usuário(
UF Texto(2),
Cidade Texto(30),
CEP Número(7),
Número Número,
Bairro Texto(20),
Logradouro Texto(30),
Complemento Texto(50),
Código Número,
Nome_Usuário Texto(15),
Nome Texto(30),
Telefone_Residencial Texto(11),
CPF Número(11),
Telefone_Celular Texto(11),
Senha Texto(10),
E-mail Texto(30),
Telefone_Comercial Texto(11),
PRIMARY KEY(Código,E-mail)
);

CREATE TABLE Foto (
Código Número(10) PRIMARY KEY,
Imagem Texto(1),
-- Erro: nome do campo duplicado nesta tabela!
Código Número(10)
)

CREATE TABLE Fabricante (
Nome Texto(30),
Código Número(4) PRIMARY KEY
)

CREATE TABLE Produto (
Nome Texto(30),
Descrição Texto(150),
Código Número(10) PRIMARY KEY,
Quantidade Número(4),
Preço Número(8,2),
-- Erro: nome do campo duplicado nesta tabela!
Código Número(4),
Codigo Número(2),
FOREIGN KEY(Código) REFERENCES Fabricante (Código)
)

CREATE TABLE Categoria (
Nome Texto(30),
Codigo Número(2) PRIMARY KEY
)

CREATE TABLE Pedido+Nota_Fiscal (
Código Número PRIMARY KEY,
Valor_Frete Número(8,2),
Situação Texto(20),
Data_Validade Data,
Desconto Número(8,2),
Data_Pagamento Data,
Data_Hora Data/Hora,
Data_enetrega_prevista Data,
-- Erro: nome do campo duplicado nesta tabela!
Código Número,
E-mail Texto(30),
-- Erro: nome do campo duplicado nesta tabela!
Código Número,
-- Erro: nome do campo duplicado nesta tabela!
E-mail Texto(30),
-- Erro: nome do campo duplicado nesta tabela!
Código Número(2),
Número Número,
Data_emissao Data,
-- Erro: nome do campo duplicado nesta tabela!
Código Número,
FOREIGN KEY(/*erro: ??*/) REFERENCES Endereço+Cliente/Usuário (Código,E-mail)
)

CREATE TABLE Forma_Pagamento (
Código Número(2) PRIMARY KEY,
Taxa_Juros Número(6,2),
Nome Texto(20)
)

CREATE TABLE Funcionário (
Usuário Texto(15),
Código Número PRIMARY KEY,
Senha Texto(10)
)

CREATE TABLE Produto_Pedido (
Preco_Venda Número(8,2),
Quantidade_Vendida Número(4),
Código Número(10),
-- Erro: nome do campo duplicado nesta tabela!
Código Número,
FOREIGN KEY(Código) REFERENCES Produto (Código),
FOREIGN KEY(Código) REFERENCES Pedido+Nota_Fiscal (Código)
)

ALTER TABLE Foto ADD FOREIGN KEY(Código) REFERENCES Produto (Código)
ALTER TABLE Produto ADD FOREIGN KEY(Codigo) REFERENCES Categoria (Codigo)
ALTER TABLE Pedido+Nota_Fiscal ADD FOREIGN KEY(Código) REFERENCES Forma_Pagamento (Código)
ALTER TABLE Pedido+Nota_Fiscal ADD FOREIGN KEY(Código) REFERENCES Funcionário (Código)