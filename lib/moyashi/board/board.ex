defmodule Moyashi.Core.Board do
  alias Moyashi.Repo
  alias Moyashi.Board

  def create_board(%{} = board) do
    %Board{}
    |> Board.changeset(board)
    |> Repo.insert()
  end

  def get_board(slug) do
    Repo.get_by(Board, slug: slug)
  end
end
