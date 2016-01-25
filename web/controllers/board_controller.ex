defmodule Moyashi.BoardController do
  use Moyashi.Web, :controller

  alias Moyashi.Board

  plug :scrub_params, "board" when action in [:create, :update]

  def index(conn, _params) do
    boards = Repo.all(Board)
    render(conn, "index.html", boards: boards)
  end

  def new(conn, _params) do
    boards = Repo.all(Board)
    changeset = Board.changeset(%Board{})
    render(conn, "new.html", changeset: changeset, boards: boards)
  end

  def create(conn, %{"board" => board_params}) do
    changeset = Board.changeset(%Board{}, board_params)

    case Repo.insert(changeset) do
      {:ok, _board} ->
        conn
        |> put_flash(:info, "Board created successfully.")
        |> redirect(to: board_path(conn, :index))
      {:error, changeset} ->
        boards = Repo.all(Board)
        render(conn, "new.html", changeset: changeset, boards: boards)
    end
  end

  def show(conn, %{"slug" => slug}) do
    boards = Repo.all(Board)
    board = Repo.get_by!(Board, slug: slug)
    render(conn, "show.html", board: board, boards: boards)
  end

  def edit(conn, %{"slug" => slug}) do
    boards = Repo.all(Board)
    board = Repo.get_by!(Board, slug: slug)
    changeset = Board.changeset(board)
    render(conn, "edit.html", board: board, changeset: changeset, boards: boards)
  end

  def update(conn, %{"slug" => slug, "board" => board_params}) do
    board = Repo.get_by!(Board, slug: slug)
    changeset = Board.changeset(board, board_params)

    case Repo.update(changeset) do
      {:ok, board} ->
        conn
        |> put_flash(:info, "Board updated successfully.")
        |> redirect(to: board_path(conn, :show, board))
      {:error, changeset} ->
        boards = Repo.all(Board)
        render(conn, "edit.html", board: board, changeset: changeset, boards: boards)
    end
  end

  def delete(conn, %{"slug" => slug}) do
    board = Repo.get_by!(Board, slug: slug)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(board)

    conn
    |> put_flash(:info, "Board deleted successfully.")
    |> redirect(to: board_path(conn, :index))
  end
end
