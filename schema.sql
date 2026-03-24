-- RHDC MASTER DATABASE
-- SCHEMA DEFINITION FILE

-- Extensions
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Tables
CREATE TABLE roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    role_id UUID REFERENCES roles(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE participants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    order_number INT UNIQUE NOT NULL
);

CREATE TABLE participant_stage (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    participant_id UUID REFERENCES participants(id) ON DELETE CASCADE,
    stage_id UUID REFERENCES stages(id) ON DELETE CASCADE,
    status TEXT CHECK (status IN ('pending','active','completed','eliminated')),
    UNIQUE(participant_id, stage_id)
);

CREATE TABLE submissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    participant_id UUID REFERENCES participants(id) ON DELETE CASCADE,
    stage_id UUID REFERENCES stages(id),
    content TEXT,
    status TEXT CHECK (status IN ('pending','submitted','reviewed','rejected')),
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(participant_id, stage_id)
);


CREATE TABLE evaluations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    submission_id UUID REFERENCES submissions(id) ON DELETE CASCADE,
    judge_id UUID REFERENCES users(id),
    feedback TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(submission_id, judge_id)
);


CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    action TEXT NOT NULL,
    table_name TEXT,
    record_id UUID,
    performed_by UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

