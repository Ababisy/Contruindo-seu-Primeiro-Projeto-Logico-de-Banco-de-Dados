-- criação de banco de dados para um cenário E-commerce

create database ecommerce;

use ecommerce;

-- criar tabela cliente
create table Cliente (
idCliente int auto_increment primary key not null,
Pnome varchar(10),
NmeioInicial varchar(3),
Sobrenome varchar(20),
CPF char(11) not null,
Endereço varchar(45),
DatadeNascimento date,
Contato varchar(50),
constraint unique_cpf_cliente unique (CPF)
);


desc Cliente;

-- criar tabela produto
create table Produto (
idProduto int auto_increment primary key,
Pnome varchar(10) not null,
CodigoProduto varchar(20),
Categoria_kids bool default false,
Descrição varchar(45),
Valor varchar(45) not null,
Avaliação float default 0
);


-- criar tabela ordem de pagamento
create table OrdemDePagamento (
idOrdemDePagamento int,
idPedido int,
idFormaDePagamento int,
idCliente int,
Valor varchar(45) not null,
ValorTotal varchar (45),
StatusPagamento enum('Aprovado', 'Em Processamento', 'Recusado') not null,
primary key (idFormaDePagamento, idOrdemDePagamento, idCliente)
);

-- criar tabela forma de pagamento
create table FormaDePagamento (
idFormaDePagamento int,
idOrdemDePagamento int,
idCliente int,
TipoDePagamento enum('Crédito', 'Débito', 'Dois cartões', 'Boleto', 'Pix'),
primary key(idFormaDePagamento, idOrdemDePagamento, idCliente)
);

-- criar tabela pedido
create table Pedido (
idCliente int,
idPedido int auto_increment primary key not null,
StatusDoPedido enum('Cancelado','Em andamento', 'Processando', 'Enviado', 'Entregue') default 'Processando',
Descrição varchar(255),
idPedidoCliente int,
Frete float default 0,
idOrdemDePagamento int,
constraint fk_Pedido_Cliente foreign key (idPedidoCliente) references Cliente (idCliente)
);

-- criar tabela estoque
create table Estoque (
idEstoque int auto_increment primary key,
Localização varchar(45),
Quantidade int default 0
);

-- criar tabela fornecedor
create table Fornecedor (
idFornecedor int auto_increment primary key,
Localização varchar(45),
RazãoSocial varchar(45) not null,
NomeFantasia varchar(45),
CNPJ char(14) not null,
Contato char (11) not null,
constraint unique_Fornecedor unique (CNPJ) 
);

-- criar tabela vendedor
create table Vendedor (
idVendedor int auto_increment primary key,
Localização varchar (45),
RazãoSocial varchar (45) not null,
NomeFantasia varchar(45),
CNPJ char(14) not null,
CPF char(11) not null,
constraint unique_CNPJ_Vendedor unique(CNPJ),
constraint unique_CPF_Vendedor unique(CPF)
);

-- criar tabela produtos por vendedor
create table ProdutosPorVendedor (
idProduto int,
idVendedor int,
idProdutoVendedor int,
Quantidade int default 1,
primary key (idProduto, idProdutoVendedor),
constraint fk_produto_vendedor foreign key (idProdutoVendedor) references Vendedor (idVendedor),
constraint fk_produto_produto foreign key (idProduto) references Produto (idProduto)
);

-- criar tabela produto por pedido
create table ProdutoPorPedido (
idProduto int,
idPedido int,
idVendedor int,
idProdutoVendedor int,
Quantidade int default 1,
StatusProduto enum('Disponível', 'Sem Estoque') default 'Disponível',
primary key (idProdutoVendedor, idPedido),
constraint fk_pedido_vendedor foreign key (idProdutoVendedor) references Vendedor (idVendedor),
constraint fk_pedido_produto foreign key (idPedido) references Pedido (idPedido)
);

-- criar tabela produto estoque
create table ProdutoEstoque(
idProduto int,
idEstoque int,
Localização varchar(100) not null,
primary key (idProduto, idEstoque),
constraint fk_estoque_vendedor foreign key (idProduto) references Produto (idProduto),
constraint fk_estoque_produto foreign key (idEstoque) references Pedido (idPedido)
);

-- criar tabela produtos por fornecedor
create table ProdutosPorFornecedor(
idProduto int,
idProdutoFornecedor int,
Quantidade int default 1,
primary key (idProduto, idProdutoFornecedor),
constraint fk_fornecedor_vendedor foreign key (idProdutoFornecedor) references Fornecedor(idFornecedor),
constraint fk_fornecedor_produto foreign key (idProduto) references Produto (idProduto)
);
 show tables;
 desc fornecedor;
 desc ordemdepagamento;
 desc pedido;