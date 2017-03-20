# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mixdown,
  ecto_repos: [Mixdown.Repo]

# Configures the endpoint
config :mixdown, Mixdown.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QmNV2KFZAfy4vO6Rux2DebC53wmNqvy9o/uO8qUZRDB9A509MM4sRpTqQS0/LxYu",
  render_errors: [view: Mixdown.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mixdown.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Authentication
config :ueberauth, Ueberauth,
  providers: [
    identity: { Ueberauth.Strategy.Identity, [ callback_methods: [ "POST" ] ] }
  ]

config :guardian, Guardian,
  verify_module: Guardian.JWT,
  issuer: "Mixdown.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  secret_key: to_string(Mix.env),
  serializer: Mixdown.Auth.Serializer,
  hooks: GuardianDb

config :guardian_db, GuardianDb,
  repo: Mixdown.Repo,
  schema_name: "auth_tokens",
  sweep_interval: 60 * 24 * 7 # 7 days in minutes

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
