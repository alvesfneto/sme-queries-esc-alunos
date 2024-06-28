Select 
a.name as Tabela, 
a.object_id, 
b.name as Coluna,
column_id
from sys.tables a 
inner join sys.columns b on a.object_id=b.object_id
where a.name like 'M_%'
--ou 
--where b.name like 'ST_TURMA_ESCOLA'

Select 
name as Tabela, 
object_id 

from sys.tables
WHERE name like 'M_%' ORDER BY 1
 


