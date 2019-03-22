defmodule Spatracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :complete, :boolean, default: false, null: false
      add :desc, :string
      add :time, :integer
      add :user_id, references(:users, on_delete: :nilify_all), null: true

      timestamps()
    end

    create index(:tasks, [:user_id])
  end
end
