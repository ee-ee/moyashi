defmodule Moyashi do
end

defmodule Moyashi.Router do
  use Trot.Router

  get "/" do
    {:ok, %{hello: "world"}, %{"Content-Type" => "application/json"}}
  end

  import_routes Trot.NotFound
end
