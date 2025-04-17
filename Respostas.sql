-- 1. Criar lista com todos os meses existentes na tabela
WITH all_months AS (
SELECT DISTINCT month
FROM `my-project-sql-435409.projeto.total_transfers`
),

-- 2. Calcular entradas e saídas em uma única CTE
transfers_combined AS (
SELECT
month,
customer_id,
full_name,
SUM(CASE WHEN type_transaction IN ('pix_in', 'transfer_ins') THEN amount
ELSE 0 END) AS total_transfer_in,
SUM(CASE WHEN type_transaction IN ('pix_out', 'transfer_outs') THEN
amount ELSE 0 END) AS total_transfer_out
FROM `my-project-sql-435409.projeto.total_transfers`
GROUP BY month, customer_id, full_name
),
-- 3. Combinar todos os meses com todos os clientes
transfers_all AS (
SELECT
m.month,
c.customer_id,
c.full_name,
COALESCE(tc.total_transfer_in, 0) AS total_transfer_in,
COALESCE(tc.total_transfer_out, 0) AS total_transfer_out
FROM all_months m

CROSS JOIN (SELECT DISTINCT customer_id, full_name FROM
transfers_combined) c
LEFT JOIN transfers_combined tc
ON m.month = tc.month AND c.customer_id = tc.customer_id
)
-- 4. Calcular saldo acumulado por cliente
SELECT
month,
customer_id,
full_name,
ROUND(total_transfer_in, 2) AS total_transfer_in,
ROUND(total_transfer_out, 2) AS total_transfer_out,
ROUND(SUM(total_transfer_in - total_transfer_out) OVER (
PARTITION BY customer_id ORDER BY month
), 2) AS saldo_mensal
FROM transfers_all
ORDER BY full_name, month;
