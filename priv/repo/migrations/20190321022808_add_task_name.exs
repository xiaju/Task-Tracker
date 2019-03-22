defmodule Spatracker.Repo.Migrations.AddTaskName do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :name, :string, null: false
    end
  end
end
