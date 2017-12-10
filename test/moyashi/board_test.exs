defmodule Moyashi.Board.BoardTest do
  use ExUnit.Case, async: true
  alias Moyashi.Core
  alias Moyashi.Board
  alias Moyashi.Repo

  @create_board_attrs %{slug: "test", title: "Just a test board"}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  defp fixture(:board, attrs) do
    {:ok, board} = Core.Board.create_board(attrs)
    board
  end

  test "create_board/1 with valid data creates a board" do
    board = fixture(:board, @create_board_attrs)

    assert board.slug == @create_board_attrs.slug
    assert board.title == @create_board_attrs.title
  end

  test "get_board/1 returns the board with the given slug" do
    board = fixture(:board, @create_board_attrs)
    assert Core.Board.get_board(board.slug) == board
  end
end
