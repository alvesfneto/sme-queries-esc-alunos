------------------------------------------------------------------
-- 3 formas de numerar um select
------------------------------------------------------------------
--------------------------------------------------
-- Banco de dados para nosso teste
--------------------------------------------------

--https://dba-pro.com/incluir-numeros-nas-linhas-do-select/ -->FONTE
-- Banco de testes
use master
if db_id('curso') is not null
    drop database curso
go
create database curso
go
use curso
go
-- Criar carga de testes
create table produtos (
    nm varchar(100),
    vl decimal(10,2),
    ic_ativo bit not null default (1)
)
insert into produtos (nm, vl) values
    ('Mouse Gammer 25 botões', 200),
    ('Teclado Gammer 350 teclas', 300),
    ('Monitor 32 Pol Full HD', 1000),
    ('RAM DDR4 4GB Powerturbo', 500),
    ('CPU Nasa 10Ghz', 2000),
    ('HD SSD 1TB', 2000)
 
 
-- SELECT PADRÃO (possui números de linhas, mas não podemos copiar para outros locais)
select * from produtos
 
 
--------------------------------------------------
-- row_number(): SQL2005+
--------------------------------------------------
select
    row_number() over (order by (select null)) linha,
    *
from produtos
 
--------------------------------------------------
-- identity: SQL2005-
--------------------------------------------------
select
    identity(smallint, 1, 1) 'linha',
    *
into #produtos_id
from produtos
 
select * from #produtos_id
 
drop table #produtos_id
 
--------------------------------------------------
-- Sequence: SQL2012+
--------------------------------------------------
-- Criando sequencia
if object_id('sLinhas') is not null drop sequence sLinhas
create sequence sLinhas as int start with 19741
 
select
    next value for sLinhas as Linha,
    *
from produtos
 