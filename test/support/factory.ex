defmodule Moyashi.Factory do
    use ExMachina.Ecto, repo: Moyashi.Repo

    def board_factory do
        %Moyashi.Board{
            title: "Board's title",
            slug: "Board's slug"
        }
    end
end