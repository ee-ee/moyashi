defmodule Moyashi.ThreadController do
  use Moyashi.Web, :controller

  alias Moyashi.Post
  alias Moyashi.Board
  import Ecto.Query

  def index(conn, %{"board_slug" => board_slug}) do
    changeset = Post.changeset(%Post{})

    boards = Repo.all(Board)
    board = Board
    |> Repo.get_by(slug: board_slug)

    # TODO this is ugly and inefficient
    ops_query = from p in Post,
        where: p.board_id == ^board.id,
        where: is_nil(p.parent_id),
        limit: 10
    ops = Repo.all(ops_query)

    threads = []
    threads = for op <- ops do
        thread = [op]
        replies_query = from p in Post,
            where: p.parent_id == ^op.id,
            order_by: [desc: p.inserted_at],
            limit: 3
        replies = Repo.all(replies_query)
        replies = Enum.reverse(replies)
        thread = thread ++ replies
        threads = threads ++ thread
    end

    render(conn, "index.html",
        boards: boards,
        board: board,
        threads: threads,
        changeset: changeset)
  end

  def new(conn, _params) do
    boards = Repo.all(Board)
    threads = Repo.all(Post)
    changeset = Post.changeset(%Post{})

    render(conn, "new.html", changeset: changeset, boards: boards, threads: threads)
  end

  def create(conn, %{"board_slug" => board_slug, "post" => post_params}) do
    boards = Repo.all(Board)
    board = Board
    |> Repo.get_by(slug: board_slug)

    changeset = Post.changeset(%Post{board_id: board.id}, post_params)

    case Repo.insert(changeset) do
      {:ok, _thread} ->
        if post_params["parent_id"] === nil do
          id = _thread.id
        else
          id = post_params["parent_id"]
        end

        conn
        |> put_flash(:info, "Post created  successfully.")
        |> redirect(to: thread_path(conn, :show, board_slug, id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, boards: boards)
    end
  end

  def show(conn, %{"board_slug" => board_slug, "thread_id" => id}) do
    changeset = Post.changeset(%Post{})
    boards = Repo.all(Board)
    board = Board
    |> Repo.get_by(slug: board_slug)

    thread_query = from p in Post,
        where: p.id == ^id or p.parent_id == ^id
    thread = Repo.all(thread_query)

    render(conn, "show.html",
        boards: boards,
        board: board,
        thread: thread,
        changeset: changeset)
  end
end
