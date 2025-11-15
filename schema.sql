create table if not exists users (
  id text primary key,                  -- Bubble's unique user ID
  name text,                            -- Display name
  xp_total integer default 0,           -- Total XP accumulated
  level integer default 1,              -- User's level
  streak_count integer default 0,       -- Current streak
  last_completed_date date              -- For streak tracking logic
);


create table if not exists tasks (
  id uuid primary key default gen_random_uuid(),
  bubble_user_id text not null references users(id) on delete cascade,
  title text not null,
  description text,
  status text default 'pending',        -- 'pending' or 'completed'
  xp_value integer default 10,          -- XP gained for completing task
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);
