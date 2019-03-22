defmodule SpatrackerWeb.PageController do
  use SpatrackerWeb, :controller

  def index(conn, _params) do
    tasks = Spatracker.Tasks.list_tasks()
    |> Enum.map(&(Map.take(&1, [:id, :name, :desc, :complete, :time])))
    render(conn, "index.html", tasks: tasks)
  end
end
