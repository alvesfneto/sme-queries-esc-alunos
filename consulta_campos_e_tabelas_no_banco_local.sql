Select 
a.name as Tabela, 
a.object_id, 
b.name as Coluna,
column_id
from [DB_EDUCACAO_1_PRODAM].[escola].sys.tables a 
inner join [DB_EDUCACAO_1_PRODAM].[escola].sys.columns b on a.object_id=b.object_id
--where a.name like 'SME_%'
--ou 
where b.name like '%SUS%'

Select 
a.name as Tabela, 
a.object_id, 
b.name as Coluna,
column_id
from [DB_EDUCACAO_1_PRODAM].[SE1426].sys.tables a 
inner join [DB_EDUCACAO_1_PRODAM].[SE1426].sys.columns b on a.object_id=b.object_id
--where a.name like 'SME_%'
--ou 
where b.name  LIKE '%SUS%'









Select 
name as Tabela, 
object_id 

from sys.tables
WHERE name like 'SME_%' ORDER BY 1
 

 SELECT * FROM D_DISPOSITIVO_COMUNICACAO_UNIDADE


