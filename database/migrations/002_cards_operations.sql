CREATE TABLE cards (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id),
  account_id uuid REFERENCES accounts(id),
  type varchar(24) NOT NULL,
  product_name varchar(80) NOT NULL,
  masked_pan varchar(32) NOT NULL,
  status varchar(24) NOT NULL DEFAULT 'active',
  is_virtual boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE financial_operations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id),
  operation_type varchar(24) NOT NULL,
  status varchar(24) NOT NULL,
  amount numeric(18,2),
  currency char(3),
  request_json jsonb NOT NULL DEFAULT '{}'::jsonb,
  result_json jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE idempotency_keys (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id),
  operation varchar(40) NOT NULL,
  key varchar(120) NOT NULL,
  request_hash varchar(64) NOT NULL,
  operation_id uuid REFERENCES financial_operations(id),
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(user_id, operation, key)
);
