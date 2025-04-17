 ## Projeto Prático - Construindo Consultaspara Análise de Dados
 ### Case para Analista de Dados

A Analista de Negócios, responsável por analisar o comportamento dos clientes e que consome directamente os dados do Ambiente de Data Warehouse, necessita de obter todos os Saldos Mensais das Contas entre janeiro de 2020 e dezembro de 2020.

#### Diretrizes:
Será necessário utilizar os seguintes dados: transfer_in, transfer_out, pix_movements e, se necessário, as respectivas dimensões.

#### Contexto de Negócio
Para resolver este primeiro problema, é importante estar familiarizado com o conceito de "Saldo Mensal da Conta".
O Saldo Mensal da Conta representa o montante de dinheiro que um cliente possuía na conta no final num determinado mês.
Este valor pode ser calculado da seguinte forma:
 - Somando todos os valores recebidos (movimentos de entrada);
 - Subtraindo todos os valores enviados (movimentos de saída);
 - Acrescentando ou subtraindo o saldo acumulado do mês anterior.




[Ver o código de exemplo](Projeto_SQL/blob/main/script_total_tranfers.sql)

