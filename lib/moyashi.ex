defmodule Moyashi do
end

defmodule Moyashi.Router.Home do
  use Maru.Router

  get do
    conn
    |> json(%{hello: :world})
  end

end

defmodule Moyashi.Router.Board do
end

  namespace :boards do
    params do

    end
end

defmodule Moyashi.API do
  use Maru.Router

  mount Moyashi.Router.Home

  rescue_from :all do
    conn
    |> put_status(500)
    |> text("Server Error")
  end
end
