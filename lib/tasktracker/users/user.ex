defmodule Tasktracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    field :isManager, :boolean
    has_many :underling, Tasktracker.Users.User, foreign_key: :manager_id
    belongs_to :manager, Tasktracker.Users.User
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    attrs = if attrs != nil && Map.has_key?(attrs, "managerName") &&
               Tasktracker.Users.get_user_by_name(attrs["managerName"]) do
    manager = Tasktracker.Users.get_user_by_name(attrs["managerName"])
    Map.put(attrs, "manager_id", manager.id)
    |> Map.delete("managerName")
    else
      attrs
    end
    cast(user, attrs, [:name, :manager_id])
    |> validate_required([:name])
  end
end
