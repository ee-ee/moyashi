defmodule MoyashiWeb.Router do
  use MoyashiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MoyashiWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", MoyashiWeb.API do
    pipe_through :api

    resources "/boards", BoardController, only: [:index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", MoyashiWeb do
  #   pipe_through :api
  # end
end
