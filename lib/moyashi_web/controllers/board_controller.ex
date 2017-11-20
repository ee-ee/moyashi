defmodule MoyashiWeb.API.BoardController do
	use MoyashiWeb, :controller
	
	alias Moyashi.{Repo,Board}

	def index(conn, _params) do
		boards = Repo.all(Board)
		render conn, "index.json", boards: boards
	end
end