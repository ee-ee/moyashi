defmodule Moyashi.ThreadChannel do
  use Phoenix.Channel

  def join("threads:" <> _thread_id, _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_post", %{"body" => body}, socket) do
    broadcast! socket, "new_post", %{body: body}
    {:noreply, socket}
  end

  def handle_out("new_post", payload, socket) do
    push socket, "new_post", payload
    {:noreply, socket}
  end
end
