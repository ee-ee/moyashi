defmodule Moyashi.PageController do
  use Moyashi.Web, :controller
  alias Moyashi.Board

  def index(conn, _params) do
    boards = Repo.all(Board)
    render(conn, "index.html", boards: boards)
  end
end
