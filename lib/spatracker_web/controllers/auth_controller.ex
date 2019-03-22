defmodule SpatrackerWeb.AuthController do
  use SpatrackerWeb, :controller
  alias Spatracker.Users.User

  def authenticate(conn, %{"name" => name, "password" => password}) do
    with {:ok, %User{} = user} <- Spatracker.Users.authenticate_user(name, password) do
      resp = %{
        data: %{
          token: Phoenix.Token.sign(SpatrackerWeb.Endpoint, "user_id", user.id),
          user_id: user.id,
          user_name: user.name
        }
      }

      conn
      |> put_resp_header("content-type", "application/json; charset=UTF-8")
      |> send_resp(:created, Jason.encode!(resp))
    end
  end

  action_fallback SpatrackerWeb.FallbackController
end
