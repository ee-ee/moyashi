defmodule Moyashi.Repo.Migrations.AddThumb do
  use Ecto.Migration

  def change do
    alter table(:posts) do
        add :thumb, :string
    end
  end
end
