defmodule Spatracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :name, :string
    field :complete, :boolean, default: false
    field :desc, :string
    field :time, :integer
    belongs_to :user, Spatracker.Users.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    attrs = if attrs != nil && Map.has_key?(attrs, "assignee") &&
               Spatracker.Users.get_user_by_name(attrs["assignee"]) do
      user = Spatracker.Users.get_user_by_name(attrs["assignee"])
      Map.put(attrs, "user_id", user.id)
      |> Map.delete("assignee")
    else
    attrs
  end
  task
    |> cast(attrs, [:complete, :desc, :time, :name, :user_id])
    |> validate_required([:complete, :desc, :name])
  end
end
