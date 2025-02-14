defmodule TraysWeb.TraysLive.IndexTest do
  use TraysWeb.ConnCase

  test "should load the main trays page", %{conn: conn} do
    conn = get(conn, "/en/trays")
    assert html_response(conn, 200) =~ "Trays"
  end
end
