defmodule Moyashi.ThreadController do
  use Moyashi.Web, :controller

  alias Moyashi.Thread

  def index(conn, %{"board_id" => board_id}) do
    query = from t in Thread,
          where: t.board_id == ^board_id,
         select: t
    threads = Repo.all(query)

    render(conn, "index.html", threads: threads)
  end
end
