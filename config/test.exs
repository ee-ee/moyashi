use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :moyashi, Moyashi.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :moyashi, Moyashi.Repo,
  adapter: Sqlite.Ecto,
  database: "moyashi.sqlite3"
