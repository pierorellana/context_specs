-- Preferencias sincronizadas definidas por SPEC-014.
-- Se mantiene forward-only y no contiene preferencias de seguridad obligatoria.

CREATE TABLE profile_preferences (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL UNIQUE REFERENCES users(id),
  hide_balance boolean NOT NULL DEFAULT false,
  reduce_motion boolean NOT NULL DEFAULT false,
  notifications_enabled boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
