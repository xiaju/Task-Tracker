defmodule Tasktracker.Repo.Migrations.Addtaskidsagain do
  use Ecto.Migration
  def change do
    alter table(:users) do
      add :task_id, references(:tasks, on_delete: :nilify_all), null: true
    end
  end
end
