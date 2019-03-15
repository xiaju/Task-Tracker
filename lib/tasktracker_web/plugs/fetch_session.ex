defmodule TasktrackerWeb.Plugs.FetchSession do
  import Plug.Conn
  alias Tasktracker.Repo

  def init(args), do: args

  def call(conn, _args) do
    user = Tasktracker.Users.get_user(get_session(conn, :user_id) || -1)

    if user do
      user = Repo.preload(user, :underling)
      tasks = Tasktracker.Tasks.list_tasks(user.id)
      ulist_tasks = Tasktracker.Users.underling_tasks(user.id)
      assign(conn, :current_tasks, tasks)
      |> assign(:current_user, user)
      |> assign(:uling_tasks, ulist_tasks)
    else
      assign(conn, :current_tasks, nil)
      |> assign(:current_user, nil)
    end
  end
end
