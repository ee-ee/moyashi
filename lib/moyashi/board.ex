defmodule Moyashi.Board do
  use Ecto.Schema
  import Ecto.Changeset
  alias Moyashi.Board


  schema "boards" do
    field :slug, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Board{} = board, attrs) do
    board
    |> cast(attrs, [:title, :slug])
    |> validate_required([:title, :slug])
  end
end
