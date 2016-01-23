defmodule Moyashi.PageController do
  use Moyashi.Web, :controller
  alias Moyashi.Board

  def index(conn, _params) do
    board = Repo.all(Board)
    render(conn, "index.html", board: board)
  end
end
