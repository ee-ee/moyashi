defmodule MoyashiWeb.BoardControllerTest do
    use MoyashiWeb.ConnCase

    test "#index renders a list of boards" do
        conn = build_conn()
        board = insert(:board)

        conn = get conn, board_path(conn, :index)

        assert json_response(conn, 200) == [
            %{
                "title" => board.title,
                "slug" => board.slug
            }
        ]
    end
end