Select 
a.name as Tabela, 
a.object_id, 
b.name as Coluna,
column_id
from DB_EDUCACAO_1_PRODAM.SE1426_SS.sys.tables a 
inner join DB_EDUCACAO_1_PRODAM.SE1426_SS.sys.columns b on a.object_id=b.object_id
--where a.name like '%CEU%'
--ou 
where b.name like '%SG_DISTRITO_MEC%'


select * from SME_ESCOLA where ENDERECO like '%INHAIBA%'

select * from SME_ESCOLA where COD_ESC ='007816'
