defmodule Moyashi.Repo.Migrations.CreateBoard do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :slug, :string
      add :title, :string

      timestamps
    end

  end
end
