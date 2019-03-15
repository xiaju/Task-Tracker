defmodule Tasktracker.Repo.Migrations.Underlings do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :underling_ids, references(:users, on_delete: :nilify_all), null: true
      add :manager_id, references(:users, on_delete: :nilify_all), null: true
      add :isManager, :boolean
    end
  end
end
