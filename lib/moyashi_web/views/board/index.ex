defmodule MoyashiWeb.API.BoardView do
    use MoyashiWeb, :view
    alias MoyashiWeb.API.BoardView

    def render("index.json", %{boards: boards}) do
        #Enum.map(boards, &board_json/1)
      render_many(boards, BoardView, "board.json")
    end

    def render("board.json", %{board: board}) do
      %{title: board.title, slug: board.slug}
    end
end
