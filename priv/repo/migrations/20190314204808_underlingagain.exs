defmodule Tasktracker.Repo.Migrations.Underlingagain do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :underling_id, references(:users, on_delete: :nilify_all), null: true
    end
  end
end
