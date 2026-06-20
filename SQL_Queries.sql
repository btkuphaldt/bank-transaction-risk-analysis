/*
===============================================================================
PROJECT: Bank Transaction Risk Analysis
AUTHOR: Bodean Kuphaldt
TOOLS: Google BigQuery SQL

DESCRIPTION
-----------
This project analyzes 2,512 banking transactions to explore customer behavior,
transaction patterns, and potential fraud indicators using SQL.

Business Objectives
-------------------
1. Understand overall transaction activity.
2. Analyze customer and transaction behavior.
3. Investigate potential fraud patterns.
4. Summarize business insights using SQL.

Dataset
-------
Project: bank-project-499619
Dataset: Risk_flag_analysis
Table: transactions
===============================================================================
*/

-- =============================================================================
-- SECTION 1 : DATA VALIDATION
-- =============================================================================

-- Query 1: Preview dataset
SELECT *
FROM `bank-project-499619.Risk_flag_analysis.transactions`
LIMIT 10;

-- Query 2: Total transactions
SELECT
    COUNT(*) AS total_transactions
FROM `bank-project-499619.Risk_flag_analysis.transactions`;

-- =============================================================================
-- SECTION 2 : TRANSACTION OVERVIEW
-- =============================================================================

-- Query 3: Transaction type distribution
SELECT
    TransactionType,
    COUNT(*) AS total_transactions
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY TransactionType
ORDER BY total_transactions DESC;

-- Query 4: Average transaction amount
SELECT
    ROUND(AVG(TransactionAmount),2) AS average_transaction_amount
FROM `bank-project-499619.Risk_flag_analysis.transactions`;

-- Query 5: Risk flag distribution
SELECT
    RiskFlag,
    COUNT(*) AS total_transactions
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY RiskFlag;

-- Query 6: Transaction type comparison
SELECT
    TransactionType,
    ROUND(AVG(TransactionAmount),2) AS average_transaction_amount,
    ROUND(AVG(LoginAttempts),2) AS average_login_attempts
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY TransactionType;

-- =============================================================================
-- SECTION 3 : ACCOUNT ANALYSIS
-- =============================================================================

-- Query 7: Accounts containing flagged transactions
SELECT
    AccountID,
    COUNT(*) AS flagged_transactions,
    ROUND(SUM(TransactionAmount),2) AS total_flagged_amount
FROM `bank-project-499619.Risk_flag_analysis.transactions`
WHERE RiskFlag = 1
GROUP BY AccountID
ORDER BY flagged_transactions DESC,
         total_flagged_amount DESC;

-- Query 8: Highest value customer accounts
SELECT
    AccountID,
    COUNT(*) AS transaction_count,
    ROUND(SUM(TransactionAmount),2) AS total_transacted,
    ROUND(AVG(TransactionAmount),2) AS average_transaction
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY AccountID
HAVING COUNT(*) >= 2
ORDER BY total_transacted DESC
LIMIT 10;

-- =============================================================================
-- SECTION 4 : CHANNEL ANALYSIS
-- =============================================================================

-- Query 9: Fraud rate by transaction channel
SELECT
    Channel,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN RiskFlag = 1 THEN 1 ELSE 0 END) AS flagged_transactions,
    ROUND(
        100 * SUM(CASE WHEN RiskFlag = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS flagged_percentage
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY Channel
ORDER BY flagged_percentage DESC;

-- Query 10: Average transaction amount by channel
SELECT
    Channel,
    COUNT(*) AS total_transactions,
    ROUND(AVG(TransactionAmount),2) AS average_transaction_amount,
    ROUND(MAX(TransactionAmount),2) AS largest_transaction
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY Channel
ORDER BY average_transaction_amount DESC;

-- Query 11: Average transaction duration by channel
SELECT
    Channel,
    ROUND(AVG(TransactionDuration),2) AS average_transaction_duration
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY Channel;

-- =============================================================================
-- SECTION 5 : CUSTOMER ANALYSIS
-- =============================================================================

-- Query 12: Occupation analysis
SELECT
    CustomerOccupation,
    COUNT(*) AS total_transactions,
    ROUND(AVG(TransactionAmount),2) AS average_transaction_amount
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY CustomerOccupation
HAVING COUNT(*) >= 20
ORDER BY average_transaction_amount DESC;

-- Query 13: Flagged transactions by occupation
SELECT
    CustomerOccupation,
    COUNT(*) AS flagged_transactions
FROM `bank-project-499619.Risk_flag_analysis.transactions`
WHERE RiskFlag = 1
GROUP BY CustomerOccupation
ORDER BY flagged_transactions DESC;

-- =============================================================================
-- SECTION 6 : LOGIN & SECURITY ANALYSIS
-- =============================================================================

-- Query 14: Login attempts versus transaction amount
SELECT
    LoginAttempts,
    COUNT(*) AS transaction_count,
    ROUND(AVG(TransactionAmount),2) AS average_transaction_amount
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY LoginAttempts
ORDER BY LoginAttempts;

-- Query 15: Average login attempts by transaction type
SELECT
    TransactionType,
    ROUND(AVG(LoginAttempts),2) AS average_login_attempts
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY TransactionType;

-- Query 16: Characteristics of flagged transactions
SELECT
    TransactionType,
    Channel,
    LoginAttempts,
    COUNT(*) AS flagged_transactions,
    ROUND(AVG(TransactionAmount),2) AS average_transaction_amount
FROM `bank-project-499619.Risk_flag_analysis.transactions`
WHERE RiskFlag = 1
GROUP BY
    TransactionType,
    Channel,
    LoginAttempts
ORDER BY flagged_transactions DESC;

-- =============================================================================
-- SECTION 7 : FINANCIAL ANALYSIS
-- =============================================================================

-- Query 17: Risk flag comparison
SELECT
    RiskFlag,
    COUNT(*) AS transaction_count,
    ROUND(AVG(TransactionAmount),2) AS average_transaction_amount,
    ROUND(MAX(TransactionAmount),2) AS largest_transaction
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY RiskFlag;

-- Query 18: Average account balance by transaction type
SELECT
    TransactionType,
    ROUND(AVG(AccountBalance),2) AS average_account_balance
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY TransactionType;

-- Query 19: Highest value individual transactions
SELECT
    TransactionID,
    AccountID,
    TransactionAmount,
    TransactionType,
    Channel,
    CustomerOccupation
FROM `bank-project-499619.Risk_flag_analysis.transactions`
ORDER BY TransactionAmount DESC
LIMIT 10;

-- Query 20: High-value transaction summary
SELECT
    COUNT(*) AS transactions_over_1000,
    ROUND(AVG(TransactionAmount),2) AS average_transaction_amount
FROM `bank-project-499619.Risk_flag_analysis.transactions`
WHERE TransactionAmount > 1000;

-- Query 21: Geographic transaction analysis
SELECT
    Location,
    COUNT(*) AS total_transactions,
    ROUND(AVG(TransactionAmount),2) AS average_transaction_amount
FROM `bank-project-499619.Risk_flag_analysis.transactions`
GROUP BY Location
ORDER BY average_transaction_amount DESC;
