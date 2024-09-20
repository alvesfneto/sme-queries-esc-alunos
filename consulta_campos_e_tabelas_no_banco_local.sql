Select 
a.name as Tabela, 
a.object_id, 
b.name as Coluna,
column_id
from sys.tables a 
inner join sys.columns b on a.object_id=b.object_id
--where a.name like 'SME_%'
--ou 
where b.name like 'CD_grupo_ambiente%'

Select 
name as Tabela, 
object_id 

from sys.tables
WHERE name like 'SME_%' ORDER BY 1
 

 SELECT * FROM D_DISPOSITIVO_COMUNICACAO_UNIDADE


