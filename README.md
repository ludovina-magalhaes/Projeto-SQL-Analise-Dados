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

Na primeira parte vamos construir a Query total_transfers para podermos fazer as nossa pesquisas:
1. Definição do objectivo
O objectivo foi criar uma tabela consolidada (total_transfers) que reunisse todas as transacções efectuadas pelos clientes, independentemente do tipo — sejam elas movimentações PIX, transferências de entrada ou de saída.

2. Identificação das tabelas 
Indentificamos três tabelas principais que armazenam os diferentes tipos de transacções:  
pix_movements – movimentações realizadas via PIX;  
transfer_ins – transferências de entrada (dinheiro recebido);  
transfer_outs – transferências de saída (dinheiro enviado).  
Depois identificamos tablelasque são utilizadas para auxiliar e enriquecer os dados:
accounts – contém informações das contas associadas;   
customers – permite obter os dados dos clientes (como o nome);   
time – utilizada para extrair informações temporais das transacções.   

4. Estrutura da consulta com UNION ALL
As três subconsultas são unidas usando UNION ALL, o que permite combinar todas as transações (Pix, transferências de entrada e transferências de saída) numa única tabela.

4. Resultado Final:
Após a execução das subconsultas, a tabela total_transfers será populada com todas as transações de 2020, com as informações desejadas sobre cada transação, incluindo o tipo de transação, valor, status, cliente, e o mês em que a transação ocorreu.

O resultado da Query total_tranfers é a seguinte:
![image](https://github.com/user-attachments/assets/71e595f7-b152-4787-9aaf-088b30e7040e)
e o código da talela esta aqui: [Script_total_tranfers](script_total_tranfers.sql)





