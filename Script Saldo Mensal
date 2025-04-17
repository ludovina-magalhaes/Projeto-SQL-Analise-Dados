--- todos os meses as 

WITH all_months as (
SELECT distinct month from `my-project-sql-435409.projeto.total_transfers`
),
--- calcular o total de entradas (transferencias recebidas)

total_transfer_in as (
select month, customer_id, full_name,
COALESCE(SUM(amount),0) as total_transfer_in
from `my-project-sql-435409.projeto.total_transfers`
where type_transaction in ('pix_in','transfer_ins')
group by 1,2,3
),

--- calcular o total de saidas (transferencias enviadas)

total_transfer_out as (
select month, customer_id, full_name,
COALESCE(SUM(amount),0) as total_transfer_out
from `my-project-sql-435409.projeto.total_transfers`
where type_transaction in ('pix_out','transfer_outs')
group by 1,2,3
),
--- combinar as duas tabelas e normalizar os dados
transfers_all as (
select a.month, c.customer_id, c.full_name,
COALESCE(tti.total_transfer_in,0) as total_transfer_in,
COALESCE(tto.total_transfer_out,0) as total_transfer_out
from all_months a
CROSS JOIN (select distinct customer_id, full_name from total_transfer_in) c
LEFT JOIN total_transfer_in tti on a.month = tti.month and c.customer_id =
tti.customer_id
LEFT JOIN total_transfer_out tto on a.month = tto.month and c.customer_id =
tto.customer_id
)
--- calcular o saldo acumulado mensal
select
month,
customer_id,
full_name,
round(total_transfer_in,2) as total_transfer_in,
round(total_transfer_out,2) as total_transfer_out,
round(SUM(total_transfer_in - total_transfer_out) over (partition by
customer_id order by month),2) as saldo_mensal
from transfers_all
order by full_name,month;
