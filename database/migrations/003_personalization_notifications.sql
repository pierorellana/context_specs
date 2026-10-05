CREATE TABLE dashboard_configs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  segment varchar(40) NOT NULL,
  schema_version int NOT NULL DEFAULT 1,
  config jsonb NOT NULL,
  is_active boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE notifications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id),
  type varchar(40) NOT NULL,
  title varchar(120) NOT NULL,
  body varchar(240) NOT NULL,
  resource_type varchar(40),
  resource_id uuid,
  read_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE device_registrations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id),
  platform varchar(16) NOT NULL,
  push_token text NOT NULL,
  device_label varchar(100),
  last_seen_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(user_id, push_token)
);

CREATE TABLE audit_events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES users(id),
  event_type varchar(80) NOT NULL,
  entity_type varchar(60),
  entity_id uuid,
  trace_id varchar(80),
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now()
);
