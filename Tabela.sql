
-- transaction_id
-- customer_id
-- full name
-- account_id
-- amount
-- status
-- type_transaction
-- date_completed
-- month

-- total_transfers (vai trazer todas as transacoes realizadas tanto de
--entrada quanto de saida dinheiro)
CREATE OR REPLACE TABLE `my-project-sql-435409.projeto.total_transfers` as (
select
transaction_id,
customer_id,
full_name,
account_id,
amount,
status,
type_transaction,
date_completed,
month
FROM (

SELECT
distinct p.id as transaction_id,
a.customer_id, -- localizada na tabela de accounts
CONCAT(c.first_name," ", c.last_name) as full_name, -- localizada na tabela de customers,
p.account_id,
p.pix_amount as amount,
p.status,
p.in_or_out as type_transaction,
DATE(action_timestamp) as date_completed, -- localizada na tabela de time
EXTRACT(MONTH FROM DATE(action_timestamp)) as month -- localizada na tabela de time
FROM `my-project-sql-435409.projeto.pix_movements` p
LEFT JOIN `my-project-sql-435409.projeto.accounts` a on p.account_id = a.account_id
LEFT JOIN `my-project-sql-435409.projeto.customers` c on a.customer_id =
c.customer_id
LEFT JOIN `my-project-sql-435409.projeto.time` t on p.pix_completed_at = t.time_id
WHERE p.status = 'completed' and DATE(action_timestamp) between '2020-01-01'
and '2020-12-31'
UNION ALL
SELECT distinct
i.id as transaction_id,
a.customer_id, -- localizada na tabela de accounts
CONCAT(c.first_name," ", c.last_name) as full_name, -- localizada na tabela de customers
i.account_id,
i.amount,
i.status,
'transfer_ins' as type_transaction,
DATE(action_timestamp) as date_completed, -- localizada na tabela de time
EXTRACT(MONTH FROM DATE(action_timestamp)) as month -- localizada na tabela de time
FROM `my-project-sql-435409.projeto.transfer_ins` i
LEFT JOIN `my-project-sql-435409.projeto.accounts` a on i.account_id = a.account_id
LEFT JOIN `my-project-sql-435409.projeto.customers` c on a.customer_id =
c.customer_id
LEFT JOIN `my-project-sql-435409.projeto.time` t on i.transaction_completed_at =
t.time_id
WHERE DATE(action_timestamp) between '2020-01-01'and '2020-12-31' and
i.status = 'completed'
UNION ALL
SELECT distinct
o.id as transaction_id,
a.customer_id,
CONCAT(c.first_name," ", c.last_name) as full_name, -- localizada na tabela de customers
o.account_id,
o.amount,
o.status,
'transfer_outs' as type_transaction,
DATE(action_timestamp) as date_completed, -- localizada na tabela de time
EXTRACT(MONTH FROM DATE(action_timestamp)) as month -- localizada na tabela de time
FROM `my-project-sql-435409.projeto.transfer_outs` o
LEFT JOIN `my-project-sql-435409.projeto.accounts` a on o.account_id =
a.account_id
LEFT JOIN `my-project-sql-435409.projeto.customers` c on a.customer_id =
c.customer_id
LEFT JOIN `my-project-sql-435409.projeto.time` t on o.transaction_completed_at =
t.time_id
where o.status = 'completed' and DATE(action_timestamp) between
'2020-01-01' and '2020-12-31'))
