defmodule Fatex.Repo do
  use Ecto.Repo,
    otp_app: :fatex,
    adapter: Ecto.Adapters.Postgres
end
