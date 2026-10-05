CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email varchar(255) NOT NULL UNIQUE,
  display_name varchar(120) NOT NULL,
  segment varchar(40) NOT NULL DEFAULT 'standard',
  password_hash text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE accounts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id),
  type varchar(32) NOT NULL,
  name varchar(80) NOT NULL,
  masked_number varchar(32) NOT NULL,
  currency char(3) NOT NULL,
  ledger_balance numeric(18,2) NOT NULL DEFAULT 0,
  available_balance numeric(18,2) NOT NULL DEFAULT 0,
  status varchar(24) NOT NULL DEFAULT 'active',
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE transactions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id uuid NOT NULL REFERENCES accounts(id),
  kind varchar(24) NOT NULL,
  description varchar(160) NOT NULL,
  category varchar(50) NOT NULL,
  amount numeric(18,2) NOT NULL,
  currency char(3) NOT NULL,
  status varchar(24) NOT NULL,
  occurred_at timestamptz NOT NULL,
  reference varchar(80),
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_transactions_account_occurred
  ON transactions(account_id, occurred_at DESC);
