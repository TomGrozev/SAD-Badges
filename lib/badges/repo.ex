defmodule Badges.Repo do
  use Ecto.Repo,
    otp_app: :badges,
    adapter: Ecto.Adapters.Postgres
end
