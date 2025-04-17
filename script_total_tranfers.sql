CREATE OR REPLACE TABLE `my-project-sql-435409.projeto.total_transfers` AS (
  SELECT
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
    -- subquery 1
    SELECT
      p.id AS transaction_id,
      a.customer_id,
      CONCAT(c.first_name, " ", c.last_name) AS full_name,
      p.account_id,
      p.pix_amount AS amount,
      p.status,
      p.in_or_out AS type_transaction,
      DATE(action_timestamp) AS date_completed,
      EXTRACT(MONTH FROM DATE(action_timestamp)) AS month
    FROM `my-project-sql-435409.projeto.pix_movements` p
    INNER JOIN `my-project-sql-435409.projeto.accounts` a ON p.account_id = a.account_id
    INNER JOIN `my-project-sql-435409.projeto.customers` c ON a.customer_id = c.customer_id
    INNER JOIN `my-project-sql-435409.projeto.time` t ON p.pix_completed_at = t.time_id
    WHERE p.status = 'completed'
      AND DATE(action_timestamp) BETWEEN '2020-01-01' AND '2020-12-31'

    UNION ALL

    -- subquery 2
    SELECT 
      i.id AS transaction_id,
      a.customer_id,
      CONCAT(c.first_name, " ", c.last_name) AS full_name,
      i.account_id,
      i.amount,
      i.status,
      'transfer_ins' AS type_transaction,
      DATE(action_timestamp) AS date_completed,
      EXTRACT(MONTH FROM DATE(action_timestamp)) AS month
    FROM `my-project-sql-435409.projeto.transfer_ins` i
    INNER JOIN `my-project-sql-435409.projeto.accounts` a ON i.account_id = a.account_id
    INNER JOIN `my-project-sql-435409.projeto.customers` c ON a.customer_id = c.customer_id
    INNER JOIN `my-project-sql-435409.projeto.time` t ON i.transaction_completed_at = t.time_id
    WHERE i.status = 'completed'
      AND DATE(action_timestamp) BETWEEN '2020-01-01' AND '2020-12-31'

    UNION ALL

    -- subquery 3
    SELECT 
      o.id AS transaction_id,
      a.customer_id,
      CONCAT(c.first_name, " ", c.last_name) AS full_name,
      o.account_id,
      o.amount,
      o.status,
      'transfer_outs' AS type_transaction,
      DATE(action_timestamp) AS date_completed,
      EXTRACT(MONTH FROM DATE(action_timestamp)) AS month
    FROM `my-project-sql-435409.projeto.transfer_outs` o
    INNER JOIN `my-project-sql-435409.projeto.accounts` a ON o.account_id = a.account_id
    INNER JOIN `my-project-sql-435409.projeto.customers` c ON a.customer_id = c.customer_id
    INNER JOIN `my-project-sql-435409.projeto.time` t ON o.transaction_completed_at = t.time_id
    WHERE o.status = 'completed'
      AND DATE(action_timestamp) BETWEEN '2020-01-01' AND '2020-12-31'
  )
)
