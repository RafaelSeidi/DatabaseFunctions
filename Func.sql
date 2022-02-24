create database aula_view;
use aula_view;

create table livros  (
isbn bigint primary key auto_increment,
titulo varchar(100) not null,
data_cadastro date not null,
valor_unitario decimal(7,2) 
)engine = innodb;

create table autores  (
cod_autor bigint primary key auto_increment,
nome_autor varchar(50) not null,
isbn bigint not null
)engine = innodb;

alter table autores
add constraint fk_livros_autores
foreign key (isbn)
references livros (isbn);

insert into livros (isbn,titulo,data_cadastro,valor_unitario) values
                  (9788415620785,'Gente Hoy 1. Libro del alumno','2020-08-15',100.00);
                  
insert into livros (isbn,titulo,data_cadastro,valor_unitario) values
                  (9788516100315,'Moderna Matemática Plus 1','2020-06-20',120.50);
                  
insert into livros (isbn,titulo,data_cadastro,valor_unitario) values
                  (9788508190010,'Geografia Geral e do Brasil','2019-12-10',89.50);
                  
insert into autores (cod_autor,nome_autor,isbn) values
                  (1 , ' Ernesto Martín',9788415620785);
                  
insert into autores (nome_autor,isbn) values
                  (' Manoel Paiva ',9788516100315);
insert into autores (nome_autor,isbn) values
                  (' João Carlos Moreira  ',9788508190010);
insert into autores (nome_autor,isbn) values
                  (' Eustáquio de Sene ',9788508190010);

show tables;

select * from livros;
select * from autores;

CREATE FUNCTION fnConv (a decimal(7,2), b bigint)
RETURNS varchar(100)
RETURN (SELECT CONCAT('O preço do livro ', titulo,' é ', valor_unitario/a) FROM livros WHERE isbn = b);

SELECT fnConv (5.29,9788415620785);

CREATE FUNCTION fnTit (b bigint)
RETURNS VARCHAR(60)
RETURN (SELECT CONCAT('O isbn do livro ', titulo, ' é ', isbn) FROM livros WHERE isbn = b);

SELECT fnTit(9788415620785); 

CREATE FUNCTION fnMed (a float, b float)
RETURNS float
RETURN (a + b)/2; 

SELECT fnMed (4,4) AS Resultado;

select Nome_Produto, Data_Compra from Compra inner join Produto on Compra.Cod_Compra = Produto.Cod_Produto where MONTH(Data_Compra) = '01';

DELIMITER $
CREATE FUNCTION fnData(a date) RETURNS CHAR(200)
BEGIN
DECLARE txt CHAR(200);
SET @dataCadastro = (SELECT data_cadastro FROM livros);

IF @dataCadastro = a THEN
SET txt = ('O livro cadastrado nesse dia foi ', titulo);

ELSE
SET txt = ('Não foram cadastrados livros nesse dia ', data_cadastro);

END IF;

RETURN (SELECT CONCAT(txt) FROM livros);
END 
$

SELECT fnData('2020-08-15');