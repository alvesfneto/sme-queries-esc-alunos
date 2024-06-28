select 
sg_uf as 'UF',
COUNT(nm_municipio) as 'qt_municipios'
from d_municipio
group by sg_uf 
with rollup
--order by 2 desc 