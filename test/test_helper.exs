ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Moyashi.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Moyashi.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Moyashi.Repo)

