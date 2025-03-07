defmodule TraysWeb.Admin.MerchantLive.ShowTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.MerchantFixtures
  alias Trays.MerchantLocationFixtures
  alias Trays.AccountsFixtures

  @route "/en/admin/merchants"

  setup %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)
    %{conn: log_in_user(conn, user), user: user, merchant: merchant}
  end


  test "should show the details for a Merchant", %{conn: conn, user: user, merchant: merchant} do
    {:ok, _view, html} = live(conn, "#{@route}/#{merchant.id}")
    assert html =~ merchant.name
    assert html =~ merchant.description
    assert html =~ merchant.food_category
    assert html =~ user.phone_number
    assert html =~ user.name
    assert html =~ user.email
  end

  test "should navigate to create new Merchant Location", %{conn: conn, merchant: merchant} do
    {:ok, view, _html} = live(conn, "#{@route}/#{merchant.id}")

    {:ok, _, html} =
      view
      |> element("#new_location_btn")
      |> render_click()
      |> follow_redirect(conn)

    assert html =~ "New Merchant Location"
  end

  test "should display locations of the merchant", %{conn: conn, merchant: merchant, user: user} do
    merchant_location = MerchantLocationFixtures.merchant_location_fixture(merchant, %{contact_id: user.id})

    {:ok, _view, html} = live(conn, "#{@route}/#{merchant.id}")
    assert html =~ merchant_location.street1
    assert html =~ merchant_location.city
    assert html =~ merchant_location.province
    assert html =~ merchant_location.country
  end
end
