defmodule Moyashi.ThreadController do
  use Moyashi.Web, :controller

  alias Moyashi.Thread
  alias Moyashi.Board
  import Ecto.Query

  def index(conn, %{"board_slug" => board_slug}) do
    boards = Repo.all(Board)
    board = Board
    |> Repo.get_by(slug: board_slug)

    threads = Thread
    |> where(board_id: ^board.id)
    |> Repo.all

    render(conn, "index.html", boards: boards, board: board, threads: threads)
  end

  def new(conn, _params) do
    threads = Repo.all(Thread)
    changeset = Thread.changeset(%Thread{})

    render(conn, "new.html", changeset: changeset, threads: threads)
  end

  def create(conn, %{"board_slug" => board_slug, "thread" => thread_params}) do
    board = Board
    |> Repo.get_by(slug: board_slug)

    changeset = Thread.changeset(%Thread{board_id: board.id}, thread_params)

    case Repo.insert(changeset) do
      {:ok, _thread} ->
        conn
        |> put_flash(:info, "Thread created  successfully.")
        |> redirect(to: board_thread_path(conn, :index, board_slug))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


end
