defmodule Moyashi.ThreadControllerTest do
  use Moyashi.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Moyashi"
  end
end
