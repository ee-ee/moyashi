defmodule Moyashi.ThreadController do
  use Moyashi.Web, :controller

  alias Moyashi.Thread
  alias Moyashi.Board
  import Ecto.Query

  def index(conn, %{"board_slug" => board_slug}) do
    changeset = Thread.changeset(%Thread{})

    boards = Repo.all(Board)
    board = Board
    |> Repo.get_by(slug: board_slug)

    threads = Thread
    |> where(board_id: ^board.id)
    |> Repo.all

    render(conn, "index.html",
        boards: boards,
        board: board,
        threads: threads,
        changeset: changeset)
  end

  def new(conn, _params) do
    boards = Repo.all(Board)
    threads = Repo.all(Thread)
    changeset = Thread.changeset(%Thread{})

    render(conn, "new.html", changeset: changeset, boards: boards, threads: threads)
  end

  def create(conn, %{"board_slug" => board_slug, "thread" => thread_params}) do
    boards = Repo.all(Board)
    board = Board
    |> Repo.get_by(slug: board_slug)

    changeset = Thread.changeset(%Thread{board_id: board.id}, thread_params)

    case Repo.insert(changeset) do
      {:ok, _thread} ->
        conn
        |> put_flash(:info, "Thread created  successfully.")
        |> redirect(to: thread_path(conn, :show, board_slug, _thread.id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, boards: boards)
    end
  end

  def show(conn, %{"board_slug" => board_slug, "thread_id" => id}) do
    boards = Repo.all(Board)
    board = Board
    |> Repo.get_by(slug: board_slug)
    thread = Repo.get_by!(Thread, id: id)
    render(conn, "show.html", board: board, boards: boards, thread: thread)
  end
end
