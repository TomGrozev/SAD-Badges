# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :badges,
  ecto_repos: [Badges.Repo]

# Configures the endpoint
config :badges, BadgesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "geVE0JlbU58pO2SO/zOhXX6jngjGhu8EpquOQhnCgfgKNLDLuJ893N1Q2KK0C/5m",
  render_errors: [view: BadgesWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Badges.PubSub,
  live_view: [signing_salt: "wRBxYDwk"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
