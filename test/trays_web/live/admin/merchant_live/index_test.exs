defmodule TraysWeb.Admin.MerchantLive.IndexTest do
  use TraysWeb.ConnCase
    

  test "should load the main index page", %{conn: conn} do
    conn = get(conn, "/en/admin/merchants")
    assert html_response(conn, 200) =~ "Listing Merchants"
  end

 end