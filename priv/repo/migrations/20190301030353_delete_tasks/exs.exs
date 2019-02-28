defmodule :"Elixir.Tasktracker.Repo.Migrations.DeleteTasks.exs" do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :task_ids
    end
  end

end
