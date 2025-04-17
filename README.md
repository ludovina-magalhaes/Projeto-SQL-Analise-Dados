 ## Projeto Prático - Construindo Consultas para Análise de Dados
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
 Na primeira parte vamos construir uma Query principal para podermos fazer as nossa pesquisas e o resultado esta nesta tabela:
![image](https://github.com/user-attachments/assets/71e595f7-b152-4787-9aaf-088b30e7040e)
e o código da talela esta aqui: [Código da parte 1](script_total_tranfers.sql)




