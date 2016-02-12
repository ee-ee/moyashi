defmodule Moyashi.ThreadView do
  use Moyashi.Web, :view

  def pages(thread_count) do
    lastpage = round(Float.ceil(thread_count / 10))
    # Empty board fix
    if lastpage === 0 do
      lastpage = 1
    end
    Enum.to_list(1 .. lastpage)
  end

  def filter_one(page) do
    if page != 1 do
        to_string(page)
    else
        ""
    end
  end
end
