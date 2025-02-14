defmodule TraysWeb.PageControllerTest do
  use TraysWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert redirected_to(conn) == ~p"/en/"
  end
end
