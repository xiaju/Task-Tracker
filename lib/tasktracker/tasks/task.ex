defmodule Tasktracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :complete, :boolean, default: false
    field :desc, :string
    field :time, :integer
    field :title, :string
    belongs_to :user, Tasktracker.Users.User
    has_many :timeblock, Tasktracker.TimeBlocks.TimeBlock, foreign_key: :task_id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    attrs = if attrs != nil && Map.has_key?(attrs, "name") &&
               Tasktracker.Users.get_user_by_name(attrs["name"]) do
      user = Tasktracker.Users.get_user_by_name(attrs["name"])
      Map.put(attrs, "user_id", user.id)
      |> Map.delete("name")
    else
      attrs
    end

    cast(task, attrs, [:title, :desc, :time, :complete, :user_id])
    |> validate_required([:title, :desc, :complete])
  end
end
