
/*
Como resolver o erro 1222 do SQL Server, ou seja, desbloquear uma tabela do SQL Server

LINK https://stackoverflow.com/questions/8258710/how-to-solve-sql-server-error-1222-i-e-unlock-a-sql-server-table



--> SOLUÇÃO

No SQL Server Management Studio, para descobrir detalhes da transação ativa, execute o seguinte comando

DBCC opentran()

Você obterá os detalhes da transação ativa e, a partir do SPID da transação ativa, obterá os detalhes sobre o SPID usando os seguintes comandos


Por exemplo, se o SPID for 86, execute o comando como

exec sp_who2 86
exec sp_lock 86


Agora, você pode matar esse processo usando o seguinte comando

KILL 86

O comando kill causaria um rollback que pode demorar um pouco. 
Você pode usar command kill 86 with statusonlypara ver o status de progresso atualizado. 
Você também pode usar command dbcc inputbuffer(86)para descobrir 
qual comando SQL estava sendo executado e causou o bloqueio

*/