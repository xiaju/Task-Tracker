defmodule TasktrackerWeb.Plugs.FetchSession do
  import Plug.Conn

  def init(args), do: args

  def call(conn, _args) do
    user = Tasktracker.Users.get_user(get_session(conn, :user_id) || -1)
    if user do
      tasks = Tasktracker.Tasks.list_tasks(user.id)
      assign(conn, :current_tasks, tasks)
      |> assign(:current_user, user)
    else
      assign(conn, :current_tasks, nil)
      |> assign(:current_user, nil)
    end
  end
end