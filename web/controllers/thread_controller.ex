defmodule Moyashi.ThreadController do
  use Moyashi.Web, :controller

  alias Moyashi.Post
  alias Moyashi.Board
  alias Mogrify
  import Ecto.Query
  use Timex

  def index(conn, %{"board_slug" => board_slug}) do
    changeset = Post.changeset(%Post{})

    boards = Repo.all(Board)
    board = Board
    |> Repo.get_by(slug: board_slug)

    # TODO this is ugly and inefficient
    ops_query = from p in Post,
        where: p.board_id == ^board.id,
        where: is_nil(p.parent_id),
        order_by: [desc: p.bumped_at],
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

    file_upload = post_params["form"]

    unless file_upload === nil do
      image = Mogrify.open(file_upload.path)
      |> Mogrify.copy
      |> Mogrify.format("jpg")
      |> Mogrify.resize("500x500")
      |> Mogrify.save("files/" <> board_slug <> "/" <> to_string(:os.system_time(:milli_seconds)) <> ".jpg")
      attach = image.path
    else
      attach = nil
    end

    changeset = Post.changeset(%Post{board_id: board.id, attach: attach}, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        if post_params["parent_id"] === nil do
          id = _post.id
        else
          id = post_params["parent_id"]

          # Update parent's bumped_at
          parent_thread = Repo.get!(Post, id)
          parent_thread = Ecto.Changeset.change parent_thread, bumped_at: Ecto.DateTime.utc

          {:ok, _} = Repo.update parent_thread
        end

        channel = "threads:" <> board_slug <> "/" <> to_string(id)
        Moyashi.Endpoint.broadcast! channel, "new_post",
        %{id: _post.id,
          name: _post.name,
          body: _post.body,
          attach: attach,
          inserted_at: _post.inserted_at}

        conn
        |> put_flash(:info, "Post created  successfully.")
        |> redirect(to: thread_path(conn, :show, board_slug, id) <> "#" <> to_string(_post.id))
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
