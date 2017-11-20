defmodule Moyashi.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :title, :string
      add :slug, :string

      timestamps()
    end

  end
end
