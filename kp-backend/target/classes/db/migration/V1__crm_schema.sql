CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE TABLE leads (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), lead_code VARCHAR(24) NOT NULL UNIQUE,
 name VARCHAR(120) NOT NULL, phone VARCHAR(24) NOT NULL, email VARCHAR(254),
 product_interest VARCHAR(120), message VARCHAR(2000), source VARCHAR(40) NOT NULL DEFAULT 'WEBSITE',
 status VARCHAR(24) NOT NULL DEFAULT 'NEW' CHECK(status IN ('NEW','CONTACTED','QUALIFIED','QUOTATION','NEGOTIATION','WON','LOST')),
 assigned_to VARCHAR(120), follow_up_at TIMESTAMPTZ, created_at TIMESTAMPTZ NOT NULL DEFAULT now(), updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_leads_status_created ON leads(status, created_at DESC);
CREATE INDEX idx_leads_phone ON leads(phone);
CREATE INDEX idx_leads_followup ON leads(follow_up_at) WHERE follow_up_at IS NOT NULL;
CREATE TABLE lead_activities (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), lead_id UUID NOT NULL REFERENCES leads(id) ON DELETE CASCADE,
 activity_type VARCHAR(24) NOT NULL, content VARCHAR(2000) NOT NULL, created_by VARCHAR(120) NOT NULL DEFAULT 'admin', created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_activity_lead_created ON lead_activities(lead_id,created_at DESC);
CREATE TABLE admin_users (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), full_name VARCHAR(120) NOT NULL, email VARCHAR(254) NOT NULL UNIQUE,
 role VARCHAR(30) NOT NULL CHECK(role IN ('SUPER_ADMIN','SALES_ADMIN','EDITOR')), enabled BOOLEAN NOT NULL DEFAULT true, created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE otp_challenges (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), email VARCHAR(254) NOT NULL, otp_hash VARCHAR(255) NOT NULL,
 expires_at TIMESTAMPTZ NOT NULL, consumed_at TIMESTAMPTZ, attempts SMALLINT NOT NULL DEFAULT 0, created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_otp_email_created ON otp_challenges(email,created_at DESC);
