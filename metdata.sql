ALTER TABLE tasks
  ADD COLUMN IF NOT EXISTS category text,
  ADD COLUMN IF NOT EXISTS reminder_enabled numeric DEFAULT 0,
  ADD COLUMN IF NOT EXISTS reminder_unix bigint,
  ADD COLUMN IF NOT EXISTS user_email text;
