create trigger task_completed_trigger
after update on tasks
for each row
execute function handle_task_completion();