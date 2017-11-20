use Mix.Config

# We don"t run a server during test. If one is required,
# you can enable the server option below.
config :moyashi, MoyashiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :moyashi, Moyashi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: System.get_env("PHX_TESTDB_PASSWORD"),
  database: "moyashi_test",
  hostname: "pg",
  pool: Ecto.Adapters.SQL.Sandbox
