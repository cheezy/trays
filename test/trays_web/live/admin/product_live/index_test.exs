defmodule TraysWeb.Admin.ProductLive.IndexTest do
  use TraysWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Trays.MerchantFixtures
  alias Trays.AccountsFixtures
  alias Trays.ProductFixtures

  setup %{conn: conn} do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)
    %{conn: log_in_user(conn, user), user: user, merchant: merchant}
  end

  test "should load the page and display products", %{conn: conn, user: user, merchant: merchant} do
    product = ProductFixtures.product_fixture(%{merchant_id: merchant.id})

    {:ok, _view, html} = live(conn, "/en/admin/merchants/#{merchant.id}/products")
    assert html =~ "Products for #{merchant.name}"
    assert html =~ product.name
    assert html =~ product.category
    assert html =~ Money.to_string(product.price, symbol: false)
  end
end
