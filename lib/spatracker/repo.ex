defmodule Spatracker.Repo do
  use Ecto.Repo,
    otp_app: :spatracker,
    adapter: Ecto.Adapters.Postgres
end
