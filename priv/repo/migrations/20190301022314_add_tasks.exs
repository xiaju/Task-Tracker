defmodule Tasktracker.Repo.Migrations.AddTasks do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :task_ids, references(:tasks, on_delete: :nilify_all), null: true
    end
  end
end
