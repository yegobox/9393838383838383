CREATE TABLE public.branch (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text,
  description text,
  business_id integer,
  longitude text,
  latitude text,
  location text,
  is_default boolean,
  last_touched timestamp with time zone,
  action text,
  deleted_at timestamp with time zone,
  is_online boolean,
  created_at timestamp with time zone DEFAULT now()
);
CREATE TABLE public.business (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text,
  currency text,
  category_id text,
  latitude text,
  longitude text,
  user_id integer,
  time_zone text,
  country text,
  business_url text,
  hex_color text,
  image_url text,
  type text,
  active boolean,
  chat_uid text,
  metadata text,
  role text,
  last_seen integer,
  first_name text,
  last_name text,
  created_at timestamp with time zone DEFAULT now(),
  device_token text,
  back_up_enabled boolean,
  subscription_plan text,
  next_billing_date text,
  previous_billing_date text,
  is_last_subscription_payment_succeeded boolean,
  backup_file_id text,
  email text,
  last_db_backup text,
  full_name text,
  tin_number integer,
  bhf_id text,
  dvc_srl_no text,
  adrs text,
  tax_enabled boolean,
  tax_server_url text,
  is_default boolean,
  business_type_id integer,
  last_touched timestamp with time zone,
  action text,
  deleted_at timestamp with time zone,
  encryption_key text
);
CREATE TABLE public.category (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  active boolean,
  focused boolean,
  name text,
  branch_id integer,
  deleted_at timestamp with time zone,
  last_touched timestamp with time zone,
  action text,
  created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.stock (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tin INTEGER,
  bhf_id TEXT,
  branch_id INTEGER,
  variant_id INTEGER,
  current_stock DOUBLE PRECISION DEFAULT 0.0,
  sold DOUBLE PRECISION DEFAULT 0.0,
  low_stock DOUBLE PRECISION DEFAULT 0.0,
  can_tracking_stock BOOLEAN DEFAULT TRUE,
  show_low_stock_alert BOOLEAN DEFAULT TRUE,
  product_id INTEGER,
  active BOOLEAN,
  value DOUBLE PRECISION DEFAULT 0.0,
  rsd_qty DOUBLE PRECISION DEFAULT 0.0,
  supply_price DOUBLE PRECISION DEFAULT 0.0,
  retail_price DOUBLE PRECISION DEFAULT 0.0,
  last_touched TIMESTAMPTZ,
  action TEXT,
  deleted_at TIMESTAMPTZ,
  ebm_synced BOOLEAN DEFAULT FALSE
);

-- Create publication for powersync
ALTER PUBLICATION powersync ADD TABLE public.branch, public.business, public.category;

