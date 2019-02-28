defmodule Tasktracker.Repo.Migrations.AddUserId do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :user_id, references(:users, on_delete: :nilify_all), null: true
    end
  end
end
