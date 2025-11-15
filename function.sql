-- Function to add XP and update streak when a task is completed
create or replace function handle_task_completion()
returns trigger as $$
begin
  if new.status = 'completed' and old.status <> 'completed' then
    -- Increase user's XP
    update users
    set 
      xp_total = xp_total + new.xp_value,
      streak_count = case 
        when last_completed_date = current_date - interval '1 day' then streak_count + 1
        else 1
      end,
      last_completed_date = current_date
    where id = new.bubble_user_id;
  end if;
  return new;
end;
$$ language plpgsql;
