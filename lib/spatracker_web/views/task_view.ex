defmodule SpatrackerWeb.TaskView do
  use SpatrackerWeb, :view
  alias SpatrackerWeb.TaskView
  alias Spatracker.Repo

  def copyTaskWithoutUserSchema(task) do
    task = Repo.preload(task, :user)
    if task.user do
      Map.put(task, :user, task.user.name)
    else
      task
    end
  end

  def render("index.json", %{tasks: tasks}) do
    #tasks = Enum.map(tasks, &copyTaskWithoutUserSchema/1)
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    #task = copyTaskWithoutUserSchema(task)
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    task = copyTaskWithoutUserSchema(task)
    %{id: task.id,
      complete: task.complete,
      name: task.name,
      user: task.user,
      desc: task.desc,
      time: task.time}
  end
end
