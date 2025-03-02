defmodule TraysWeb.Admin.MerchantLive.IndexTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.Repo
  alias Trays.Merchant
  alias Trays.MerchantFixtures
  alias Trays.AccountsFixtures

  @route "/en/admin/merchants"

  test "should load the main index page and display merchants", %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)

    {:ok, _view, html} = live(conn, @route)
    assert html =~ "Listing Merchants"
    assert html =~ merchant.name
    assert html =~ merchant.description
    assert html =~ user.name
    assert html =~ merchant.contact_phone
  end

  test "should navigate to create a new Merchant", %{conn: conn} do
    {:ok, view, _html} = live(conn, @route)

    {:ok, _, html} =
      view
      |> element("#new_merchant_btn")
      |> render_click()
      |> follow_redirect(conn)

    assert html =~ "New Merchant"
  end

  test "should navigate to edit an existing Merchant", %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    MerchantFixtures.merchant_fixture_with_user(user)

    {:ok, view, _html} = live(conn, @route)

    {:ok, _, html} =
      view
      |> element(".edit-merchant")
      |> render_click()
      |> follow_redirect(conn)

    assert html =~ "Edit Merchant"
  end

  test "should delete an existing Merchant", %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)

    {:ok, view, _html} = live(conn, @route)

    view
    |> element(".delete-merchant")
    |> render_click()

    assert Repo.get(Merchant, merchant.id) == nil
  end
end
