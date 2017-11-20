defmodule MoyashiWeb.Api.BoardController do
	use MoyashiWeb, :controller

	def index(conn, _params) do
		boards = %{}
		render conn, "index.json", boards
	end
end