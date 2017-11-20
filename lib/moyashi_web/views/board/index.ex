defmodule MoyashiWeb.API.BoardView do
    use MoyashiWeb, :view

    def render("index.json", %{boards: boards}) do
        Enum.map(boards, &board_json/1)
    end

    defp board_json(board) do
        %{
            title: board.title,
            slug: board.slug
        }
    end
end