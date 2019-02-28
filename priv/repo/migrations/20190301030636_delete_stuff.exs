defmodule Tasktracker.Repo.Migrations.DeleteStuff do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :task_id
    end
  end

end
