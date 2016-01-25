defmodule Moyashi.ThreadController do
  use Moyashi.Web, :controller

  alias Moyashi.Thread
  alias Moyashi.Board

  def index(conn, %{"board_id" => board_id}) do
    boards = Repo.all(Board)
    query = from t in Thread,
          where: t.board_id == ^board_id,
         select: t
    threads = Repo.all(query)
    board = Repo.get!(Board, board_id)

    render(conn, "index.html", threads: threads, board: board, boards: boards)
  end
end
