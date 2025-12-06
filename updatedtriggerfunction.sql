create or replace function handle_task_completion()
returns trigger as $$
begin
  if new.status = 'completed' and old.status <> 'completed' then

    -- Task-level streak (habit streak)
    new.streak := case
      when new.last_completed = current_date - interval '1 day' then new.streak + 1
      else 1
    end;
    new.last_completed := current_date;

    -- User-level XP + streak logic + LEVEL UP
    update users
    set 
      -- Leveling system
      level = level + FLOOR((xp_total + new.xp_value) / 100),
      xp_total = (xp_total + new.xp_value) % 100,

      -- Streak logic
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
