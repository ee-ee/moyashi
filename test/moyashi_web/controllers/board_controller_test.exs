defmodule MoyashiWeb.BoardControllerTest do
  use MoyashiWeb.ConnCase

  test "#index renders a list of boards" do
    conn = build_conn()
    boards = Enum.map([1..10], fn -> insert(:board) end)

    conn = get conn, board_path(conn, :index)

    assert json_response(conn, 200) == render_json("index.json", boards: boards)
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    MoyashiWeb.API.BoardView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end
end
