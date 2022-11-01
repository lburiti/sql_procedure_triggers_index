-- criação do banco de dados para o cenário de E-commerce
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela cliente
-- desc clients;
create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(30),
        constraint unique_cpf_client unique(CPF)
);

alter table clients auto_increment=1;

-- criar tabela produto

-- size = dimensão do produto
create table product(
		idProduct int auto_increment primary key,
        PName varchar(10) not null,
        classification_kids bool default false,
        category enum('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
        avaliation float default 0,
        size varchar(10)
);

alter table product auto_increment=1;


-- criar tabela payments
-- para ser continuado no desafio: terminar de implementar

create table payments(
		idClient int,
        id_payment int,
        typePayment enum('Boleto', 'Cartão', 'Dois Cartões'),
        limiteAvailable float,
        primary key(idClient, id_payment)
);

drop table payments;
-- criar tabela pedido

create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
        orderDescription varchar(255),
        sendValue float default 10,
        paymentCash boolean default false,
        -- idPayment int,
        -- constraint fk_orders_payment foreign key(idPayment) references payments(id_payment),
        constraint fk_orders_client foreign key(idOrderClient) references clients(IdClient)
				on update cascade	
);

alter table orders auto_increment=1;

-- drop table orders;
desc orders;
-- criar tabela estoque

create table productStorage(
		idProductStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantify int default 0        
);

alter table productStorage auto_increment=1;


-- criar tabela fornecedor

create table supplier(
		idSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15)not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

alter table supplier auto_increment=1;

desc supplier;
-- criar tabela vendedor

create table seller(
		idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15)not null,
        CPF char(9)not null,
        location varchar(255),
        contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
);

alter table seller auto_increment=1;

create table productSeller(
		idPseller int,
        idPproduct int,
        prodQuantity int default 1,
        primary key(idPseller, idPproduct),
        constraint fk_product_seller foreign key(idPseller) references seller(idSeller),
        constraint fk_product_product foreign key(idPproduct) references product(idProduct)
);

-- desc productSeller;

create table productOrder(
		idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum('Disponível', 'Sem Estoque') default 'Disponível',
        primary key(idPOproduct, idPOorder),
        constraint fk_productorder_seller foreign key(idPOproduct) references product(idProduct),
        constraint fk_productorder_product foreign key(idPOorder) references orders(idOrder)
);


create table storageLocation(
		idLproduct int,
        idLstorage int,
        location varchar(255) not null,
        primary key(idLproduct, idLstorage),
        constraint fk_storage_location_product foreign key(idLproduct) references product(idProduct),
        constraint fk_storage_location_storage foreign key(idLstorage) references productStorage(idProductStorage)
);

create table productSupplier(
		idPsSupplier int,
        idPsProduct int,
        quantity int not null,
        primary key(idPsSupplier, idPsProduct),
        constraint fk_product_supplier_supplier foreign key(idPsSupplier) references supplier(idSupplier),
        constraint fk_product_supplier_prodcut foreign key(idPsProduct) references product(idProduct)
);

-- desc productSupplier;

show tables;

-- use information_schema;

-- show tables;

-- desc referential_constraints

-- select * from referential_constraints
-- where unique_constraint_schema = 'ecommerce';