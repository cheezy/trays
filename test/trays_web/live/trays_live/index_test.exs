defmodule TraysWeb.TraysLive.IndexTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures

  @route "/en/trays"

  test "should load the main trays page", %{conn: conn} do
    conn = get(conn, @route)
    assert html_response(conn, 200) =~ "Trays"
  end

  test "should show information about merchants in the system", %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)

    {:ok, _view, html} = live(conn, @route)
    assert html =~ merchant.name
    assert html =~ merchant.description
    assert html =~ merchant.category
  end
end
