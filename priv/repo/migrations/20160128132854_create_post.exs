defmodule Moyashi.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :name, :string
      add :email, :string
      add :body, :text
      add :attach, :string
      add :board_id, references(:boards, on_delete: :nothing)
      add :parent_id, :integer
      add :bumped_at, :datetime

      timestamps
    end
    create index(:posts, [:board_id])

  end
end
