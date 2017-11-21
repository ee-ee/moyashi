defmodule MoyashiWeb.BoardControllerTest do
  use MoyashiWeb.ConnCase

  test "#index responds with all boards", %{conn: conn} do
    boards = Enum.map([1..10], fn _ -> insert(:board) end)

    response = conn
    |> get(board_path(conn, :index))
    |> json_response(200)

    assert response == render_json("index.json", boards: boards)
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    MoyashiWeb.API.BoardView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end
end
