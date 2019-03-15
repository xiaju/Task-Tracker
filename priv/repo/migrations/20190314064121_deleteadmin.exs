defmodule Tasktracker.Repo.Migrations.Deleteadmin do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :admin
    end
  end
end
