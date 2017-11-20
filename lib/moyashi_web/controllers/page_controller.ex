defmodule MoyashiWeb.PageController do
  use MoyashiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
