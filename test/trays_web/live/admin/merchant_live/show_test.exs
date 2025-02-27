defmodule TraysWeb.Admin.MerchantLive.ShowTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.MerchantFixtures
  alias Trays.AccountsFixtures

  @route "/en/admin/merchants"

  test "should show the details for a Merchant", %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)

    {:ok, _view, html} = live(conn, "#{@route}/#{merchant.id}")
    assert html =~ merchant.name
    assert html =~ merchant.description
    assert html =~ merchant.food_category
    assert html =~ merchant.contact_phone
    assert html =~ user.name
    assert html =~ user.email
  end

  test "should navigate to create new Merchant Location", %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)

    {:ok, view, _html} = live(conn, "#{@route}/#{merchant.id}")
    {:ok, _, html} = view
      |> element("#new_location_btn")
      |> render_click()
      |> follow_redirect(conn)
    assert html =~ "New Merchant Location"
  end
end
