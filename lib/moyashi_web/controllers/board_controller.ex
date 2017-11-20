defmodule MoyashiWeb.API.BoardController do
	use MoyashiWeb, :controller

	def index(conn, _params) do
		boards = %{}
		render conn, "index.json", boards: boards
	end
end