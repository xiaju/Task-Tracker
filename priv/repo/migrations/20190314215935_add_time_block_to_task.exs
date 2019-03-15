defmodule Tasktracker.Repo.Migrations.AddTimeBlockToTask do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :timeblock, references(:timeblocks, on_delete: :nilify_all), null: true
    end
  end
end
