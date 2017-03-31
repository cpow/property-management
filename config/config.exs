# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :hound, driver: "phantomjs"

# General application configuration
config :lord_core,
  ecto_repos: [LordCore.Repo]

# Configures the endpoint
config :lord_core, LordCore.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SWQOP1eyY9j81LDM9uDxcTSx5mgDZ9ZgUHCQMzpGUD/l6DgNLE9HTWjn4tPPmYKM",
  render_errors: [view: LordCore.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LordCore.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :lord_core, :defaults,
  user_roles: ~w(disabled admin tenant property_manager)


config :guardian, Guardian,
  issuer: "LordCore",
  ttl: {30, :days},
  verify_issuer: true,
  secret_key: "5NjY6yX7dkT9fBqhTWvkNzYLzJYuzVtOMZe3jM+3tRDoS5xEwTyUKBIVjPAiMexK",
  serializer: LordCore.GuardianSerializer

config :phoenix, :format_encoders,
  "json-api": Poison
  
config :plug, :mimes, %{
  "application/vnd.api+json" => ["json-api"]
}


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
