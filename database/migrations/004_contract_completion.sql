-- Completa el modelo definido por SPEC-001 y los flujos de SPEC-003, 008, 010 y 014.
-- Se mantiene forward-only: no modifica migraciones ya aplicadas.

CREATE TABLE sessions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id),
  device_id uuid REFERENCES device_registrations(id),
  refresh_token_hash varchar(128) NOT NULL UNIQUE,
  expires_at timestamptz NOT NULL,
  last_seen_at timestamptz NOT NULL DEFAULT now(),
  revoked_at timestamptz,
  rotated_from_id uuid REFERENCES sessions(id),
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_sessions_user_active
  ON sessions(user_id, expires_at DESC)
  WHERE revoked_at IS NULL;

CREATE TABLE beneficiaries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id),
  display_name varchar(120) NOT NULL,
  bank_name varchar(120) NOT NULL,
  masked_account_number varchar(32) NOT NULL,
  currency char(3) NOT NULL,
  status varchar(24) NOT NULL DEFAULT 'active',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_beneficiaries_user_status
  ON beneficiaries(user_id, status, display_name);

ALTER TABLE device_registrations
  ADD COLUMN IF NOT EXISTS revoked_at timestamptz;

CREATE INDEX idx_devices_user_active
  ON device_registrations(user_id, last_seen_at DESC)
  WHERE revoked_at IS NULL;

ALTER TABLE cards
  ADD COLUMN IF NOT EXISTS frozen_at timestamptz;

CREATE TABLE card_limits (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  card_id uuid NOT NULL UNIQUE REFERENCES cards(id),
  daily_purchase_limit numeric(18,2) NOT NULL,
  daily_withdrawal_limit numeric(18,2) NOT NULL,
  currency char(3) NOT NULL,
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE wallet_provisioning (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  card_id uuid NOT NULL REFERENCES cards(id),
  user_id uuid NOT NULL REFERENCES users(id),
  wallet varchar(32) NOT NULL,
  status varchar(24) NOT NULL DEFAULT 'processing',
  provider_reference varchar(120),
  provisioning_url text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX idx_wallet_provisioning_card_created
  ON wallet_provisioning(card_id, created_at DESC);

ALTER TABLE financial_operations
  ADD COLUMN IF NOT EXISTS resource_id uuid,
  ADD COLUMN IF NOT EXISTS provider_reference varchar(120),
  ADD COLUMN IF NOT EXISTS failure_code varchar(80);

CREATE INDEX idx_financial_operations_user_created
  ON financial_operations(user_id, created_at DESC);

CREATE INDEX idx_financial_operations_resource
  ON financial_operations(resource_id);
